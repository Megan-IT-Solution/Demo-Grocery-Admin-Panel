import 'dart:html' as html;
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../constants/custom_msgs.dart';
import '../models/banner_model.dart';
import '../models/coupon_model.dart';
import 'loading_controller.dart';

class PromotionController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = const Uuid();

  List<BannerModel> banners = [];
  bool isUploading = false;
  bool isLoadingBanners = true;
  DateTime? _expireAt;

  // Coupon controllers
  final TextEditingController couponCodeController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController notificationController = TextEditingController();

  DateTime? get expireAt => _expireAt;
  set expireAt(DateTime? date) {
    _expireAt = date;
    notifyListeners();
  }

  // Fetch banners from Firestore
  Future<void> fetchOldBanners() async {
    isLoadingBanners = true;
    notifyListeners();
    try {
      final snapshot =
          await _firestore.collection('banners').orderBy('order').get();
      banners =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return BannerModel(
              id: doc.id,
              imageUrl: data['url'] as String?,
              storagePath: data['storagePath'] as String?,
            );
          }).toList();
    } catch (e) {
      debugPrint("Error fetching banners: $e");
    } finally {
      isLoadingBanners = false;
      notifyListeners();
    }
  }

  // Pick banners from file input
  Future<void> pickMultipleBanners() async {
    final uploadInput =
        html.FileUploadInputElement()
          ..accept = 'image/*'
          ..multiple = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files == null || files.isEmpty) return;

      final availableSlots = 4 - banners.length;
      if (availableSlots <= 0) return;

      final filesToAdd =
          files.length > availableSlots
              ? files.sublist(0, availableSlots)
              : files;

      for (final file in filesToAdd) {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        await reader.onLoadEnd.first;

        final Uint8List? imageBytes =
            reader.result != null ? reader.result as Uint8List : null;

        banners.add(BannerModel(localImage: imageBytes, localFile: file));
      }
      notifyListeners();
    });
  }

  // Remove a banner and delete from Firebase if needed
  Future<void> removeBanner(int index) async {
    if (index < 0 || index >= banners.length) return;

    try {
      final banner = banners[index];

      if (banner.id != null) {
        await _firestore.collection('banners').doc(banner.id).delete();

        if (banner.storagePath != null) {
          try {
            await _storage.ref(banner.storagePath!).delete();
          } catch (e) {
            debugPrint("Error deleting from storage: $e");
          }
        }
      }

      banners.removeAt(index);
      notifyListeners();

      await _updateBannerOrders();
    } catch (e) {
      debugPrint("Error removing banner: $e");
    }
  }

  // Reorder banners locally and update Firestore
  Future<void> reorderBanners(int oldIndex, int newIndex) async {
    if (oldIndex < 0 ||
        oldIndex >= banners.length ||
        newIndex < 0 ||
        newIndex >= banners.length)
      return;

    final item = banners.removeAt(oldIndex);
    banners.insert(newIndex > oldIndex ? newIndex - 1 : newIndex, item);
    notifyListeners();

    await _updateBannerOrders();
  }

  // Update the order field for existing banners
  Future<void> _updateBannerOrders() async {
    try {
      final batch = _firestore.batch();
      for (int i = 0; i < banners.length; i++) {
        if (banners[i].id != null) {
          final docRef = _firestore.collection('banners').doc(banners[i].id);
          batch.update(docRef, {'order': i});
        }
      }
      await batch.commit();
    } catch (e) {
      debugPrint("Error updating banner orders: $e");
    }
  }

  Future<void> uploadBannersToFirebase(BuildContext context) async {
    if (banners.isEmpty) {
      showCustomMsg(context, "Please upload at least 1 banner.");
      return;
    }

    isUploading = true;
    notifyListeners();

    try {
      for (int i = 0; i < banners.length; i++) {
        final banner = banners[i];

        if (banner.id != null) {
          // Update order of existing banner
          await _firestore.collection('banners').doc(banner.id).update({
            'order': i,
          });
          continue;
        }

        if (banner.localImage == null) continue;

        final storagePath = 'banners/${_uuid.v4()}.jpg';
        final ref = _storage.ref(storagePath);
        await ref.putData(banner.localImage!);
        final url = await ref.getDownloadURL();

        await _firestore.collection('banners').add({
          'url': url,
          'storagePath': storagePath,
          'order': i,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      if (!context.mounted) return;
      showCustomMsg(context, 'Banners uploaded successfully!');
      await fetchOldBanners();
    } catch (e) {
      if (!context.mounted) return;
      showCustomMsg(context, "Failed to upload banners: ${e.toString()}");
    } finally {
      isUploading = false;
      notifyListeners();
    }
  }

  Future<void> saveCoupon({
    required BuildContext context,
    required String code,
    required double discount,
    required DateTime expireAt,
  }) async {
    final loadingController = Provider.of<LoadingController>(
      context,
      listen: false,
    );

    if (code.isEmpty) {
      showCustomMsg(context, 'Please enter a coupon code');
      return;
    }

    if (code.length <= 4) {
      showCustomMsg(context, 'Coupon code must be more than 4 characters');
      return;
    }

    if (code != code.toUpperCase()) {
      showCustomMsg(context, 'Coupon code must be in uppercase');
      return;
    }

    final regex = RegExp(r'^[A-Z0-9]+$');
    if (!regex.hasMatch(code)) {
      showCustomMsg(
        context,
        'Coupon code must contain only uppercase letters and numbers (e.g., ABC123).',
      );
      return;
    }

    if (discount <= 0) {
      showCustomMsg(context, 'Please enter a valid discount percentage');
      return;
    }

    if (expireAt.isBefore(DateTime.now())) {
      showCustomMsg(context, 'Expiry date must be in the future');
      return;
    }

    try {
      loadingController.setLoading(true);

      final couponId = _uuid.v4();
      final coupon = CouponModel(
        couponId: couponId,
        couponCode: code.trim(),
        discount: discount,
        isActive: true,
        createdAt: DateTime.now(),
        expireAt: expireAt,
      );

      await _firestore.collection('coupons').doc(couponId).set(coupon.toMap());

      if (!context.mounted) return;
      showCustomMsg(context, 'Coupon saved successfully!');

      couponCodeController.clear();
      discountController.clear();
      _expireAt = null;
      notifyListeners();
    } catch (e) {
      if (!context.mounted) return;
      showCustomMsg(context, "Failed to save coupon: ${e.toString()}");
    } finally {
      loadingController.setLoading(false);
    }
  }

  void clearExpiryDate() {
    _expireAt = null;
    notifyListeners();
  }

  void clearTextInput() {
    couponCodeController.clear();
    discountController.clear();
    notificationController.clear();
    _expireAt = null;
    notifyListeners();
  }
}

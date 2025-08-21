import 'package:cloud_firestore/cloud_firestore.dart';

class QuantityOption {
  final String label;
  final double price;

  QuantityOption({required this.label, required this.price});

  factory QuantityOption.fromMap(Map<String, dynamic> map) {
    return QuantityOption(
      label: (map['label'] ?? '') as String,
      price: ((map['price'] ?? 0) as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'label': label, 'price': price};
  }
}

class ProductModel {
  final String pdtId;
  final String pdtName;
  final String description;
  final double pdtPrice;
  final String category;
  final int totalStock;
  final String taxCategory;
  final String pdtImage;
  final String status;
  final DateTime createdAt;
  final List<QuantityOption> quantities;

  ProductModel({
    required this.pdtId,
    required this.pdtName,
    required this.description,
    required this.pdtPrice,
    required this.category,
    required this.totalStock,
    required this.taxCategory,
    required this.pdtImage,
    required this.status,
    required this.createdAt,
    required this.quantities,
  });

  Map<String, dynamic> toMap() {
    return {
      'pdtId': pdtId,
      'pdtName': pdtName,
      'description': description,
      'pdtPrice': pdtPrice,
      'category': category,
      'totalStock': totalStock,
      'taxCategory': taxCategory,
      'pdtImage': pdtImage,
      'status': status,
      'createdAt': createdAt,
      'quantities': quantities.map((q) => q.toMap()).toList(),
    };
  }

  factory ProductModel.fromMap(DocumentSnapshot map) {
    final data = map.data() as Map<String, dynamic>;

    final rawQuantities = (data['quantities'] as List<dynamic>?) ?? [];
    final quantitiesList =
        rawQuantities
            .map((q) => QuantityOption.fromMap(Map<String, dynamic>.from(q)))
            .toList();

    return ProductModel(
      pdtId: data['pdtId'] as String,
      pdtName: data['pdtName'] as String,
      description: data['description'] as String,
      pdtPrice: (data['pdtPrice'] as num).toDouble(),
      category: data['category'] as String,
      totalStock: data['totalStock'] as int,
      taxCategory: data['taxCategory'] as String,
      pdtImage: data['pdtImage'] as String,
      status: data['status'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      quantities: quantitiesList,
    );
  }
}

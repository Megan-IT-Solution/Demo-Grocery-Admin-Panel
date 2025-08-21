import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/screens/side_bar/promotions/widgets/promotion_section_card.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../constants/app_colors.dart';
import '../../../../controllers/promotion_controller.dart';
import '../../../../widgets/buttons.dart';

class UploadAndDisplayBannerSection extends StatelessWidget {
  const UploadAndDisplayBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PromotionController>(context);

    return PromotionSectionCard(
      title: "1. Upload Promotional Banners",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          if (controller.isLoadingBanners)
            const Center(child: CircularProgressIndicator())
          else if (controller.banners.isEmpty)
            const Center(child: Text("No banners uploaded yet."))
          else
            SizedBox(
              height: 150,
              child: ReorderableListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.banners.length,
                onReorder: controller.reorderBanners,
                itemBuilder: (context, index) {
                  final banner = controller.banners[index];
                  return Padding(
                    key: ValueKey(banner.id ?? const Uuid().v4()),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 120,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child:
                              banner.localImage != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.memory(
                                      banner.localImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                  : banner.imageUrl != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      banner.imageUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                              controller.removeBanner(index);
                                            });
                                        return Container(
                                          color: Colors.grey.shade200,
                                          child: const Center(
                                            child: Icon(Icons.broken_image),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                  : Container(
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: Text("No Image"),
                                    ),
                                  ),
                        ),
                        Positioned(
                          top: -8,
                          right: -8,
                          child: InkWell(
                            onTap: () => controller.removeBanner(index),
                            child: const CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.close,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 10),
          Row(
            children: [
              SecondaryButton(
                title: 'Select Images',
                btnColor: AppColors.primaryColor,
                onPressed:
                    controller.banners.length < 4 && !controller.isUploading
                        ? controller.pickMultipleBanners
                        : null,
              ),
              const SizedBox(width: 20),
              controller.isUploading
                  ? const CircularProgressIndicator(strokeWidth: 2)
                  : SecondaryButton(
                    title: 'Upload Banners',
                    btnColor: AppColors.primaryColor,
                    onPressed:
                        controller.isUploading
                            ? null
                            : () => controller.uploadBannersToFirebase(context),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}

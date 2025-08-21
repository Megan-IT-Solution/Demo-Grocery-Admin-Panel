import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/screens/side_bar/widgets/side_bar_custom_list_tile.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../controllers/admin_controller.dart';
import '../../controllers/navigation_controller.dart';
import '../../controllers/pagination_controller.dart';
import '../../utils/lists.dart';

class SideBarScreen extends StatefulWidget {
  const SideBarScreen({super.key});

  @override
  State<SideBarScreen> createState() => _SideBarScreenState();
}

class _SideBarScreenState extends State<SideBarScreen> {
  @override
  void initState() {
    super.initState();
    getAdminInformation();
  }

  getAdminInformation() async {
    await Provider.of<AdminController>(
      context,
      listen: false,
    ).getAdminInformation();
  }

  @override
  Widget build(BuildContext context) {
    final navigationController = Provider.of<NavigationController>(context);

    final paginationController = Provider.of<PaginationController>(context);
    final admin = Provider.of<AdminController>(context).admin;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: AppColors.lightGrey.withValues(alpha: .5),
              child: ListView(
                children: [
                  const SizedBox(height: 37),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "GROCERY\nADMIN PANEL",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.h1.copyWith(fontSize: 13),
                    ),
                  ),
                  SizedBox(height: 05),
                  Center(
                    child: Text(
                      "Welcome: ${admin?.username}",
                      style: AppTextStyles.h1.copyWith(fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ListView.builder(
                    itemCount: sidebarTitles.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return SideBarCustomListTile(
                        onTap: () {
                          navigationController.updateSideBarIndex(index);
                          navigationController.updateClientListingIndex(0);
                          navigationController.updateCreativeListingIndex(0);
                          paginationController.reset();
                        },
                        icon: sidebarIcons[index],
                        title: sidebarTitles[index],
                        backgroundColor:
                            navigationController.currentIndex == index
                                ? AppColors.primaryColor
                                : Colors.blueGrey.withValues(alpha: 0.8),
                        textColor:
                            navigationController.currentIndex == index
                                ? AppColors.primaryWhite
                                : AppColors.primaryBlack,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: sidebarPages[navigationController.currentIndex],
          ),
        ],
      ),
    );
  }
}

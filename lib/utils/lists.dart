import '../constants/app_assets.dart';
import '../constants/app_strings.dart';
import '../screens/side_bar/categories/category_screen.dart';
import '../screens/side_bar/dashboard.dart';
import '../screens/side_bar/log_out/logout_screen.dart';
import '../screens/side_bar/notifications/notification_screen.dart';
import '../screens/side_bar/orders/orders_screens.dart';
import '../screens/side_bar/products/products_main_screen.dart';
import '../screens/side_bar/promotions/promotions_screen.dart';
import '../screens/side_bar/riders/riders_screen.dart';

final List<String> tableHeaderListOrderScreen = [
  "Order ID",
  "Customer",
  "Payment",
  "Total",
  "Date",
  "Status",
  "Show Details",
  "Actions",
];

final List sidebarIcons = [
  AppAssets.dashboard,
  'assets/icons/orders.png',
  "assets/icons/products.png",
  AppAssets.categories,
  "assets/icons/assign.png",
  "assets/icons/promotion.png",
  "assets/icons/notification.png",
  AppAssets.logout,
];

final List sidebarTitles = [
  AppStrings.dashboard,
  "Orders",
  "Products",
  "Categories",
  "Riders",
  "Promotions",
  'Notifications',
  AppStrings.logout,
];

final List sidebarPages = [
  const DashboardScreen(),
  const OrdersScreen(),
  const ProductsMainScreen(),
  const CategoryScreen(),
  const RidersScreen(),
  const PromotionScreen(),
  const NotificationScreen(),
  const LogoutScreen(),
];

List<String> unitList = [
  "Bags",
  "Box",
  "btl",
  "Gm",
  "Kg",
  "Pack",
  "Pk",
  "Pc",
  "lit",
  "ml",
];
List<String> taxCategoryList = [
  "Domestic Exempt Supplies",
  "Domestic Supplies - Profit Margin",
  "Domestic Supplies - Transfer of Right to Use",
  "Domestic Taxable Supplies",
  "Domestic Zero Rated Supplies",
];

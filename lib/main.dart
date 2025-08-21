import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:grocery_admin_panel/screens/auth/forgot_password_screen.dart';
import 'package:grocery_admin_panel/screens/auth/login_screen.dart';
import 'package:grocery_admin_panel/screens/auth/sign_up_screen.dart';
import 'package:grocery_admin_panel/screens/side_bar/side_bar_screen.dart';
import 'package:grocery_admin_panel/services/notification_services.dart';
import 'package:provider/provider.dart';

import 'constants/app_colors.dart';
import 'controllers/admin_controller.dart';
import 'controllers/category_controller.dart';
import 'controllers/image_controller.dart';
import 'controllers/loading_controller.dart';
import 'controllers/navigation_controller.dart';
import 'controllers/pagination_controller.dart';
import 'controllers/promotion_controller.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBXyphCe_y7ocyo__9rTMEwyIcNdKFsfHI',
      appId: '1:523868825106:web:2616e3b5484bc4509a5acb',
      messagingSenderId: '523868825106',
      projectId: 'grocery-6c200',
      authDomain: 'grocery-6c200.firebaseapp.com',
      storageBucket: 'grocery-6c200.firebasestorage.app',
      measurementId: 'G-4X70KPZBRR',
    ),
  );

  NotificationServices().getPermissionAndToken();
  NotificationServices().initFCMListener();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      minTextAdapt: true,
      designSize: const Size(1578, 1188),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => NavigationController()),
            ChangeNotifierProvider(create: (_) => AdminController()),
            ChangeNotifierProvider(create: (_) => LoadingController()),
            ChangeNotifierProvider(create: (_) => ImageController()),
            ChangeNotifierProvider(create: (_) => CategoryController()),
            ChangeNotifierProvider(create: (_) => PaginationController()),
            ChangeNotifierProvider(create: (_) => PromotionController()),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.primaryBackground,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryColor,
              ),
              useMaterial3: false,
            ),
            initialRoute: '/',
            getPages: [
              GetPage(name: '/', page: () => const LoginScreen()),
              GetPage(name: '/signUp', page: () => const SignUpScreen()),
              GetPage(
                name: '/forgotPassword',
                page: () => const ForgotPasswordScreen(),
              ),
              GetPage(
                name: '/sideBarScreen',
                page: () => const SideBarScreen(),
              ),
            ],
          ),
        );
      },
    );
  }
}

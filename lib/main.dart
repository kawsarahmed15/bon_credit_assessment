import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/authentication/domain/controllers/auth_controller.dart';
import 'features/authentication/presentation/screens/welcome_screen.dart';
import 'features/expense_tracking/domain/controllers/expense_tracking_controller.dart';
import 'features/rewards/domain/controllers/rewards_controller.dart';
import 'features/localization/domain/controllers/localization_controller.dart';
import 'shared/screens/splash_screen.dart';
import 'shared/screens/main_navigation_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    // Initialize feature controllers
    Get.put(ExpenseTrackingController());
    Get.put(RewardsController());
    Get.put(LocalizationController());

    return ScreenUtilInit(
      designSize: const Size(
        375,
        812,
      ), // iPhone 11 Pro size for responsive design
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'BON Credit Assessment',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.dark,
          home: SafeArea(child: _buildInitialScreen(authController)),
        );
      },
    );
  }

  Widget _buildInitialScreen(AuthController authController) {
    return Obx(() {
      // If logged in, go to main app
      if (authController.isLoggedIn.value == true) {
        return MainNavigationScreen();
      }

      // If first time user, show welcome screen
      if (authController.isFirstTime.value) {
        return WelcomeScreen();
      }

      // Otherwise show splash screen (which will navigate appropriately)
      return SplashScreen();
    });
  }
}

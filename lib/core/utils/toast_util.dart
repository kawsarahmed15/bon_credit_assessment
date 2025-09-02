import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ToastUtil {
  static void showSuccess(String message, {String? title}) {
    if (Get.context == null) return; // Prevent null context errors

    Get.snackbar(
      title ?? 'Success',
      message,
      backgroundColor: const Color(0xFF10B981),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(12.w),
      borderRadius: 8.r,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      animationDuration: const Duration(milliseconds: 300),
      icon: Icon(Icons.check_circle, color: Colors.white, size: 18.sp),
      shouldIconPulse: true,
      overlayBlur: 0.5,
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static void showError(String message, {String? title}) {
    if (Get.context == null) return; // Prevent null context errors

    Get.snackbar(
      title ?? 'Error',
      message,
      backgroundColor: const Color(0xFFEF4444),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(12.w),
      borderRadius: 8.r,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      animationDuration: const Duration(milliseconds: 300),
      icon: Icon(Icons.error, color: Colors.white, size: 18.sp),
      shouldIconPulse: true,
      overlayBlur: 0.5,
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static void showWarning(String message, {String? title}) {
    if (Get.context == null) return; // Prevent null context errors

    Get.snackbar(
      title ?? 'Warning',
      message,
      backgroundColor: const Color(0xFFF59E0B),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(12.w),
      borderRadius: 8.r,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(Icons.warning, color: Colors.white, size: 24),
      shouldIconPulse: true,
      overlayBlur: 0.5,
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static void showInfo(String message, {String? title}) {
    Get.snackbar(
      title ?? 'Info',
      message,
      backgroundColor: const Color(0xFF3B82F6),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(Icons.info, color: Colors.white, size: 24),
      shouldIconPulse: true,
      overlayBlur: 0.5,
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static void showCustom({
    required String title,
    required String message,
    required Color backgroundColor,
    Color textColor = Colors.white,
    IconData? icon,
    Duration? duration,
    SnackPosition position = SnackPosition.BOTTOM,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: textColor,
      snackPosition: position,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: duration ?? const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      animationDuration: const Duration(milliseconds: 300),
      icon: icon != null ? Icon(icon, color: textColor, size: 24) : null,
      shouldIconPulse: true,
      overlayBlur: 0.5,
      snackStyle: SnackStyle.FLOATING,
    );
  }
}

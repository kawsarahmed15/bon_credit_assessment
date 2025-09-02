import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../domain/controllers/auth_controller.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('Reset Password', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blue.shade900.withOpacity(0.3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32.h),

                // Reset password icon
                Center(
                  child: Container(
                    width: 120.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade600.withOpacity(0.3),
                          Colors.purple.shade600.withOpacity(0.3),
                        ],
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1.w,
                      ),
                    ),
                    child: Icon(
                      Icons.lock_reset,
                      size: 60.sp,
                      color: Colors.white70,
                    ),
                  ),
                ),

                SizedBox(height: 32.h),

                Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 16.h),

                Text(
                  'Don\'t worry! Enter your email address below and we\'ll send you a link to reset your password.',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 48.h),

                // Email field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Address',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                        color: Colors.white.withOpacity(0.05),
                      ),
                      child: TextField(
                        controller:
                            authController.forgotPasswordEmailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter your email address',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          prefixIcon: Icon(Icons.email, color: Colors.white60),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                // Send reset link button
                Obx(
                  () => Container(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed:
                          authController.isLoading.value
                              ? null
                              : () async {
                                final success = await authController
                                    .resetPassword(
                                      authController
                                          .forgotPasswordEmailController
                                          .text,
                                    );
                                if (success) {
                                  // Show success message and navigate back after delay
                                  Future.delayed(Duration(seconds: 2), () {
                                    Get.back();
                                  });
                                }
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.r),
                        ),
                        elevation: 8,
                      ),
                      child:
                          authController.isLoading.value
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                'Send Reset Link',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                    ),
                  ),
                ),

                Spacer(),

                // Back to login
                Center(
                  child: TextButton(
                    onPressed: () => Get.off(() => LoginScreen()),
                    child: Text(
                      'Back to Login',
                      style: TextStyle(
                        color: Colors.blue.shade400,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

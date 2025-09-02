import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../domain/controllers/auth_controller.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade900,
              Colors.purple.shade900,
              Colors.black,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                // Skip intro button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: TextButton(
                      onPressed: () {
                        authController.markNotFirstTime();
                        Get.off(() => LoginScreen());
                      },
                      child: Text(
                        'Skip Intro',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // App logo
                      Container(
                        padding: EdgeInsets.all(32.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.3),
                              Colors.white.withOpacity(0.1),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 30.r,
                              spreadRadius: 10.r,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.credit_card,
                          size: 120.sp,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 48.h),

                      // App title
                      Text(
                        'BON Credit',
                        style: TextStyle(
                          fontSize: 42.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(2.w, 2.h),
                              blurRadius: 10.r,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Tagline
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Text(
                          'Your Smart Financial Companion\nManage credit cards, track expenses, and achieve financial goals',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white70,
                            height: 1.5,
                          ),
                        ),
                      ),

                      SizedBox(height: 80.h),

                      // Illustration placeholder (you can replace with actual illustration)
                      Container(
                        height: 200.h,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 40.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.1),
                              Colors.white.withOpacity(0.05),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.w,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildFeatureIcon(Icons.analytics, 'Analytics'),
                                _buildFeatureIcon(Icons.security, 'Security'),
                                _buildFeatureIcon(
                                  Icons.account_balance_wallet,
                                  'Wallet',
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'All your financial tools in one place',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom buttons
                Column(
                  children: [
                    // Get Started button
                    Container(
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: () {
                          authController.markNotFirstTime();
                          Get.to(() => SignUpScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade600,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.r),
                          ),
                          elevation: 8,
                          shadowColor: Colors.blue.shade600.withOpacity(0.5),
                        ),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Login button
                    TextButton(
                      onPressed: () {
                        authController.markNotFirstTime();
                        Get.to(() => LoginScreen());
                      },
                      child: Text(
                        'Already have an account? Log In',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Icon(icon, color: Colors.white70, size: 24.sp),
        ),
        SizedBox(height: 8.h),
        Text(label, style: TextStyle(color: Colors.white60, fontSize: 12.sp)),
      ],
    );
  }
}

// Import for SignUpScreen
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
        title: Text('Create Account', style: TextStyle(color: Colors.white)),
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

                Text(
                  'Join BON Credit',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  'Create your account to get started with smart financial management',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white70),
                ),

                SizedBox(height: 48.h),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Name field
                        _buildTextField(
                          controller: authController.nameController,
                          label: 'Full Name',
                          hint: 'Enter your full name',
                          icon: Icons.person,
                        ),

                        SizedBox(height: 24.h),

                        // Email field
                        _buildTextField(
                          controller: authController.emailController,
                          label: 'Email Address',
                          hint: 'Enter your email',
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 24.h),

                        // Password field
                        Obx(
                          () => _buildTextField(
                            controller: authController.passwordController,
                            label: 'Password',
                            hint: 'Create a password',
                            icon: Icons.lock,
                            obscureText: !authController.showPassword.value,
                            suffixIcon: IconButton(
                              icon: Icon(
                                authController.showPassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white60,
                              ),
                              onPressed:
                                  authController.togglePasswordVisibility,
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Confirm password field
                        Obx(
                          () => _buildTextField(
                            controller:
                                authController.confirmPasswordController,
                            label: 'Confirm Password',
                            hint: 'Confirm your password',
                            icon: Icons.lock_outline,
                            obscureText: !authController.showPassword.value,
                          ),
                        ),

                        SizedBox(height: 32.h),

                        // Terms and conditions
                        Text(
                          'By creating an account, you agree to our Terms of Service and Privacy Policy',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 14.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 32.h),

                        // Create account button
                        Obx(
                          () => Container(
                            width: double.infinity,
                            height: 56.h,
                            child: ElevatedButton(
                              onPressed:
                                  authController.isLoading.value
                                      ? null
                                      : () async {
                                        await authController.signUp(
                                          authController.nameController.text,
                                          authController.emailController.text,
                                          authController
                                              .passwordController
                                              .text,
                                        );
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
                                      ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                      : Text(
                                        'Create Account',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Login link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(color: Colors.white70),
                            ),
                            TextButton(
                              onPressed: () => Get.off(() => LoginScreen()),
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                  color: Colors.blue.shade400,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            color: Colors.white.withOpacity(0.05),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              prefixIcon: Icon(icon, color: Colors.white60),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

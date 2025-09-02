import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../domain/controllers/auth_controller.dart';
import 'welcome_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('Welcome Back', style: TextStyle(color: Colors.white)),
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
                  'Sign In',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  'Access your account and continue your financial journey',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white70),
                ),

                SizedBox(height: 48.h),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
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
                            hint: 'Enter your password',
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

                        SizedBox(height: 16.h),

                        // Remember me and forgot password
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                value: authController.rememberMe.value,
                                onChanged:
                                    (value) =>
                                        authController.toggleRememberMe(),
                                activeColor: Colors.blue.shade600,
                                checkColor: Colors.white,
                              ),
                            ),
                            Text(
                              'Remember me',
                              style: TextStyle(color: Colors.white70),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed:
                                  () => Get.to(() => ForgotPasswordScreen()),
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.blue.shade400),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 32.h),

                        // Sign in button
                        Obx(
                          () => Container(
                            width: double.infinity,
                            height: 56.h,
                            child: ElevatedButton(
                              onPressed:
                                  authController.isLoading.value
                                      ? null
                                      : () async {
                                        await authController.signIn(
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
                                        'Sign In',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                          ),
                        ),

                        SizedBox(height: 32.h),

                        // Divider
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.white30)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Text(
                                'OR',
                                style: TextStyle(color: Colors.white60),
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.white30)),
                          ],
                        ),

                        SizedBox(height: 32.h),

                        // Social login buttons
                        Row(
                          children: [
                            Expanded(
                              child: _buildSocialButton(
                                label: 'Google',
                                icon: Icons.g_mobiledata,
                                onPressed: () {
                                  // Implement Google sign in
                                  Get.snackbar(
                                    'Coming Soon',
                                    'Google sign-in will be available soon',
                                    backgroundColor: Colors.blue,
                                    colorText: Colors.white,
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: _buildSocialButton(
                                label: 'Apple',
                                icon: Icons.apple,
                                onPressed: () {
                                  // Implement Apple sign in
                                  Get.snackbar(
                                    'Coming Soon',
                                    'Apple sign-in will be available soon',
                                    backgroundColor: Colors.blue,
                                    colorText: Colors.white,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 24.h),

                        // Sign up link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account? ',
                              style: TextStyle(color: Colors.white70),
                            ),
                            TextButton(
                              onPressed: () => Get.off(() => SignUpScreen()),
                              child: Text(
                                'Sign Up',
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

  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 48.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.white.withOpacity(0.3)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white70),
            SizedBox(width: 8.w),
            Text(label, style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

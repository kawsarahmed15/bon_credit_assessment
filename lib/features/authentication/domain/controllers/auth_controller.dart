import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../shared/screens/main_navigation_screen.dart';
import '../../../../core/utils/toast_util.dart';
import '../../../../core/utils/popup_util.dart';

class AuthController extends GetxController {
  // Authentication state
  var isLoggedIn = false.obs;
  var isLoading = false.obs;
  var rememberMe = false.obs;
  var showPassword = false.obs;
  var isFirstTime = true.obs;

  // User data
  var currentUser = Rx<Map<String, dynamic>?>(null);

  // Form controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final forgotPasswordEmailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    checkFirstTimeUser();
    checkLoginStatus();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    forgotPasswordEmailController.dispose();
    super.onClose();
  }

  // Check if user is opening app for first time
  Future<void> checkFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    isFirstTime.value = prefs.getBool('isFirstTime') ?? true;
  }

  // Mark app as opened before
  Future<void> markNotFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    isFirstTime.value = false;
  }

  // Check if user is already logged in
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn.value) {
      // Load user data
      final userData = prefs.getString('userData');
      if (userData != null) {
        // In a real app, you'd parse the JSON
        currentUser.value = {
          'name': prefs.getString('userName') ?? 'John Doe',
          'email': prefs.getString('userEmail') ?? 'john.doe@email.com',
        };
      }
    }
  }

  // Sign up
  Future<bool> signUp(String name, String email, String password) async {
    if (!_validateSignUpForm(name, email, password)) return false;

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      // Save user data
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userName', name);
      await prefs.setString('userEmail', email);

      currentUser.value = {'name': name, 'email': email};
      isLoggedIn.value = true;

      _clearForms();

      Get.off(() => const MainNavigationScreen());
      ToastUtil.showSuccess('Account created successfully!');

      return true;
    } catch (e) {
      ToastUtil.showError('Failed to create account. Please try again.');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Sign in
  Future<bool> signIn(String email, String password) async {
    if (!_validateSignInForm(email, password)) return false;

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      // Save login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', email);

      if (rememberMe.value) {
        await prefs.setBool('rememberMe', true);
      }

      currentUser.value = {'email': email, 'name': 'John Doe'};
      isLoggedIn.value = true;

      _clearForms();

      Get.off(() => const MainNavigationScreen());
      ToastUtil.showSuccess('Successfully signed in', title: 'Welcome Back!');

      return true;
    } catch (e) {
      ToastUtil.showError('Invalid credentials. Please try again.');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Forgot password
  Future<bool> resetPassword(String email) async {
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      ToastUtil.showError('Please enter a valid email address');
      return false;
    }

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      ToastUtil.showSuccess(
        'Password reset link has been sent to your email',
        title: 'Reset Link Sent',
      );

      forgotPasswordEmailController.clear();
      return true;
    } catch (e) {
      ToastUtil.showError('Failed to send reset link. Please try again.');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userName');
    await prefs.remove('userEmail');
    await prefs.remove('rememberMe');

    currentUser.value = null;
    isLoggedIn.value = false;
    _clearForms();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  // Toggle remember me
  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  // Private methods
  bool _validateSignUpForm(String name, String email, String password) {
    if (name.isEmpty || name.length < 2) {
      ToastUtil.showError('Please enter a valid name (at least 2 characters)');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      ToastUtil.showError('Please enter a valid email address');
      return false;
    }

    if (password.length < 6) {
      ToastUtil.showError('Password must be at least 6 characters');
      return false;
    }

    if (password != confirmPasswordController.text) {
      ToastUtil.showError('Passwords do not match');
      return false;
    }

    return true;
  }

  bool _validateSignInForm(String email, String password) {
    if (!GetUtils.isEmail(email)) {
      ToastUtil.showError('Please enter a valid email address');
      return false;
    }

    if (password.isEmpty) {
      ToastUtil.showError('Please enter your password');
      return false;
    }

    return true;
  }

  void _clearForms() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    forgotPasswordEmailController.clear();
    showPassword.value = false;
    rememberMe.value = false;
  }
}

import 'package:anjapepito/features/home/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/util/app_navigation.dart';
import '../../login/views/sign_in_screen.dart';
class SignUpController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void onSignUp(BuildContext context) {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // if (username.isEmpty ||
    //     email.isEmpty ||
    //     password.isEmpty ||
    //     confirmPassword.isEmpty) {
    //   return;
    // }
    //
    // if (password != confirmPassword) {
    //   // Show password mismatch error
    //   return;
    // }

    // TODO: Implement sign up logic
    AppNavigation.pushAndClear(context, const HomePage());

  }

  void onSignUpWithGoogle(BuildContext context) {
    // TODO: Implement Google sign up
  }

  void onSignUpWithApple(BuildContext context) {
    // TODO: Implement Apple sign up
  }

  void onSignIn(BuildContext context) {
    AppNavigation.push(context, const SignInScreen());
  }

  void onPrivacyPolicyTap() {
    // launchUrl(Uri.parse('https://yourapp.com/privacy'));
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
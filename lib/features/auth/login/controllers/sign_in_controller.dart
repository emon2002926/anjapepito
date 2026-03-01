import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/util/app_navigation.dart';
import '../../../home/views/home_page.dart';
import '../../others/views/forgot_password_screen.dart';
import '../../sign_up/views/sign_up_screen.dart';
class SignInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void onSignIn(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // if (email.isEmpty || password.isEmpty) {
    //   // Show validation error
    //   return;
    // }

    AppNavigation.pushAndClear(context, const HomePage());

    // TODO: Implement sign in logic
  }

  void onForgotPassword(BuildContext context) {
    AppNavigation.push(context, const ForgotPasswordScreen());
  }

  void onSignUpWithGoogle(BuildContext context) {
    // TODO: Implement Google sign in
  }

  void onSignUpWithApple(BuildContext context) {
    // TODO: Implement Apple sign in
  }

  void onSignUp(BuildContext context) {
    AppNavigation.push(context, const SignUpScreen());
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
// ══════════════════════════════════════════════════════
// reset_password_controller.dart
// ══════════════════════════════════════════════════════

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/util/app_navigation.dart';
import '../../../../core/widgets/snakbar/custom_snackbar.dart';
import '../../login/views/sign_in_screen.dart';

class ResetPasswordController extends GetxController {
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

  void onConfirm(BuildContext context) {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (password.isEmpty) {
      CustomSnackBar.warning('Please enter a new password');
      return;
    }

    if (confirmPassword.isEmpty) {
      CustomSnackBar.warning('Please re-type your password');
      return;
    }

    if (password.length < 6) {
      CustomSnackBar.error('Password must be at least 6 characters');
      return;
    }

    if (password != confirmPassword) {
      CustomSnackBar.error('Passwords do not match');
      return;
    }

    // TODO: Implement reset password logic
    // isLoading.value = true;
    // try {
    //   await resetPassword(password);
    //   CustomSnackBar.success('Password reset successfully');
      AppNavigation.pushAndClear(context, const SignInScreen());
    // } catch (e) {
    //   CustomSnackBar.error('Failed to reset password');
    // } finally {
    //   isLoading.value = false;
    // }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

import 'package:anjapepito/core/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/util/app_navigation.dart';
import '../../../../core/util/form_validator.dart';
import '../../../../core/widgets/snakbar/custom_snackbar.dart';
import '../../sign_in/views/sign_in_screen.dart';

class ResetPasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;

  final api = Get.find<ApiServices>();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> onConfirm(String resetToken) async {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (!FormValidator.isValidPassword(password)) {
      final msg = password.length < 8
          ? 'Password must be at least 8 characters'
          : 'Password must contain at least one uppercase letter';
      CustomSnackBar.warning(msg);
      passwordFocusNode.requestFocus();
      return;
    }

    if (!FormValidator.isValidPassword(confirmPassword)) {
      final msg = password.length < 8
          ? 'Password must be at least 8 characters'
          : 'Password must contain at least one uppercase letter';
      CustomSnackBar.warning(msg);
      passwordFocusNode.requestFocus();
      return;
    }

    if (password != confirmPassword) {
      CustomSnackBar.error('Passwords do not match.');
      return;
    }

    try{
      isLoading.value = true;
      final response  = api.post(
          '/api/v1/auth/password/reset/',
        body: {
          "reset_token":resetToken,
          "new_password":password,
          "confirm_password":confirmPassword
        },
      );
       print(response);
       isLoading.value = false;
      AppNavigation.pushAndClear( const SignInScreen());


    } on HttpException {
      isLoading.value = false;
    }catch (e){
      isLoading.value = false;
    }finally{
      isLoading.value = false;
  }




  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
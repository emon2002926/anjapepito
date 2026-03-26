import 'package:anjapepito/core/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/util/app_navigation.dart';
import '../../../../core/util/form_validator.dart';
import '../../../../core/widgets/snakbar/custom_snackbar.dart';
import '../views/enter_otp_screen.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  final RxBool isLoading = false.obs;
  final api = Get.find<ApiServices>();

  Future<void> onSendOtp( ) async{
    final email = emailController.text.trim();

    if (!FormValidator.isValidEmail(email)) {
      CustomSnackBar.warning('Please enter a valid email');
      emailFocusNode.requestFocus();
      return;
    }

    isLoading.value = true;

    try {
      final response = await api.postFormData(
        '/api/v1/auth/password/reset-request/',
        fields: {
          'email': email,
        },
      );

      final message = response['message'] ?? 'OTP Sent to your email';
      isLoading.value = false;
      CustomSnackBar.success(message);

      AppNavigation.push( EnterOtpScreen(
        email: email,
        comesFromSignUp: 'password_reset',
      ));

    }
    on HttpException {
      isLoading.value = false;
    }finally {
      isLoading.value = false;
    }

  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/util/app_navigation.dart';
import '../views/enter_otp_screen.dart';
class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final RxBool isLoading = false.obs;

  void onSendOtp(BuildContext context) {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      return;
    }

    // TODO: Implement send OTP logic
    AppNavigation.push(context, const EnterOtpScreen());
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
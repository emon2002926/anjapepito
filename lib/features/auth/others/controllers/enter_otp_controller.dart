// ══════════════════════════════════════════════════════
// enter_otp_controller.dart
// ══════════════════════════════════════════════════════

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// ══════════════════════════════════════════════════════
// enter_otp_controller.dart
// ══════════════════════════════════════════════════════


import '../../../../core/util/app_navigation.dart';
import '../../../../core/widgets/snakbar/custom_snackbar.dart';
import '../views/reset_password_screen.dart';

class EnterOtpController extends GetxController {
  final otpController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxInt remainingSeconds = 22.obs;
  final RxBool canResend = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    canResend.value = false;
    remainingSeconds.value = 22;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  String get formattedTime {
    final minutes = remainingSeconds.value ~/ 60;
    final seconds = remainingSeconds.value % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void onSubmit(BuildContext context) {
    final otp = otpController.text.trim();

    if (otp.isEmpty) {
      CustomSnackBar.warning('Please enter the OTP');
      return;
    }

    if (otp.length != 6) {
      CustomSnackBar.error('OTP must be 6 digits');
      return;
    }

    // TODO: Implement OTP verification logic
    // isLoading.value = true;
    // try {
    //   await verifyOtp(otp);
    //   CustomSnackBar.success('OTP verified successfully');
      AppNavigation.push(context, const ResetPasswordScreen());
    // } catch (e) {
    //   CustomSnackBar.error('Invalid OTP. Please try again.');
    // } finally {
    //   isLoading.value = false;
    // }
  }

  void onResend() {
    if (!canResend.value) {
      CustomSnackBar.info('Please wait for the timer to expire');
      return;
    }

    // TODO: Implement resend OTP logic
    // try {
    //   await resendOtp();
    //   CustomSnackBar.success('OTP resent successfully');
    // } catch (e) {
    //   CustomSnackBar.error('Failed to resend OTP');
    // }

    CustomSnackBar.success('OTP resent to your email');
    startTimer();
  }

  @override
  void onClose() {
    otpController.dispose();
    _timer?.cancel();
    super.onClose();
  }
}
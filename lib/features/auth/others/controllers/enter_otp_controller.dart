import 'dart:async';

import 'package:anjapepito/features/auth/sign_in/views/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// ══════════════════════════════════════════════════════
// enter_otp_controller.dart
// ══════════════════════════════════════════════════════


import '../../../../core/services/api_services.dart';
import '../../../../core/util/app_navigation.dart';
import '../../../../core/widgets/snakbar/custom_snackbar.dart';
import '../views/reset_password_screen.dart';

class EnterOtpController extends GetxController {
  final otpController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxInt remainingSeconds = 60.obs;
  final RxBool canResend = false.obs;
  final RxBool isResendLoading = false.obs;
  Timer? _timer;
  final api = Get.find<ApiServices>();



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

  Future<void> onSubmit(String email, String otpType) async {
    final otp = otpController.text.trim();

    if (otp.isEmpty) {
      CustomSnackBar.warning('Please enter the OTP');
      return;
    }

    if (otp.length != 6) {
      CustomSnackBar.error('OTP must be 6 digits');
      return;
    }

    isLoading.value = true;

    try {
      dynamic response;

      if (otpType == 'password_reset') {
        response = await api.post(
          '/api/v1/auth/password/verify-reset-otp/',
          body: {
            'email': email,
            'otp_code': otp,
          },
        );

        final resetToken = response['data']['reset_token'];
        CustomSnackBar.success(response['message'] ?? 'OTP verified');
        AppNavigation.pushAndClear(ResetPasswordScreen(resetToken: resetToken));

      } else {
        // register flow — form-data
        response = await api.postFormData(
          '/api/v1/auth/verify-otp/',
          fields: {
            'email': email,
            'otp_code': otp,
            'otp_type': otpType,
          },
        );

        CustomSnackBar.success(response['message'] ?? 'Verified successfully');
        AppNavigation.pushAndClear(const SignInScreen());
      }

    } on HttpException catch (e) {
      switch (e.statusCode) {
        case 400:
          CustomSnackBar.error('Invalid or expired OTP.');
          break;
        default:
          CustomSnackBar.error('Something went wrong (${e.statusCode}).');
      }
    } catch (e) {
      CustomSnackBar.error('Network error. Please try again.');
    } finally {
      isLoading.value = false;
      otpController.clear();
    }
  }

  Future<void> onResend(String email, String otpType) async {
    if (!canResend.value) {
      CustomSnackBar.info('Please wait for the timer to expire');
      return;
    }

    isResendLoading.value = true;

    try {
      final response = await api.post(
        '/api/v1/auth/resend-otp/',
        body: {
          'email': email,
          'otp_type': otpType,
        },
      );

      otpController.clear();
      canResend.value = false;
      isResendLoading.value = false;
      CustomSnackBar.success(response['message'] ?? 'OTP resent successfully');
      startTimer();

    } on HttpException catch (e) {
      switch (e.statusCode) {
        case 400:
          CustomSnackBar.error('Invalid request.');
          break;
        default:
          CustomSnackBar.error('Something went wrong (${e.statusCode}).');
      }
    } catch (e) {
      CustomSnackBar.error('Network error. Please try again.');
    } finally {
        isResendLoading.value = false;

    }
  }
  @override
  void onClose() {
    otpController.dispose();
    _timer?.cancel();
    super.onClose();
  }
}
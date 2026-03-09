// ══════════════════════════════════════════════════════
// enter_otp_controller.dart
// ══════════════════════════════════════════════════════

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// ══════════════════════════════════════════════════════
// enter_otp_controller.dart
// ══════════════════════════════════════════════════════


import '../../../../core/services/api_services.dart';
import '../../../../core/util/app_navigation.dart';
import '../../../../core/widgets/snakbar/custom_snackbar.dart';
import '../../../home/views/home_page.dart';
import '../views/reset_password_screen.dart';

class EnterOtpController extends GetxController {
  final otpController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxInt remainingSeconds = 22.obs;
  final RxBool canResend = false.obs;
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
      final response = await api.postFormData(
        '/api/v1/auth/verify-otp/',
        fields: {
          'email': email,
          'otp_code': otp,
          'otp_type': otpType,
        },
      );

      final message = response['message'] ?? 'Verified successfully';
      isLoading.value = false;
      otpController.clear();
      CustomSnackBar.success(message);
      AppNavigation.pushAndClear(const HomePage());

    } on HttpException catch (e) {
      otpController.clear();
      switch (e.statusCode) {
        case 400:
          CustomSnackBar.error('Invalid or expired OTP.');
          break;
        default:
          CustomSnackBar.error('Something went wrong (${e.statusCode}).');
      }
    } catch (e) {
      otpController.clear();
      CustomSnackBar.error('Network error. Please try again.');
    } finally {
      otpController.clear();
      isLoading.value = false;
    }
  }

  Future<void> onResend(String email, String otpType)async {
    if (!canResend.value) {
      CustomSnackBar.info('Please wait for the timer to expire');

      try {
        final response = await api.post(
          '/api/v1/auth/resend-otp/',
          body: {
            'email': email,
            'otp_type': otpType,
          },
        );

        final message = response['message'] ?? 'Otp Resend successfully';
        isLoading.value = false;
        otpController.clear();
        CustomSnackBar.success(message);
        // AppNavigation.pushAndClear(const HomePage());

      } on HttpException catch (e) {
        otpController.clear();
        switch (e.statusCode) {
          case 400:
            CustomSnackBar.error('Invalid or expired OTP.');
            break;
          default:
            CustomSnackBar.error('Something went wrong (${e.statusCode}).');
        }
      } catch (e) {
        otpController.clear();
        CustomSnackBar.error('Network error. Please try again.');
      } finally {
        otpController.clear();
        isLoading.value = false;
      }


      return;
    }



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
import 'dart:async';
import 'package:anjapepito/features/auth/login/views/sign_in_screen.dart';
import 'package:anjapepito/features/auth/sign_up/views/sign_up_screen.dart';
import 'package:get/get.dart';
import '../../../../core/util/storage_service.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/util/app_navigation.dart';
import '../../onboarding/views/onboarding_screen.dart';

class SplashController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    Timer(const Duration(seconds: 3), () {
      String? accessToken = StorageService.accessToken;

      if (accessToken != null && accessToken.isNotEmpty) {
        AppNavigation.pushAndClear(Get.context!, SignUpScreen());

      } else {

        AppNavigation.pushAndClear(Get.context!, OnboardingScreen());
        // AppNavigation.pushAndClear(Get.context!, LoginScreen());

      }
    });
  }

}
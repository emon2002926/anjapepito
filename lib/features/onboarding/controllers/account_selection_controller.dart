import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/util/app_navigation.dart';
import '../../auth/login/views/sign_in_screen.dart';
import '../../auth/sign_up/views/sign_up_screen.dart';
class AccountSelectionController extends GetxController {
  void onCreateAccount(BuildContext context) {
    // Navigate to Sign Up screen
    AppNavigation.push(context, const SignUpScreen());
  }

  void onHaveAccount(BuildContext context) {
    // Navigate to Sign In screen
    AppNavigation.push(context, const SignInScreen());
  }

  void onPrivacyPolicyTap() {
    // Open privacy policy URL
    // launchUrl(Uri.parse('https://yourapp.com/privacy'));
  }
}
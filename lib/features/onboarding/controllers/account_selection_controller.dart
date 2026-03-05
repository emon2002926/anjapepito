import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/util/app_navigation.dart';
import '../../auth/login/views/sign_in_screen.dart';
import '../../auth/sign_up/views/sign_up_screen.dart';
import '../../profile/views/terms_page.dart';
class AccountSelectionController extends GetxController {
  void onCreateAccount(BuildContext context) {
    // Navigate to Sign Up screen
    AppNavigation.push( const SignUpScreen());
  }

  void onHaveAccount(BuildContext context) {
    // Navigate to Sign In screen
    AppNavigation.push( const SignInScreen());
  }

  void onPrivacyPolicyTap(BuildContext context) {
    // Open privacy policy URL
    AppNavigation.push(TermsPage());
  }
}
import 'package:anjapepito/features/home/views/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/util/app_navigation.dart';
import '../../auth/login/views/sign_in_screen.dart';
import '../../auth/sign_up/views/sign_up_screen.dart';
import '../../profile/views/terms_page.dart';
class AccountSelectionController extends GetxController {
  void onCreateAccount() {
    // Navigate to Sign Up screen
    AppNavigation.push( const SignUpScreen());
  }

  void onHaveAccount() {
    // Navigate to Sign In screen
    AppNavigation.push( const SignInScreen());
  }
  void exploreAsGuest() {
    // Navigate to Sign In screen
    AppNavigation.push( const HomePage());
  }

  void onPrivacyPolicyTap() {
    // Open privacy policy URL
    AppNavigation.push(TermsPage());
  }
}
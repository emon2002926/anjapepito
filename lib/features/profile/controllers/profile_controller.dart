import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ProfileController extends GetxController {
  final RxString userName = 'Andrew Garfield'.obs;
  final RxString userEmail = 'andrew_Garfield@gmail.com'.obs;
  final RxString profileImage = 'fyu'.obs; // profile image path

  void onMoreOptions(BuildContext context) {
    // TODO: Show options (edit name, change photo, etc.)
  }

  void onEditEmail(BuildContext context) {
    // TODO: Navigate to edit email
  }

  void onPrivacyPolicy(BuildContext context) {
    // TODO: Navigate to privacy policy
  }

  void onLogout(BuildContext context) {
    // TODO: Implement logout
    // StorageService.clearAll();
    // AppNavigation.pushAndClear(context, const SignInScreen());
  }
}
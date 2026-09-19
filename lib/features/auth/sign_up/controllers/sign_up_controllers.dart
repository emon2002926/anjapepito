
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/api_services.dart';
import '../../../../core/util/app_navigation.dart';
import '../../../../core/util/form_validator.dart';
import '../../../../core/widgets/snakbar/custom_snackbar.dart';
import '../../others/views/enter_otp_screen.dart';
import '../../sign_in/views/sign_in_screen.dart';
import '../models/sign_up_request_model.dart';
class SignUpController extends GetxController {
  final usernameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;
  final api = Get.find<ApiServices>();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> onSignUp(BuildContext context) async{
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    //
    if (!FormValidator.isValidEmail(email)) {
      CustomSnackBar.warning('Please enter a valid email');
      emailFocusNode.requestFocus();
      return;
    }
    if (!FormValidator.isValidPassword(password)) {
      final msg = password.length < 8
          ? 'Password must be at least 8 characters'
          : 'Password must contain at least one uppercase letter';
      CustomSnackBar.warning(msg);
      passwordFocusNode.requestFocus();
      return;
    }

    if (!FormValidator.isValidPassword(confirmPassword)) {
      final msg = password.length < 8
          ? 'Password must be at least 8 characters'
          : 'Password must contain at least one uppercase letter';
      CustomSnackBar.warning(msg);
      passwordFocusNode.requestFocus();
      return;
    }

    if (password != confirmPassword) {
      CustomSnackBar.error('Passwords do not match.');
      return;
    }


    isLoading.value = true;
    final request = SignUpRequestModel(email: email, password: password, re_type_password: confirmPassword);

    try{
      final response = await api.post('/api/v1/auth/register/',
        body: request.toJson(),
      );
      isLoading.value = false;
      print(response);
      CustomSnackBar.success(response['message']);
      AppNavigation.pushReplacement(EnterOtpScreen(email: email,comesFromSignUp: 'register',));


    }on HttpException catch (e){
      isLoading.value = false;
      switch (e.statusCode) {
        case 400:
          CustomSnackBar.error('Invalid email or password.');
          break;
        case 401:
          CustomSnackBar.error('Invalid email or password.');
          break;
        case 422:
          CustomSnackBar.warning('Please check your input.');
          break;
        default:
          CustomSnackBar.error('Something went wrong (${e.statusCode}).');
      }

    }catch(e){
      isLoading.value= false;
    }finally{
      isLoading.value = false;
    }



  }

  void onSignUpWithGoogle(BuildContext context) {
    // TODO: Implement Google sign up
  }

  void onSignUpWithApple(BuildContext context) {
    // TODO: Implement Apple sign up
  }

  void onSignIn(BuildContext context) {
    AppNavigation.push( const SignInScreen());
  }

  void onPrivacyPolicyTap() {
    // launchUrl(Uri.parse('https://yourapp.com/privacy'));
  }

  void secoundSignUP(){
    // CustomSnackBar.success(response['message']);
    AppNavigation.pushReplacement(EnterOtpScreen(email: "email",comesFromSignUp: 'register',));

  }

  @override
  void onClose() {
    usernameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
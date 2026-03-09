import 'package:anjapepito/core/services/api_services.dart';
import 'package:anjapepito/core/util/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/util/app_navigation.dart';
import '../../../../core/util/form_validator.dart';
import '../../../../core/widgets/snakbar/custom_snackbar.dart';
import '../../../home/views/home_page.dart';
import '../../others/views/forgot_password_screen.dart';
import '../../sign_up/views/sign_up_screen.dart';
import '../models/sign_in_request_model.dart';
import '../models/sign_in_response_model.dart';

class SignInController extends GetxController {
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;
  final api = Get.find<ApiServices>();


  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

    Future<void> onSignIn ()async {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();


      final isValid = FormValidator.validateAll([
        FormFieldEntry(
          value: email,
          errorMessage: 'Please enter your email',
          focusNode: emailFocusNode,
        ),
      ]);
      if (!isValid) return;

      if (!FormValidator.isValidEmail(email)) {
        CustomSnackBar.warning('Please enter a valid email');
        emailFocusNode.requestFocus();
        return;
      }

      isLoading.value = true;

      try{
        final request = SignInRequestModel(email: email, password: password);

        final response = await api.post(
          '/api/v1/auth/login/',
          body: request.toJson(),

        );
        isLoading.value = false;
        print(response);
        final loginResponse = LoginResponseModel.fromJson(response);
        StorageService.saveToken(loginResponse.data.accessToken);
        AppNavigation.pushAndClear( const HomePage());
      } on HttpException catch (e) {
        isLoading.value = false;

        switch (e.statusCode) {
          case 401:
            CustomSnackBar.error('Invalid email or password.');
            break;
          case 422:
            CustomSnackBar.warning('Please check your input.');
            break;
          default:
            CustomSnackBar.error('Something went wrong (${e.statusCode}).');
        }
      } catch (e) {
        isLoading.value = false;
        CustomSnackBar.error('Network error. Please try again.');
      } finally{
        isLoading.value = false;

      }

    }

  void onForgotPassword(BuildContext context) {
    AppNavigation.push( const ForgotPasswordScreen());
  }

  void onSignUpWithGoogle(BuildContext context) {
    // TODO: Implement Google sign in
  }

  void onSignUpWithApple(BuildContext context) {
    // TODO: Implement Apple sign in
  }

  void onSignUp(BuildContext context) {
    AppNavigation.push( const SignUpScreen());
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
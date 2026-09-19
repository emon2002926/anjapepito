import 'package:anjapepito/core/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assert_image.dart';
import '../../../../core/util/screen_size.dart';
import '../../../../core/widgets/buttons/custom_button.dart';
import '../../../../core/widgets/buttons/social_login_buttons.dart';
import '../../../../core/widgets/divider/text_divider.dart';
import '../../../../core/widgets/text/app_text.dart';
import '../../../../core/widgets/text/text_field/AppTextFiled.dart';
import '../controllers/sign_up_controllers.dart';
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final appImage = AppAssertImage.instance;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F5ED),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveSize(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.responsiveSize(8)),

              // Logo (centered)
              Center(
                child: Container(
                  width: context.responsiveSize(130),
                  height: context.responsiveSize(130),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      appImage.appLogo,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFEDE8DF),
                          child: Center(
                            child: Icon(
                              Icons.image,
                              size: context.responsiveSize(50),
                              color: Colors.grey.withOpacity(0.3),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: context.responsiveSize(16)),

              // Sign Up Title (left aligned)
              AppText(
                data: 'Sign Up',
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2D2D2D),
                useResponsiveFontSize: true,
              ),

              SizedBox(height: context.responsiveSize(20)),


              SizedBox(height: context.responsiveSize(14)),

              // Email Field
              Obx(
                ()=> AppTextField(
                  controller: controller.emailController,
                  hintText: 'Email',
                  enabled: !controller.isLoading.value,
                  keyboardType: TextInputType.emailAddress,
                  fillColor: Colors.transparent,
                  isHintTextInMiddle: true,
                  borderColor: const Color(0xFFA68978),
                  hintTextColor: const Color(0xFFA68978),
                  inputTextColor: const Color(0xFF2D2D2D),
                  focusNode: controller.emailFocusNode,
                  elevation: 0,
                  customBorderRadius: BorderRadius.circular(
                    context.responsiveSize(28),
                  ),
                ),
              ),

              SizedBox(height: context.responsiveSize(14)),

              // Password Field
              Obx(
                    () => AppTextField(
                  controller: controller.passwordController,
                  hintText: 'Password',
                  obscureText: !controller.isPasswordVisible.value,
                  fillColor: Colors.transparent,
                      borderColor: const Color(0xFFA68978),
                      hintTextColor: const Color(0xFFA68978),
                      inputTextColor: const Color(0xFF2D2D2D),
                  focusNode: controller.passwordFocusNode,
                  elevation: 0,
                      enabled: !controller.isLoading.value,
                  isHintTextInMiddle: true,
                  customBorderRadius: BorderRadius.circular(
                    context.responsiveSize(28),
                  ),
                  suffixIcon: controller.isPasswordVisible.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  onSuffixIconTap: () =>
                      controller.togglePasswordVisibility(),
                ),
              ),

              SizedBox(height: context.responsiveSize(14)),

              // Confirm Password Field
              Obx(
                    () => AppTextField(
                  controller: controller.confirmPasswordController,
                  hintText: 'Re-type your password',
                  obscureText:
                  !controller.isConfirmPasswordVisible.value,
                  fillColor: Colors.transparent,
                  focusNode: controller.confirmPasswordFocusNode,
                  enabled: !controller.isLoading.value,
                  isHintTextInMiddle: true,
                      borderColor: const Color(0xFFA68978),
                      hintTextColor: const Color(0xFFA68978),
                      inputTextColor: const Color(0xFF2D2D2D),
                  elevation: 0,
                  customBorderRadius: BorderRadius.circular(
                    context.responsiveSize(28),
                  ),
                  suffixIcon:
                  controller.isConfirmPasswordVisible.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  onSuffixIconTap: () =>
                      controller.toggleConfirmPasswordVisibility(),
                ),
              ),

              SizedBox(height: context.responsiveSize(28)),

              // Sign Up Button

              Obx(() => CustomAppButton(
                text: 'Sign up',
                onTap: () => controller.onSignUp(context),
                isLoading: controller.isLoading.value,
              )),

              // AppButton(
              //   buttonText: 'Sign up',
              //   onPressed: () => controller.onSignUp(context),
              //   fillColor: const Color(0xFF4CB8B3),
              //   textColor: Colors.white,
              //   borderRadius: 28,
              //   buttonHeight: 45,
              //   fontSize: 17,
              //   fontWeight: FontWeight.w600,
              //   isLoading: controller.isLoading.value,
              //   loadingText: "Regstrating ...",
              // ),

              SizedBox(height: context.responsiveSize(20)),
              TextDivider(),
              SizedBox(height: context.responsiveSize(20)),
              // Sign up with Google
              SocialButton(
                  onTap: () => controller.onSignUpWithApple(context),
                  text: 'Sign up with Google',
                  iconPath: appImage.googleLogo,
                  height: 45),

              SizedBox(height: context.responsiveSize(14)),

              SocialButton(
                  onTap: () => controller.onSignUpWithApple(context),
                  text: 'Sign up with Apple',
                  icon: Icons.apple,
                  height: 45),

              SizedBox(height: context.responsiveSize(20)),

              // Already have an account? Sign in
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      data: 'Already have an account?  ',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFB0B0B0),
                      useResponsiveFontSize: true,
                    ),
                    GestureDetector(
                      onTap: () => controller.onSignIn(context),
                      child: AppText(
                        data: 'Sign in',
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2D2D2D),
                        useResponsiveFontSize: true,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.responsiveSize(16)),

              // Privacy Policy
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                        'By clicking the "sign up" button, you accept the terms\nof the  ',
                        style: TextStyle(
                          fontSize: context.responsiveSize(13),
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF9E9E9E),
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () => controller.onPrivacyPolicyTap(),
                          child: Text(
                            'Privacy Policy.',
                            style: TextStyle(
                              fontSize: context.responsiveSize(13),
                              fontWeight: FontWeight.normal,
                              color: const Color(0xFF4A4A4A),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: context.responsiveSize(24)),
            ],
          ),
        ),
      ),
    );
  }


}
import 'package:anjapepito/core/constants/app_colors.dart';
import 'package:anjapepito/core/widgets/buttons/social_login_buttons.dart';
import 'package:anjapepito/core/widgets/divider/text_divider.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_assert_image.dart';
import '../../../../core/util/screen_size.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/buttons/app_button.dart';
import '../../../../core/widgets/text/app_text.dart';
import '../../../../core/widgets/text/text_field/AppTextFiled.dart';
import '../controllers/sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    final appImage = AppAssertImage.instance;

    return Scaffold(
      backgroundColor: AppColors.instance.background,
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
                  width: context.responsiveSize(140),
                  height: context.responsiveSize(140),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      appImage.appLogo,
                      fit: BoxFit.contain,
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

              // Sign In Title (left aligned)
              AppText(
                data: 'Sign In',
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2D2D2D),
                useResponsiveFontSize: true,
              ),

              SizedBox(height: context.responsiveSize(24)),

              // Email / Username Field
              AppTextField(
                controller: controller.emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                fillColor: Colors.transparent,
                borderColor: const Color(0xFFD1D1D1),
                hintTextColor: const Color(0xFFB0B0B0),
                inputTextColor: const Color(0xFF2D2D2D),
                isHintTextInMiddle: true,
                elevation: 0,
                customBorderRadius: BorderRadius.circular(
                  context.responsiveSize(28),
                ),
              ),

              SizedBox(height: context.responsiveSize(16)),

              // Password Field
              Obx(
                    () => AppTextField(
                  controller: controller.passwordController,
                  hintText: 'Password',
                  isHintTextInMiddle: true,
                  obscureText: !controller.isPasswordVisible.value,
                  fillColor: Colors.transparent,
                  borderColor: const Color(0xFFD1D1D1),
                  hintTextColor: const Color(0xFFB0B0B0),
                  inputTextColor: const Color(0xFF2D2D2D),
                  elevation: 0,
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

              SizedBox(height: context.responsiveSize(12)),

              // Forgot Password
              Center(
                child: GestureDetector(
                  onTap: () => controller.onForgotPassword(context),
                  child: AppText(
                    data: 'Forgot password?',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF2D2D2D),
                    useResponsiveFontSize: true,
                  ),
                ),
              ),

              SizedBox(height: context.responsiveSize(28)),

              AppButton(
                buttonText: 'Sign in',
                onPressed: () => controller.onSignIn(context),
                fillColor: const Color(0xFF4CB8B3),
                textColor: Colors.white,
                borderRadius: 28,
                buttonHeight: 45,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),

              SizedBox(height: context.responsiveSize(24)),

              TextDivider(),

              SizedBox(height: context.responsiveSize(24)),

              SocialButton(
                  onTap: () => controller.onSignUpWithApple(context),
                  text: 'Sign up with Google',
                  iconPath: appImage.googleLogo,
                  height: 45),


              SizedBox(height: context.responsiveSize(16)),

              SocialButton(
                  onTap: () => controller.onSignUpWithApple(context),
                  text: 'Sign up with Apple',
                  icon: Icons.apple,
                  height: 45),

              SizedBox(height: context.responsiveSize(24)),

              // Don't have an account? Sign Up
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      data: "Don't have an account?  ",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFB0B0B0),
                      useResponsiveFontSize: true,
                    ),
                    GestureDetector(
                      onTap: () => controller.onSignUp(context),
                      child: AppText(
                        data: 'Sign Up',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2D2D2D),
                        useResponsiveFontSize: true,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.responsiveSize(32)),
            ],
          ),
        ),
      ),
    );
  }
}
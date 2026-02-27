import 'package:flutter/material.dart';

import '../../../../core/constants/app_assert_image.dart';
import '../../../../core/util/screen_size.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/text/app_text.dart';
import '../../../../core/widgets/text/text_field/AppTextFiled.dart';
import '../controllers/sign_in_controller.dart';
// ══════════════════════════════════════════════════════
// sign_in_screen.dart
// ══════════════════════════════════════════════════════

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
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
                hintText: 'Email / User name',
                keyboardType: TextInputType.emailAddress,
                fillColor: Colors.transparent,
                borderColor: const Color(0xFFD1D1D1),
                hintTextColor: const Color(0xFFB0B0B0),
                inputTextColor: const Color(0xFF2D2D2D),
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

              // Sign In Button
              GestureDetector(
                onTap: () => controller.onSignIn(context),
                child: Container(
                  width: double.infinity,
                  height: context.responsiveSize(56),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CB8B3),
                    borderRadius: BorderRadius.circular(
                      context.responsiveSize(28),
                    ),
                  ),
                  child: Center(
                    child: AppText(
                      data: 'Sign in',
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      useResponsiveFontSize: true,
                    ),
                  ),
                ),
              ),

              SizedBox(height: context.responsiveSize(24)),

              // Divider with "or"
              _buildOrDivider(context),

              SizedBox(height: context.responsiveSize(24)),

              // Sign up with Google
              _buildSocialButton(
                context,
                onTap: () => controller.onSignUpWithGoogle(context),
                iconPath: 'assets/icons/google_icon.png',
                text: 'Sign up with Google',
              ),

              SizedBox(height: context.responsiveSize(16)),

              // Sign up with Apple
              _buildSocialButton(
                context,
                onTap: () => controller.onSignUpWithApple(context),
                icon: Icons.apple,
                text: 'Sign up with Apple',
              ),

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

  // ── "or" Divider ──
  Widget _buildOrDivider(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFF2D2D2D),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveSize(16),
          ),
          child: AppText(
            data: 'or',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF9E9E9E),
            useResponsiveFontSize: true,
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFF2D2D2D),
          ),
        ),
      ],
    );
  }

  // ── Social Button ──
  Widget _buildSocialButton(
      BuildContext context, {
        required VoidCallback onTap,
        required String text,
        String? iconPath,
        IconData? icon,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: context.responsiveSize(56),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            context.responsiveSize(28),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null)
              SizedBox(
                width: context.responsiveSize(24),
                height: context.responsiveSize(24),
                child: Image.asset(
                  iconPath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Text(
                        'G',
                        style: TextStyle(
                          fontSize: context.responsiveSize(18),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4285F4),
                        ),
                      ),
                    );
                  },
                ),
              )
            else if (icon != null)
              Icon(
                icon,
                color: Colors.black,
                size: context.responsiveSize(24),
              ),
            SizedBox(width: context.responsiveSize(12)),
            AppText(
              data: text,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2D2D2D),
              useResponsiveFontSize: true,
            ),
          ],
        ),
      ),
    );
  }
}
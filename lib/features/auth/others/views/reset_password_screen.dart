
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assert_image.dart';
import '../../../../core/util/screen_size.dart';
import '../../../../core/widgets/buttons/app_button.dart';
import '../../../../core/widgets/buttons/custom_button.dart';
import '../../../../core/widgets/text/app_text.dart';
import '../../../../core/widgets/text/text_field/AppTextFiled.dart';
import '../controllers/reset_password_controller.dart';
class ResetPasswordScreen extends StatelessWidget {
  final String resetToken ;
   const ResetPasswordScreen({super.key,required this.resetToken});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResetPasswordController>();
    final appImage = AppAssertImage.instance;
    return Scaffold(
      backgroundColor: const Color(0xFFF9F5ED),
      body: SafeArea(
        child: Padding(
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

              // Title (left aligned)
              AppText(
                data: 'Reset Your Password',
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2D2D2D),
                useResponsiveFontSize: true,
              ),

              SizedBox(height: context.responsiveSize(20)),

              // Password Field
              Obx(
                    () => AppTextField(
                  controller: controller.passwordController,
                  hintText: 'Password',
                  obscureText: !controller.isPasswordVisible.value,
                  enabled: !controller.isLoading.value,
                  fillColor: Colors.transparent,
                      borderColor: const Color(0xFFA68978),
                      hintTextColor: const Color(0xFFA68978),
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

              SizedBox(height: context.responsiveSize(14)),

              // Confirm Password Field
              Obx(
                    () => AppTextField(
                  controller: controller.confirmPasswordController,
                  hintText: 'Re-type your password',
                  obscureText:
                  !controller.isConfirmPasswordVisible.value,
                  fillColor: Colors.transparent,
                  enabled: !controller.isLoading.value,
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

              const Spacer(),

              // Confirm Button
              // Obx(() => AppButton(
              //       buttonText: 'Confirm',
              //     onPressed: () => controller.onConfirm(resetToken),
              //     fillColor: const Color(0xFF4CB8B3),
              //     textColor: Colors.white,
              //     borderRadius: 28,
              //     buttonHeight: 45,
              //     fontSize: 17,
              //     isLoading: controller.isLoading.value,
              //     loadingText: 'Loading...',
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              CustomAppButton(  text: 'Confirm', onTap: () => controller.onSecoundSubmit()),


              SizedBox(height: context.responsiveSize(32)),
            ],
          ),
        ),
      ),
    );
  }
}
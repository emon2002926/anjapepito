import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assert_image.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/buttons/custom_button.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/account_selection_controller.dart';
class AccountSelectionScreen extends StatelessWidget {
  const AccountSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountSelectionController());
    final appImage = AppAssertImage.instance;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F5ED),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveSize(24),
          ),
          child: Column(
            children: [
              SizedBox(height: context.responsiveSize(30)),

              // Logo Image
              Container(
                width: context.responsiveSize(160),
                height: context.responsiveSize(160),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    AppAssertImage.instance.appLogo, // your app logo asset

                  ),
                ),
              ),

              SizedBox(height: context.responsiveSize(16)),

              // Welcome Title
              AppText(
                data: 'Welcome to Atma Language',
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2D2D2D),
                useResponsiveFontSize: true,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: context.responsiveSize(32)),

              // Create an account Button
              CustomAppButton(  text: 'Create an account',
                onTap: () => controller.onCreateAccount(),
              ),

              // GestureDetector(
              //   onTap: () => controller.onCreateAccount(),
              //   child: Container(
              //     width: double.infinity,
              //     height: context.responsiveSize(56),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(
              //         context.responsiveSize(28),
              //       ),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black.withOpacity(0.04),
              //           blurRadius: 10,
              //           offset: const Offset(0, 2),
              //         ),
              //       ],
              //       border: Border.all(
              //         color: const Color(0xFFD1D1D1),
              //         width: 1,
              //       ),
              //     ),
              //     child: Center(
              //       child: AppText(
              //         data: 'Create an account',
              //         fontSize: 16,
              //         fontWeight: FontWeight.w500,
              //         color: const Color(0xFF2D2D2D),
              //         useResponsiveFontSize: true,
              //       ),
              //     ),
              //   ),
              // ),

              SizedBox(height: context.responsiveSize(16)),

              // I have an account Button
              // GestureDetector(
              //   onTap: () => controller.onHaveAccount(),
              //   child: Container(
              //     width: double.infinity,
              //     height: context.responsiveSize(56),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(
              //         context.responsiveSize(28),
              //       ),
              //       border: Border.all(
              //         color: const Color(0xFFD1D1D1),
              //         width: 1,
              //       ),
              //     ),
              //     child: Center(
              //       child: AppText(
              //         data: 'I have an account',
              //         fontSize: 16,
              //         fontWeight: FontWeight.w400,
              //         color: const Color(0xFF2D2D2D),
              //         useResponsiveFontSize: true,
              //       ),
              //     ),
              //   ),
              // ),

              CustomAppButton(  text: 'I have an account',
                onTap: () => controller.onHaveAccount(),
                image: AppAssertImage.instance.secoundBrownButtonBg,
                textColor: Color(0xFF624D40),

              ),

              SizedBox(height: context.responsiveSize(16)),
              CustomAppButton(  text: 'Explore as a guest',
                onTap: () => controller.exploreAsGuest(),
                image: AppAssertImage.instance.secoundBrownButtonBg,
                textColor: Color(0xFF624D40),

              ),

              // I have an account Button
              // GestureDetector(
              //   onTap: () => controller.exploreAsGuest(),
              //   child: Container(
              //     width: double.infinity,
              //     height: context.responsiveSize(56),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(
              //         context.responsiveSize(28),
              //       ),
              //       border: Border.all(
              //         color: const Color(0xFFD1D1D1),
              //         width: 1,
              //       ),
              //     ),
              //     child: Center(
              //       child: AppText(
              //         data: 'Explore as guest ',
              //         fontSize: 16,
              //         fontWeight: FontWeight.w400,
              //         color: const Color(0xFF2D2D2D),
              //         useResponsiveFontSize: true,
              //       ),
              //     ),
              //   ),
              // ),

              const Spacer(),

              // Privacy Policy Text
              Padding(
                padding: EdgeInsets.only(
                  bottom: context.responsiveSize(24),
                ),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'By clicking the "sign up" button, you accept the terms\nof the  ',
                        style: TextStyle(
                          fontSize: context.responsiveSize(12),
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF9E9E9E),
                        ),
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () => controller.onPrivacyPolicyTap(),
                          child: Text(
                            'Privacy Policy.',
                            style: TextStyle(
                              fontSize: context.responsiveSize(13),
                              fontWeight: FontWeight.w600,
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
            ],
          ),
        ),
      ),
    );
  }



}
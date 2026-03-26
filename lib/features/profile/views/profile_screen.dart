import 'package:anjapepito/core/constants/app_assert_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/util/screen_size.dart';
import '../../../core/widgets/app_bar/build_app_bar.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/profile_controller.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: BuildAppBar(
        title: 'Profile',
        showBackButton: true,
        onBackButtonPressed: () => Navigator.pop(context),
        titleFontSize: 20,
        fontWeight: FontWeight.w900,
        backButtonIcon: Icons.chevron_left,
        useMinimalStyle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          // ── Background Image ──
          Positioned.fill(
            child: Image.asset(
              AppAssertImage.instance.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),

          // ── Foreground Content ──
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveSize(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: context.responsiveSize(16)),

                      // Profile Header
                      Row(
                        children: [
                          // Avatar
                          Obx(
                                () => Container(
                              width: context.responsiveSize(64),
                              height: context.responsiveSize(64),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFE8E4DC),
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                child: controller.profileImage.value.isNotEmpty
                                    ? Image.asset(
                                  AppAssertImage.instance.profile,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    return _buildAvatarPlaceholder(
                                        context);
                                  },
                                )
                                    : _buildAvatarPlaceholder(context),
                              ),
                            ),
                          ),

                          SizedBox(width: context.responsiveSize(14)),

                          // Name
                          Expanded(
                            child: Obx(
                                  () => AppText(
                                data: controller.userName.value,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF2D2D2D),
                                useResponsiveFontSize: true,
                                googleFontFamily: GoogleFonts.roboto,
                              ),
                            ),
                          ),

                          // More Options
                          GestureDetector(
                            onTap: () => controller.onMoreOptions(context),
                            child: Icon(
                              Icons.more_horiz,
                              size: context.responsiveSize(24),
                              color: const Color(0xFF2D2D2D),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: context.responsiveSize(16)),

                      Container(height: 1, color: const Color(0xFFE8E4DC)),

                      SizedBox(height: context.responsiveSize(8)),

                      // Email Row
                      _buildProfileItem(
                        context,
                        icon: Icons.mail_outline,
                        title: 'Email',
                        subtitle: controller.userEmail.value,
                        trailing: GestureDetector(
                          onTap: () => controller.onEditEmail(context),
                          child: Icon(
                            Icons.edit_outlined,
                            size: context.responsiveSize(22),
                            color: const Color(0xFF2D2D2D),
                          ),
                        ),
                      ),

                      // Privacy Policy Row
                      _buildProfileItem(
                        context,
                        icon: Icons.description_outlined,
                        title: 'Privacy policy',
                        trailing: GestureDetector(
                          onTap: () => controller.onPrivacyPolicy(context),
                          child: Icon(
                            Icons.chevron_right,
                            size: context.responsiveSize(24),
                            color: const Color(0xFF2D2D2D),
                          ),
                        ),
                        onTap: () => controller.onPrivacyPolicy(context),
                      ),

                      // Log out Row
                      _buildProfileItem(
                        context,
                        icon: Icons.logout_rounded,
                        title: 'Log out',
                        onTap: () => controller.onLogout(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarPlaceholder(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset(
          AppAssertImage.instance.appLogo,
        ),
      ),
    );
  }

  Widget _buildProfileItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        String? subtitle,
        Widget? trailing,
        VoidCallback? onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.responsiveSize(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: context.responsiveSize(22),
              color: const Color(0xFF2D2D2D),
            ),
            SizedBox(width: context.responsiveSize(14)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: title,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2B2B2B),
                    useResponsiveFontSize: true,
                    googleFontFamily: GoogleFonts.roboto,
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: context.responsiveSize(2)),
                    AppText(
                      data: subtitle,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFB0B0B0),
                      useResponsiveFontSize: true,
                      googleFontFamily: GoogleFonts.roboto,
                    ),
                  ],
                ],
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}
import 'package:anjapepito/core/constants/app_assert_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/util/screen_size.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/profile_controller.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9F5ED),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveSize(20),
                vertical: context.responsiveSize(12),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.chevron_left,
                      size: context.responsiveSize(28),
                      color: const Color(0xFF2D2D2D),
                    ),
                  ),
                  Expanded(
                    child: AppText(
                      data: 'Profile',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2D2D2D),
                      useResponsiveFontSize: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: context.responsiveSize(28)),
                ],
              ),
            ),

            Container(height: 1, color: const Color(0xFFE8E4DC)),

            // Content
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
                              // controller.profileImage.value,
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

                  // Divider
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
                    color: const Color(0xFF2D2D2D),
                    useResponsiveFontSize: true,
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: context.responsiveSize(2)),
                    AppText(
                      data: subtitle,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFB0B0B0),
                      useResponsiveFontSize: true,
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
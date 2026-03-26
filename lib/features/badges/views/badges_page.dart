import 'package:flutter/material.dart';

import '../../../core/constants/app_assert_image.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/text/app_text.dart';
import 'package:get/get.dart';

import '../controllers/badges_controller.dart';
import '../models/badge_item.dart';


class BadgesPage extends StatelessWidget {
  const BadgesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BadgesController());
    final assets = AppAssertImage.instance;


    return Scaffold(
      backgroundColor:  Colors.transparent,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => controller.openDrawer(),
                    child: Image.asset(
                      assets.drawerIcon,
                      height: context.responsiveSize(28),
                      width: context.responsiveSize(28),
                      color: const Color(0xFF2D2D2D),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.onNotificationTap(context),
                    child: Image.asset(
                      assets.notificationIcon,
                      height: context.responsiveSize(28),
                      width: context.responsiveSize(28),
                      color: const Color(0xFF2D2D2D),
                    ),
                  ),
                ],
              ),
            ),

            Container(height: 1, color: const Color(0xFFE8E4DC)),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveSize(20),
                ),
                child: Column(
                  children: [
                    SizedBox(height: context.responsiveSize(16)),

                    // White Card Container
                    Container(
                      width: double.infinity,
                      padding:
                      EdgeInsets.all(context.responsiveSize(20)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          context.responsiveSize(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Title
                          AppText(
                            data: 'Badges',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2D2D2D),
                            useResponsiveFontSize: true,
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: context.responsiveSize(20)),

                          // Badges Grid
                          Obx(
                                () => GridView.builder(
                              shrinkWrap: true,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing:
                                context.responsiveSize(12),
                                mainAxisSpacing:
                                context.responsiveSize(16),
                                childAspectRatio: 0.65,
                              ),
                              itemCount: controller.badges.length,
                              itemBuilder: (context, index) {
                                return _buildBadgeItem(
                                  context,
                                  controller,
                                  controller.badges[index],
                                );
                              },
                            ),
                          ),

                          SizedBox(height: context.responsiveSize(24)),

                        ],
                      ),
                    ),

                    SizedBox(height: context.responsiveSize(100)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Badge Item ──
  Widget _buildBadgeItem(
      BuildContext context,
      BadgesController controller,
      BadgeItem badge,
      ) {
    return GestureDetector(
      onTap: () => controller.onBadgeTap(context, badge),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final iconSize = constraints.maxWidth * 0.65;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Badge Circle
              Container(
                width: iconSize,
                height: iconSize,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8E4DC),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: badge.isUnlocked
                      ? Text(
                    '🏅',
                    style: TextStyle(
                      fontSize: iconSize * 0.5,
                    ),
                  )
                      : Image.asset(
                    AppAssertImage.instance.filledLockIcon,
                    height: iconSize * 0.4,
                    width: iconSize * 0.4,
                  ),
                ),
              ),

              SizedBox(height: context.responsiveSize(6)),

              // Unit Title
              AppText(
                data: badge.title,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2D2D2D),
                useResponsiveFontSize: true,
                textAlign: TextAlign.center,
              ),

              // Subtitle
              AppText(
                data: badge.subtitle,
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF9E9E9E),
                useResponsiveFontSize: true,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: context.responsiveSize(4)),

              // Progress Line
              Container(
                height: context.responsiveSize(3),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: badge.isUnlocked
                      ? const Color(0xFFED8854)
                      : const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(
                    context.responsiveSize(2),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

}
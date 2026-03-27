import 'package:anjapepito/core/widgets/app_bar/build_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assert_image.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/notification_controller.dart';
import '../models/notification_item.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BuildAppBar(
        title: 'Notification',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 1, color: const Color(0xFFE8E4DC)),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveSize(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: context.responsiveSize(14)),

                        AppText(
                          data: 'Today',
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF000000),
                          useResponsiveFontSize: true,
                        ),

                        SizedBox(height: context.responsiveSize(12)),

                        Obx(
                              () => ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.todayNotifications.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: context.responsiveSize(16)),
                            itemBuilder: (context, index) {
                              return _buildNotificationCard(
                                context,
                                controller,
                                controller.todayNotifications[index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(
      BuildContext context,
      NotificationController controller,
      NotificationItem item,
      ) {
    return GestureDetector(
      onTap: () => controller.onNotificationTap(item),
      child: Container(
        padding: EdgeInsets.all(context.responsiveSize(14)),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFFDFDFD8),
              blurRadius: 0,
              offset: const Offset(0, 6),
            ),
          ],
          borderRadius: BorderRadius.circular(context.responsiveSize(14)),
          border: Border.all(
            color: const Color(0xFFE8E4DC),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.emoji,
              style: TextStyle(fontSize: context.responsiveSize(26)),
            ),

            SizedBox(width: context.responsiveSize(12)),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: item.title,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D2D2D),
                    useResponsiveFontSize: true,
                  ),
                  SizedBox(height: context.responsiveSize(2)),
                  AppText(
                    data: item.description,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFB0B2BE),
                    useResponsiveFontSize: true,
                  ),
                ],
              ),
            ),

            AppText(
              data: item.timeAgo,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFB0B0B0),
              useResponsiveFontSize: true,
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:anjapepito/core/widgets/Drawer/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/home_view_controller.dart';
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeViewController());

    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: const Color(0xFFF8F5F1),
      drawer: const CustomAppDrawer(),
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
                    child: Icon(
                      Icons.menu,
                      size: context.responsiveSize(28),
                      color: const Color(0xFF2D2D2D),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.onNotificationTap(context),
                    child: Icon(
                      Icons.notifications_outlined,
                      size: context.responsiveSize(28),
                      color: const Color(0xFF2D2D2D),
                    ),
                  ),
                ],
              ),
            ),

            Container(height: 1, color: const Color(0xFFE8E4DC)),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveSize(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.responsiveSize(16)),

                    // ── Yellow Banner ──
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(context.responsiveSize(20)),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE566),
                        borderRadius: BorderRadius.circular(
                          context.responsiveSize(16),
                        ),
                        border: Border.all(
                          color: const Color(0xFFFFD700),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Learn ',
                                  style: TextStyle(
                                    fontSize: context.responsiveSize(16),
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF2D2D2D),
                                  ),
                                ),
                                TextSpan(
                                  text: 'German',
                                  style: TextStyle(
                                    fontSize: context.responsiveSize(16),
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF4CB8B3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: context.responsiveSize(2)),
                          AppText(
                            data: 'naturally… with real–life dialogues!',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2D2D2D),
                            useResponsiveFontSize: true,
                          ),
                          SizedBox(height: context.responsiveSize(12)),
                          AppText(
                            data:
                            'Hi, I am Anja, your native German tutor. I help you become fluent without wasting months trying to memorize grammar rules and word lists.',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF6B6B6B),
                            useResponsiveFontSize: true,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: context.responsiveSize(24)),

                    // ── Ready for today's mission ──
                    AppText(
                      data: "Ready for today\u2019s mission ?",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2D2D2D),
                      useResponsiveFontSize: true,
                    ),

                    SizedBox(height: context.responsiveSize(14)),

                    // ── Stats Row ──
                    Obx(
                          () => Row(
                        children: [
                          // XP Card
                          Expanded(
                            child: _buildStatCard(
                              context,
                              emoji: '✦',
                              emojiColor: const Color(0xFF4CB8B3),
                              value: '${controller.totalXp.value}',
                              label: 'XP',
                              bgColor: const Color(0xFFFFF8E8),
                              barColor: const Color(0xFFD1D1D1),
                              barFill: 0.0,
                            ),
                          ),
                          SizedBox(width: context.responsiveSize(10)),
                          // Streak Card
                          Expanded(
                            child: _buildStatCard(
                              context,
                              emoji: '🔥',
                              value: '${controller.streak.value}',
                              label: 'Streak',
                              bgColor: const Color(0xFFFFF8E8),
                              barColor: const Color(0xFFD1D1D1),
                              barFill: 0.0,
                            ),
                          ),
                          SizedBox(width: context.responsiveSize(10)),
                          // Done Card
                          Expanded(
                            child: _buildStatCard(
                              context,
                              emoji: '🏆',
                              value:
                              '${controller.completedLessons.value}/${controller.totalLessons.value}',
                              label: 'Done',
                              bgColor: const Color(0xFFEAFAF5),
                              barColor: const Color(0xFF4CB8B3),
                              barFill: controller.totalLessons.value > 0
                                  ? controller.completedLessons.value /
                                  controller.totalLessons.value
                                  : 0.0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: context.responsiveSize(24)),

                    // ── Unit Header ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          data: 'Unit 1 : Colors',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2D2D2D),
                          useResponsiveFontSize: true,
                        ),
                        Obx(
                              () => AppText(
                            data:
                            '${controller.unitProgress.value.toInt()}%',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4CB8B3),
                            useResponsiveFontSize: true,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: context.responsiveSize(8)),

                    // ── Unit Progress Bar (orange/yellow) ──
                    Obx(
                          () => ClipRRect(
                        borderRadius: BorderRadius.circular(
                          context.responsiveSize(3),
                        ),
                        child: LinearProgressIndicator(
                          value: controller.unitProgress.value / 100,
                          minHeight: context.responsiveSize(6),
                          backgroundColor: const Color(0xFFE0E0E0),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFFE8A838),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: context.responsiveSize(16)),

                    // ── Lesson Cards ──
                    Obx(
                          () => ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.lessons.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: context.responsiveSize(12)),
                        itemBuilder: (context, index) {
                          return _buildLessonCard(
                            context,
                            controller,
                            controller.lessons[index],
                            index,
                          );
                        },
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

  // ── Stat Card ──
  Widget _buildStatCard(
      BuildContext context, {
        required String emoji,
        Color? emojiColor,
        required String value,
        required String label,
        required Color bgColor,
        required Color barColor,
        required double barFill,
      }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveSize(10),
        vertical: context.responsiveSize(10),
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(context.responsiveSize(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              emojiColor != null
                  ? Text(
                emoji,
                style: TextStyle(
                  fontSize: context.responsiveSize(13),
                  color: emojiColor,
                ),
              )
                  : Text(
                emoji,
                style: TextStyle(
                  fontSize: context.responsiveSize(13),
                ),
              ),
              SizedBox(width: context.responsiveSize(3)),
              Flexible(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: value,
                        style: TextStyle(
                          fontSize: context.responsiveSize(15),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2D2D2D),
                        ),
                      ),
                      TextSpan(
                        text: ' $label',
                        style: TextStyle(
                          fontSize: context.responsiveSize(12),
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFB0B0B0),
                        ),
                      ),
                    ],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: context.responsiveSize(8)),
          ClipRRect(
            borderRadius: BorderRadius.circular(
              context.responsiveSize(2),
            ),
            child: LinearProgressIndicator(
              value: barFill > 0 ? barFill : 0.0,
              minHeight: context.responsiveSize(4),
              backgroundColor: const Color(0xFFE0E0E0),
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
            ),
          ),
        ],
      ),
    );
  }

  // ── Lesson Card ──
  Widget _buildLessonCard(
      BuildContext context,
      HomeViewController controller,
      LessonItem lesson,
      int index,
      ) {
    final bool isActive = lesson.isUnlocked;

    return GestureDetector(
      onTap: () => controller.onLessonTap(context, index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveSize(14),
          vertical: context.responsiveSize(6),
        ),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFFFFF8E8)
              : Colors.white,
          borderRadius: BorderRadius.circular(
            context.responsiveSize(16),
          ),
          border: isActive
              ? Border.all(
            color: const Color(0xFF4CB8B3),
            width: 1.5,
          )
              : null,
        ),
        child: Row(
          children: [
            // Circle icon
            Container(
              width: context.responsiveSize(48),
              height: context.responsiveSize(48),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFFFFF0DC)
                    : const Color(0xFFE5E5E5),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isActive && lesson.colorIcon != null
                    ? Container(
                  width: context.responsiveSize(28),
                  height: context.responsiveSize(28),
                  decoration: BoxDecoration(
                    color: lesson.colorIcon,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:
                        lesson.colorIcon!.withOpacity(0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                )
                    : Icon(
                  Icons.lock_outlined,
                  size: context.responsiveSize(22),
                  color: const Color(0xFFB0B0B0),
                ),
              ),
            ),

            SizedBox(width: context.responsiveSize(14)),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: lesson.title,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2D2D2D),
                    useResponsiveFontSize: true,
                  ),
                  SizedBox(height: context.responsiveSize(2)),
                  AppText(
                    data: lesson.translation,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFB0B0B0),
                    useResponsiveFontSize: true,
                  ),
                  SizedBox(height: context.responsiveSize(4)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveSize(8),
                      vertical: context.responsiveSize(2),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3D6),
                      borderRadius: BorderRadius.circular(
                        context.responsiveSize(6),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '✦ ',
                          style: TextStyle(
                            fontSize: context.responsiveSize(11),
                            color: const Color(0xFFE8A838),
                          ),
                        ),
                        AppText(
                          data: '${lesson.xp}XP',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFE8A838),
                          useResponsiveFontSize: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(
              Icons.chevron_right,
              size: context.responsiveSize(24),
              color: const Color(0xFFB0B0B0),
            ),
          ],
        ),
      ),
    );
  }


}
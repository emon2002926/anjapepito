import 'package:anjapepito/core/constants/app_assert_image.dart';
import 'package:anjapepito/core/widgets/Drawer/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/home_view_controller.dart';
import '../models/lesson_item.dart';
import '../models/stat_item.dart';
import '../widgets/lesson_card.dart';
import '../widgets/stat_card.dart';
class HomeView extends StatelessWidget {
   HomeView({super.key});
  final assets = AppAssertImage.instance;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeViewController>();

    return Scaffold(
      key: controller.scaffoldKey,
      drawer: const CustomAppDrawer(),
      backgroundColor: Colors.transparent,
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

            Container(height: 2, color: const Color(0xFFE8E4DC)),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveSize(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.responsiveSize(12)),


                    Obx(
                          () => StatCard(
                        stats: [
                          StatItem(
                            emoji: '⭐',
                            value: '${controller.totalXp.value}',
                            label: 'XP',
                            gradientColors: const [Color(0xFFF2BE42), Color(0xFFFDA63D)],
                            barFill: 0.0,
                            isSplit: false,
                            color: const Color(0xFF895514),
                          ),
                          StatItem(
                            emoji: '🔥',
                            value: '',
                            label: 'Streak',
                            gradientColors: const [Color(0xFFFCAAAA), Color(0xFFFE8D46)],
                            barFill: 0.0,
                            isSplit: true,
                            color: const Color(0xFFEA580C),
                          ),
                          StatItem(
                            emoji: '🏆',
                            value: '${controller.completedLessons.value}/${controller.totalLessons.value}',
                            label: 'Done',
                            isSplit: true,
                            color: const Color(0xFF0891B2),
                            gradientColors: const [Color(0xFF59FFEC), Color(0xFF05A290)],
                            barFill: controller.totalLessons.value > 0
                                ? controller.completedLessons.value / controller.totalLessons.value
                                : 0.0,
                          ),

                        ],
                      ),
                    ),

                    SizedBox(height: context.responsiveSize(24)),

                    // ── Unit Header ──
                    AppText(
                      data: 'UNIT 1',
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF9CA3AF),
                      useResponsiveFontSize: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          data: 'Colors',
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF2D2D2D),
                          useResponsiveFontSize: true,
                        ),
                        Obx(
                              () => AppText(
                            data:
                            '${controller.unitProgress.value.toInt()}%',
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFF97316),
                            useResponsiveFontSize: true,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: context.responsiveSize(8)),

                    Obx(
                          () => ClipRRect(
                        borderRadius: BorderRadius.circular(context.responsiveSize(6)),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: context.responsiveSize(2),
                              color: const Color(0xFFCACACA),
                            ),
                            borderRadius: BorderRadius.circular(context.responsiveSize(6)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(context.responsiveSize(4)),
                            child: SizedBox(
                              height: context.responsiveSize(12),
                              child: Stack(
                                children: [
                                  // ── Background ──
                                  Container(color: const Color(0xFFE0E0E0)),

                                  // ── Gradient Fill ──
                                  FractionallySizedBox(
                                    widthFactor: controller.unitProgress.value / 100,
                                  // widthFactor: 20 / 100, // replace with controller.unitProgress.value / 100
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFFB923C),
                                            // Color(0xFFE8A838),
                                            Color(0xFFFDE047),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                        separatorBuilder: (_, __) => SizedBox(height: context.responsiveSize(12)),
                        itemBuilder: (context, index) => LessonCard(
                          lesson: controller.lessons[index],
                          onTap: () => controller.onLessonTap(context, index),
                        ),
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

}
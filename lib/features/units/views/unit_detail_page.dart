import 'package:anjapepito/core/constants/app_assert_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/util/screen_size.dart';
import '../../../core/widgets/app_bar/build_app_bar.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/unit_detail_controller.dart';
class UnitDetailPage extends StatelessWidget {
  final String unitTitle;

  const UnitDetailPage({
    super.key,
    required this.unitTitle,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      UnitDetailController(unitTitle: unitTitle),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),
      extendBodyBehindAppBar: true,
      appBar: BuildAppBar(
        title: 'Unit 1: Colors',
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
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Obx(
                        () => ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.responsiveSize(20),
                        vertical: context.responsiveSize(16),
                      ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonCard(
      BuildContext context,
      UnitDetailController controller,
      UnitLesson lesson,
      int index,
      ) {
    final bool isCompleted = lesson.status == LessonStatus.completed;

    return GestureDetector(
      onTap: () => controller.onLessonTap(context, index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveSize(14),
          vertical: context.responsiveSize(8),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.responsiveSize(12)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFDFDFD8),
              blurRadius: 0,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Checkbox Icon ──
            Container(
              width: context.responsiveSize(32),
              height: context.responsiveSize(32),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(context.responsiveSize(8)),
                border: Border.all(
                  color: isCompleted
                      ? Colors.transparent
                      : const Color(0xFFD1D1D1),
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? Image.asset(
                AppAssertImage.instance.checkboxIcon,
                height: context.responsiveSize(32),
                width: context.responsiveSize(32),
              )
                  : null,
            ),

            SizedBox(width: context.responsiveSize(14)),

            // ── Text Content ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: lesson.title,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2D2D2D),
                    useResponsiveFontSize: true,
                  ),
                  SizedBox(height: context.responsiveSize(2)),
                  AppText(
                    data: lesson.translation,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFB0B0B0),
                    useResponsiveFontSize: true,
                  ),
                  SizedBox(height: context.responsiveSize(4)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveSize(12),
                      vertical: context.responsiveSize(2),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBBF24),
                      borderRadius: BorderRadius.circular(
                        context.responsiveSize(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '✦ ',
                          style: TextStyle(
                            fontSize: context.responsiveSize(10),
                            color: Colors.white,
                          ),
                        ),
                        AppText(
                          data: '${lesson.xp}XP',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          useResponsiveFontSize: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Arrow ──
            Icon(
              Icons.chevron_right,
              size: context.responsiveSize(24),
              color: const Color(0xFF2D2D2D),
            ),
          ],
        ),
      ),
    );
  }
}
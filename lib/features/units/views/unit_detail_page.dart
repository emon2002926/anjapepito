import 'package:anjapepito/core/constants/app_assert_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/util/screen_size.dart';
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
                      data: controller.unitTitle,
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

            // Lesson List
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
          vertical: context.responsiveSize(12),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            context.responsiveSize(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Checkbox Icon
            Container(
              width: context.responsiveSize(32),
              height: context.responsiveSize(32),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(
                  context.responsiveSize(8),
                ),
                border: Border.all(
                  color: isCompleted ? Colors.transparent : const Color(0xFFD1D1D1),
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? Image.asset(
                AppAssertImage.instance.checkboxIcon,
                height: context.responsiveSize(30),
                width: context.responsiveSize(30),
              )
                  : null,
            ),

            SizedBox(width: context.responsiveSize(14)),

            // Text Content
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
              color: const Color(0xFF2D2D2D),
            ),
          ],
        ),
      ),
    );
  }
}
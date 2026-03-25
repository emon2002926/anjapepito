import 'package:flutter/material.dart';

import '../../../core/constants/app_assert_image.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/text/app_text.dart';
import '../models/lesson_item.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({
    super.key,
    required this.lesson,
    required this.onTap,
  });

  final LessonItem lesson;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isActive = lesson.isUnlocked;

    return isActive ? _buildActiveCard(context) : _buildLockedCard(context);
  }

  // ── Active Card ──
  Widget _buildActiveCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal :context.responsiveSize(12),
            vertical: context.responsiveSize(8)),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFDE8),
          borderRadius: BorderRadius.circular(context.responsiveSize(20)),
          border: Border.all(
            color: const Color(0xFFE8C84A),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE8C84A).withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // ── Sparkle top-left ──
            Positioned(
              top: 0,
              left: 0,
              child: Text(
                '✦',
                style: TextStyle(
                  fontSize: context.responsiveSize(12),
                  color: const Color(0xFFE8C84A),
                ),
              ),
            ),

            // ── Sparkle bottom-right ──
            Positioned(
              bottom: 0,
              right: 0,
              child: Text(
                '✦',
                style: TextStyle(
                  fontSize: context.responsiveSize(10),
                  color: const Color(0xFFE8C84A),
                ),
              ),
            ),

            // ── XP Badge top-right ──
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveSize(10),
                  vertical: context.responsiveSize(4),
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8A838),
                  borderRadius: BorderRadius.circular(context.responsiveSize(20)),
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
                      data: '${lesson.xp} XP',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      useResponsiveFontSize: true,
                    ),
                  ],
                ),
              ),
            ),

            // ── Main Content ──
            Padding(
              padding: EdgeInsets.only(top: context.responsiveSize(12)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── Image Icon ──
                  _buildActiveIcon(context),

                  SizedBox(width: context.responsiveSize(14)),

                  // ── Text + Button ──
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          data: lesson.title,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF92400E),
                          useResponsiveFontSize: true,
                        ),
                        SizedBox(height: context.responsiveSize(4)),
                        AppText(
                          data: lesson.translation,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFD97706),
                          useResponsiveFontSize: true,
                        ),
                        SizedBox(height: context.responsiveSize(6)),

                        // ── Start Button ──

                        GestureDetector(
                          onTap: onTap,
                          child: Image.asset(
                            AppAssertImage.instance.startButton,
                            height: context.responsiveSize(45),
                            width: context.responsiveSize(110),
                            fit: BoxFit.contain,
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Locked Card ──
  Widget _buildLockedCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: context.responsiveSize(120),
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveSize(16),
          vertical: context.responsiveSize(16),
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(context.responsiveSize(20)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Lock Icon (bigger to match active card icon size) ──
            Container(
              width: context.responsiveSize(64),
              height: context.responsiveSize(64),
              decoration: BoxDecoration(
                color: Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(context.responsiveSize(16)),
              ),
              child: Center(
                child: Image.asset(
                  AppAssertImage.instance.lockIcon,
                  height: context.responsiveSize(28),
                  width: context.responsiveSize(28),
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ),

            SizedBox(width: context.responsiveSize(14)),

            // ── Text ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    data: lesson.title,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF9CA3AF),
                    useResponsiveFontSize: true,
                  ),
                  SizedBox(height: context.responsiveSize(4)),
                  // AppText(
                  //   data: lesson.translation,
                  //   fontSize: 13,
                  //   fontWeight: FontWeight.w400,
                  //   color: const Color(0xFFC8C8C8),
                  //   useResponsiveFontSize: true,
                  // ),
                  SizedBox(height: context.responsiveSize(8)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveSize(10),
                      vertical: context.responsiveSize(4),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(
                        context.responsiveSize(8),
                      ),
                    ),
                    child: AppText(
                      data: 'LOCKED',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF9CA3AF),
                      useResponsiveFontSize: true,
                    ),
                  ),
                ],
              ),
            ),

            // ── Arrow ──
            Icon(
              Icons.chevron_right,
              size: context.responsiveSize(24),
              color: const Color(0xFFD0D0D0),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildActiveIcon(BuildContext context) {
    return Container(
      width: context.responsiveSize(64),
      height: context.responsiveSize(64),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.responsiveSize(16)),
        border: Border.all(
          color: const Color(0xFFE8C84A),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: lesson.colorIcon != null
          ? Center(
        child: Image.asset(
          AppAssertImage.instance.activeIcon,
          // height: context.responsiveSize(28),
          // width: context.responsiveSize(28),
        ),
      )
          : Center(
        child: Image.asset(
          AppAssertImage.instance.lockIcon,
          height: context.responsiveSize(28),
          width: context.responsiveSize(28),
        ),
      ),
    );
  }
}
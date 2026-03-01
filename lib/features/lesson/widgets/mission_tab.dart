import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assert_image.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/text/app_text.dart';
import '../../video_player/widgets/app_video_player.dart';
import '../controllers/color_lesson_controller.dart';
class MissionTab extends StatelessWidget {
  const MissionTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LessonController>();

    return Column(
      children: [
        // ── Video Player ──
        AppVideoPlayer(
          videoSource: controller.missionVideoSource,
          tag: 'mission_video',
          width: double.infinity,
          height: context.responsiveSize(240),
          borderRadius: context.responsiveSize(16),
          autoPlay: false,
          showThumbnail: true,
        ),

        SizedBox(height: context.responsiveSize(10)),

        // ── Mission Title ──
        AppText(
          data: controller.missionTitle,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF2D2D2D),
          useResponsiveFontSize: true,
          textAlign: TextAlign.center,
        ),

        SizedBox(height: context.responsiveSize(4)),

        AppText(
          data: controller.missionTitleTranslation,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF4CB8B3),
          useResponsiveFontSize: true,
          textAlign: TextAlign.center,
        ),

        SizedBox(height: context.responsiveSize(20)),

        // ── Mission Instruction Card ──
        _buildAnjaSaysCard(
          context,
          label: 'Anja says / Anja sagt :',
          germanText: controller.missionInstruction,
          englishText: controller.missionTranslation,
        ),

        SizedBox(height: context.responsiveSize(40)),
      ],
    );
  }

  // ══════════════════════════════════════════════════════
  // ANJA SAYS CARD
  // ══════════════════════════════════════════════════════
  Widget _buildAnjaSaysCard(
      BuildContext context, {
        required String label,
        required String germanText,
        required String englishText,
      }) {
    final appImage = AppAssertImage.instance;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.responsiveSize(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.responsiveSize(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              appImage.anjaIcon,
              width: context.responsiveSize(56),
              height: context.responsiveSize(56),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: context.responsiveSize(56),
                height: context.responsiveSize(56),
                decoration: const BoxDecoration(
                  color: Color(0xFFEDE8DF),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person,
                    size: context.responsiveSize(30), color: Colors.grey),
              ),
            ),
          ),
          SizedBox(width: context.responsiveSize(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(
                  data: label,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFB0B0B0),
                  useResponsiveFontSize: true,
                ),
                SizedBox(height: context.responsiveSize(4)),
                AppText(
                  data: germanText,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2D2D2D),
                  useResponsiveFontSize: true,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.responsiveSize(2)),
                AppText(
                  data: englishText,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFE8A838),
                  useResponsiveFontSize: true,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
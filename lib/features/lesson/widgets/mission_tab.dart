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
          height: context.responsiveSize(210),
          borderRadius: context.responsiveSize(16),
          autoPlay: true,
          showThumbnail: false,
        ),

        SizedBox(height: context.responsiveSize(50)),

        GestureDetector(
          onTap: (){},
          child: Container(
            width: double.infinity,
            height: context.responsiveSize(45),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.responsiveSize(12)),
              image: DecorationImage(
                image: AssetImage(AppAssertImage.instance.brownButtonBg),
                fit: BoxFit.contain,
              ),
            ),
            child: Center(
                child: AppText(data: 'Anja says / Anja sagl :',
                  color: Color(0xFFB0B2BE),
                  useResponsiveFontSize: true,
                )
            ),
          ),
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

  Widget _buildAnjaSaysCard(
      BuildContext context, {
        required String label,
        required String germanText,
        required String englishText,
      }) {
    final appImage = AppAssertImage.instance;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: context.responsiveSize(16),
          vertical:context.responsiveSize(8)
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.responsiveSize(12)),

      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: context.responsiveSize(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                AppText(
                  data: germanText,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2D2D2D),
                  useResponsiveFontSize: true,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.responsiveSize(2)),
                AppText(
                  data: englishText,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFFB923C),
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
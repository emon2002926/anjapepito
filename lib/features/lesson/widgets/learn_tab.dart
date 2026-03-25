import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assert_image.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/text/app_text.dart';
import '../../video_player/widgets/app_video_player.dart';
import '../controllers/color_lesson_controller.dart';

class LearnTab extends StatelessWidget {
  const LearnTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LessonController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Video Player ──
        AppVideoPlayer(
          videoSource: controller.learnVideoSource,
          tag: 'learn_video',
          width: double.infinity,
          height: context.responsiveSize(210),
          borderRadius: context.responsiveSize(16),
          autoPlay: true,
          showThumbnail: false,
        ),

        // SizedBox(height: context.responsiveSize(8)),

        // ── Progress Bar ──
        _buildVideoProgressBar(context),

        SizedBox(height: context.responsiveSize(20)),

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

        SizedBox(height: context.responsiveSize(10)),

        // ── Anja Says Card ──
        _buildAnjaSaysCard(
          context,
          label: 'Anja says / Anja sagt :',
          germanText: controller.anjaSays,
          englishText: controller.anjaTranslation,
        ),


        SizedBox(height: context.responsiveSize(40)),
      ],
    );
  }

  // ══════════════════════════════════════════════════════
  // VIDEO PROGRESS BAR
  // ══════════════════════════════════════════════════════
  Widget _buildVideoProgressBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.responsiveSize(4)),
      child: Row(
        children: [
          AppText(
            data: '00:15',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF9E9E9E),
            useResponsiveFontSize: true,
          ),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: context.responsiveSize(4),
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: context.responsiveSize(6),
                ),
                activeTrackColor: const Color(0xFF2D2D2D),
                inactiveTrackColor: const Color(0xFFD1D1D1),
                thumbColor: const Color(0xFFD1D1D1),
              ),
              child: Slider(
                value: 0.5,
                onChanged: (value) {
                  // TODO: Seek video
                },
              ),
            ),
          ),
          SizedBox(width: context.responsiveSize(8)),
          AppText(
            data: '00:30',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF9E9E9E),
            useResponsiveFontSize: true,
          ),
        ],
      ),
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
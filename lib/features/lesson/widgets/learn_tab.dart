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
          autoPlay: false,
          showThumbnail: true,
        ),

        // SizedBox(height: context.responsiveSize(8)),

        // ── Progress Bar ──
        _buildVideoProgressBar(context),

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
      padding: EdgeInsets.symmetric(
          horizontal: context.responsiveSize(16),
          vertical:context.responsiveSize(8)
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.responsiveSize(12)),
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
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2D2D2D),
                  useResponsiveFontSize: true,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.responsiveSize(2)),
                AppText(
                  data: englishText,
                  fontSize: 14,
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
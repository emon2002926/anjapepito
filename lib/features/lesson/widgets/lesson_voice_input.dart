import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/util/screen_size.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/color_lesson_controller.dart';

class VoiceInput extends StatelessWidget {
  final LessonController controller;

  const VoiceInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isRecording = controller.isRecording.value;

      return GestureDetector(
        onTap: () => controller.onTalkWithAnja(),
        child: Container(
          width: double.infinity,
          height: context.responsiveSize(56),
          decoration: BoxDecoration(
            color: isRecording
                ? const Color(0xFF2D6A2D)
                : const Color(0xFF3A7D3A),
            borderRadius: BorderRadius.circular(context.responsiveSize(12)),
          ),
          child: Row(
            children: [
              SizedBox(width: context.responsiveSize(16)),
              Icon(
                isRecording ? Icons.mic : Icons.mic_outlined,
                size: context.responsiveSize(24),
                color: Colors.white,
              ),
              SizedBox(width: context.responsiveSize(10)),
              Expanded(
                child: AppText(
                  data: isRecording ? 'Recording...' : 'Talk with Pocket Anja',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  useResponsiveFontSize: true,
                ),
              ),

              // ── Send icon in rounded square ──
              Container(
                margin: EdgeInsets.only(right: context.responsiveSize(10)),
                width: context.responsiveSize(36),
                height: context.responsiveSize(36),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(context.responsiveSize(10)),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.send_rounded,
                  size: context.responsiveSize(18),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
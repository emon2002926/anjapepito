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
    return Obx(
          () => GestureDetector(
        onTap: () => controller.onTalkWithAnja(),
        child: Container(
          width: double.infinity,
          height: context.responsiveSize(56),
          decoration: BoxDecoration(
            color: controller.isRecording.value
                ? const Color(0xFF4CB8B3).withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(context.responsiveSize(28)),
            border: Border.all(color: const Color(0xFF4CB8B3), width: 1.5),
          ),
          child: Row(
            children: [
              SizedBox(width: context.responsiveSize(16)),
              Icon(
                controller.isRecording.value ? Icons.mic : Icons.mic_outlined,
                size: context.responsiveSize(22),
                color: const Color(0xFF4CB8B3),
              ),
              SizedBox(width: context.responsiveSize(10)),
              Expanded(
                child: AppText(
                  data: controller.isRecording.value
                      ? 'Recording...'
                      : 'Talk with Pocket Anja',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF4CB8B3),
                  useResponsiveFontSize: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: context.responsiveSize(16)),
                child: Icon(
                  Icons.send_rounded,
                  size: context.responsiveSize(22),
                  color: const Color(0xFF4CB8B3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
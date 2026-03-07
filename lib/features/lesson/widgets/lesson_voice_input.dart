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
      final isSelected = controller.selectedInput.value == 'voice';

      return GestureDetector(
        onTap: () => controller.onTalkWithAnja(),
        child: Container(
          width: double.infinity,
          height: context.responsiveSize(56),
          decoration: BoxDecoration(
            color: isSelected && controller.isRecording.value
                ? const Color(0xFF4CB8B3).withOpacity(0.1)
                : Colors.transparent,
            borderRadius:
            BorderRadius.circular(context.responsiveSize(28)),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF4CB8B3)
                  : const Color(0xFFD1D1D1),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: context.responsiveSize(16)),
              Icon(
                isSelected && controller.isRecording.value
                    ? Icons.mic
                    : Icons.mic_outlined,
                size: context.responsiveSize(22),
                color: isSelected
                    ? const Color(0xFF4CB8B3)
                    : const Color(0xFFB0B0B0),
              ),
              SizedBox(width: context.responsiveSize(10)),
              Expanded(
                child: AppText(
                  data: isSelected && controller.isRecording.value
                      ? 'Recording...'
                      : 'Talk with Pocket Anja',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF4CB8B3)
                      : const Color(0xFFB0B0B0),
                  useResponsiveFontSize: true,
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(right: context.responsiveSize(16)),
                child: Icon(
                  Icons.send_rounded,
                  size: context.responsiveSize(22),
                  color: isSelected
                      ? const Color(0xFF4CB8B3)
                      : const Color(0xFFB0B0B0),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
import 'package:flutter/material.dart';
import '../../../core/util/screen_size.dart';
import '../controllers/color_lesson_controller.dart';
import 'package:get/get.dart';

class LessonTextInput extends StatelessWidget {
  final LessonController controller;

  const LessonTextInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedInput.value == 'text';

      return GestureDetector(
        onTap: () => controller.selectedInput.value = 'text',
        child: Container(
          width: double.infinity,
          height: context.responsiveSize(56),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius:
            BorderRadius.circular(context.responsiveSize(28)),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF4CB8B3)
                  : const Color(0xFFD1D1D1),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: context.responsiveSize(16)),
              Icon(
                Icons.keyboard_outlined,
                size: context.responsiveSize(22),
                color: isSelected
                    ? const Color(0xFF4CB8B3)
                    : const Color(0xFFB0B0B0),
              ),
              SizedBox(width: context.responsiveSize(10)),
              Expanded(
                child: TextField(
                  controller: controller.chatInputController,
                  onTap: () => controller.selectedInput.value = 'text',
                  decoration: InputDecoration(
                    hintText: 'Chat with Pocket Anja',
                    hintStyle: TextStyle(
                      fontSize: context.responsiveSize(15),
                      color: const Color(0xFFB0B0B0),
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onSubmitted: (_) => controller.onSendChat(),
                ),
              ),
              GestureDetector(
                onTap: () => controller.onSendChat(),
                child: Padding(
                  padding: EdgeInsets.only(
                      right: context.responsiveSize(16)),
                  child: Icon(
                    Icons.send_rounded,
                    size: context.responsiveSize(22),
                    color: isSelected
                        ? const Color(0xFF4CB8B3)
                        : const Color(0xFFB0B0B0),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
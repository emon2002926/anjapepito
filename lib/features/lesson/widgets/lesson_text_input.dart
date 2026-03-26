import 'package:flutter/material.dart';
import '../../../core/constants/app_assert_image.dart';
import '../../../core/util/screen_size.dart';
import '../controllers/color_lesson_controller.dart';

class LessonTextInput extends StatelessWidget {
  final LessonController controller;

  const LessonTextInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.selectedInput.value = 'text',
      child: Container(
        width: double.infinity,
        height: context.responsiveSize(56),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.responsiveSize(12)),
          image: DecorationImage(
            image: AssetImage(AppAssertImage.instance.brownButtonBg),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: context.responsiveSize(16)),
            Icon(
              Icons.keyboard_outlined,
              size: context.responsiveSize(22),
              color: const Color(0xFFB0956A),
            ),
            SizedBox(width: context.responsiveSize(10)),
            Expanded(
              child: TextField(
                controller: controller.chatInputController,
                onTap: () => controller.selectedInput.value = 'text',
                style: TextStyle(
                  fontSize: context.responsiveSize(15),
                  color: const Color(0xFF5C3A00),
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'Chat with Pocket Anja',
                  hintStyle: TextStyle(
                    fontSize: context.responsiveSize(15),
                    color: const Color(0xFFB0956A),
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
              child: Container(
                margin: EdgeInsets.only(right: context.responsiveSize(10)),
                width: context.responsiveSize(36),
                height: context.responsiveSize(36),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8C9A0).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(context.responsiveSize(10)),
                  border: Border.all(
                    color: const Color(0xFFD4A870).withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.send_rounded,
                  size: context.responsiveSize(18),
                  color: const Color(0xFFB0956A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
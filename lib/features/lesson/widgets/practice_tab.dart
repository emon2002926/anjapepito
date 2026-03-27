import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assert_image.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/color_lesson_controller.dart';
class PracticeTab extends StatelessWidget {
  const PracticeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LessonController>();
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Anja Avatar + Prompt ──
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      controller.appImage.anjaIcon,
                      width: context.responsiveSize(48),
                      height: context.responsiveSize(48),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: context.responsiveSize(48),
                        height: context.responsiveSize(48),
                        decoration: const BoxDecoration(
                          color: Color(0xFFEDE8DF),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.person,
                            size: context.responsiveSize(28),
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(width: context.responsiveSize(12)),

                  // ── Prompt Bubble using brown bg image ──
                  Expanded(
                    child: Container(
                      height: context.responsiveSize(50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          context.responsiveSize(28),
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            AppAssertImage.instance.brownButtonBg,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.responsiveSize(16),
                          ),
                          child: AppText(
                            data: 'Talk to me (Anja-bot) 😊',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFB0956A),
                            useResponsiveFontSize: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: context.responsiveSize(12)),

              // ── Chat Messages ──
              Obx(
                    () => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.chatMessages.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: context.responsiveSize(10)),
                  itemBuilder: (context, index) => _buildChatBubble(
                    context,
                    controller.chatMessages[index],
                  ),
                ),
              ),

              SizedBox(height: context.responsiveSize(140) + bottomInset),
            ],
          ),
        ),
      ],
    );
  }

  // ── Chat Bubble ──
  Widget _buildChatBubble(BuildContext context, ChatMessage message) {
    final isUser = !message.isBot;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.85,
        ),
        margin: EdgeInsets.only(
          left: isUser ? context.responsiveSize(40) : 20,
          right: isUser ? 0 : context.responsiveSize(0),
        ),
        padding: EdgeInsets.all(context.responsiveSize(14)),
        decoration: BoxDecoration(
          color: const Color(0xFFFDF0E4),
          borderRadius: BorderRadius.circular(context.responsiveSize(16)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFB06A2E),
                blurRadius: 9,
                offset: const Offset(0, -3),
              ),
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              data: message.text,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF5C3A00),
              useResponsiveFontSize: true,
            ),
            if (message.germanExample != null) ...[
              SizedBox(height: context.responsiveSize(8)),
              AppText(
                data: message.germanExample!,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFE8A838),
                useResponsiveFontSize: true,
              ),
            ],
            if (message.englishExample != null) ...[
              SizedBox(height: context.responsiveSize(2)),
              AppText(
                data: message.englishExample!,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFE8842A),
                useResponsiveFontSize: true,
              ),
            ],
          ],
        ),
      ),
    );
  }

}
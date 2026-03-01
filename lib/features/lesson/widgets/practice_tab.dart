import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        // ── Scrollable Content ──
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Anja Avatar + Prompt ──
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.responsiveSize(16),
                        vertical: context.responsiveSize(12),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F0E8),
                        borderRadius:
                        BorderRadius.circular(context.responsiveSize(16)),
                      ),
                      child: const AppText(
                        data: 'Talk to me (Anja-bot) 😊',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9E9E9E),
                        useResponsiveFontSize: true,
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
                  itemBuilder: (context, index) =>
                      _buildChatBubble(context, controller.chatMessages[index]),
                ),
              ),

              // Space for bottom inputs + keyboard
              SizedBox(
                height: context.responsiveSize(140) + bottomInset,
              ),
            ],
          ),
        ),

        // ── Pinned Bottom Inputs ──
        // Positioned(
        //   left: 0,
        //   right: 0,
        //   bottom: bottomInset,
        //   child: Container(
        //     color: Colors.white,
        //     padding: EdgeInsets.only(
        //       bottom: context.responsiveSize(16),
        //       top: context.responsiveSize(8),
        //     ),
        //     child: Column(
        //       children: [
        //         _buildVoiceInput(context, controller),
        //         SizedBox(height: context.responsiveSize(12)),
        //         _buildTextInput(context, controller),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════
  // CHAT BUBBLE
  // ══════════════════════════════════════════════════════
  Widget _buildChatBubble(BuildContext context, ChatMessage message) {
    final isUser = !message.isBot;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints:
        BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        margin: EdgeInsets.only(
          left: isUser ? context.responsiveSize(60) : 0,
          right: isUser ? 0 : context.responsiveSize(60),
        ),
        padding: EdgeInsets.all(context.responsiveSize(16)),
        decoration: BoxDecoration(
          color: isUser
              ? const Color(0xFF4CB8B3).withOpacity(0.15)
              : const Color(0xFFF3F0E8),
          borderRadius: BorderRadius.circular(context.responsiveSize(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              data: message.text,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF2D2D2D),
              useResponsiveFontSize: true,
            ),
            if (message.germanExample != null) ...[
              SizedBox(height: context.responsiveSize(8)),
              AppText(
                data: message.germanExample!,
                fontSize: 14,
                fontWeight: FontWeight.w500,
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

  // ══════════════════════════════════════════════════════
  // VOICE INPUT
  // ══════════════════════════════════════════════════════
  Widget _buildVoiceInput(BuildContext context, LessonController controller) {
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
                controller.isRecording.value
                    ? Icons.mic
                    : Icons.mic_outlined,
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

  // ══════════════════════════════════════════════════════
  // TEXT INPUT
  // ══════════════════════════════════════════════════════
  Widget _buildTextInput(BuildContext context, LessonController controller) {
    return Container(
      width: double.infinity,
      height: context.responsiveSize(56),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(context.responsiveSize(28)),
        border: Border.all(color: const Color(0xFFD1D1D1), width: 1),
      ),
      child: Row(
        children: [
          SizedBox(width: context.responsiveSize(16)),
          Icon(
            Icons.keyboard_outlined,
            size: context.responsiveSize(22),
            color: const Color(0xFFB0B0B0),
          ),
          SizedBox(width: context.responsiveSize(10)),
          Expanded(
            child: TextField(
              controller: controller.chatInputController,
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
              padding: EdgeInsets.only(right: context.responsiveSize(16)),
              child: Icon(
                Icons.send_rounded,
                size: context.responsiveSize(22),
                color: const Color(0xFFB0B0B0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
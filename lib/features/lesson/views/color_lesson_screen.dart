import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/color_lesson_controller.dart';
import '../widgets/learn_tab.dart';
import '../widgets/mission_tab.dart';
import '../widgets/practice_tab.dart';
class LessonScreen extends StatelessWidget {
  final String lessonTitle;
  final String lessonTranslation;
  final String unitTitle;
  final bool isForLesson;

  const LessonScreen({
    super.key,
    required this.lessonTitle,
    required this.lessonTranslation,
    required this.unitTitle,
    required this.isForLesson,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LessonController(
      lessonTitle: lessonTitle,
      lessonTranslation: lessonTranslation,
      unitTitle: unitTitle,
      isForLesson: isForLesson,
    ));

    return Scaffold(
      backgroundColor: const Color(0xFFF9F5ED),
      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ──
            _buildAppBar(context, controller),
            Container(height: 1, color: const Color(0xFFE8E4DC)),

            // ── Content ──
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveSize(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.responsiveSize(12)),

                    // Unit Title
                    AppText(
                      data: controller.unitTitle,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2D2D2D),
                      useResponsiveFontSize: true,
                    ),

                    SizedBox(height: context.responsiveSize(12)),

                    // ── Tab Bar ──
                    _buildTabBar(context, controller),

                    SizedBox(height: context.responsiveSize(16)),

                    // ── Tab Content ──
                    Obx(() {
                      switch (controller.currentTab.value) {
                        case 0:
                          return const LearnTab();
                        case 1:
                          return const MissionTab();
                        case 2:
                          return const PracticeTab();
                        default:
                          return const SizedBox();
                      }
                    }),
                  ],
                ),
              ),
            ),

            // ── Voice + Text Inputs (Practice tab only) ──
            Obx(() {
              if (controller.currentTab.value != 2) return const SizedBox();
              return Container(
                color: const Color(0xFFF9F5ED),
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveSize(20),
                  vertical: context.responsiveSize(8),
                ),
                child: Column(
                  children: [
                    _buildVoiceInput(context, controller),
                    SizedBox(height: context.responsiveSize(12)),
                    _buildTextInput(context, controller),
                    SizedBox(height: context.responsiveSize(12)),

                  ],
                ),
              );
            }),

            // ── Bottom Button ──
            Obx(() => _buildBottomButton(context, controller)),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // APP BAR
  // ══════════════════════════════════════════════════════
  Widget _buildAppBar(BuildContext context, LessonController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveSize(20),
        vertical: context.responsiveSize(12),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.chevron_left,
              size: context.responsiveSize(28),
              color: const Color(0xFF2D2D2D),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                AppText(
                  data: controller.lessonTitle,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2D2D2D),
                  useResponsiveFontSize: true,
                  textAlign: TextAlign.center,
                ),
                AppText(
                  data: controller.lessonTranslation,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFB0B0B0),
                  useResponsiveFontSize: true,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(width: context.responsiveSize(28)),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // TAB BAR
  // ══════════════════════════════════════════════════════
  Widget _buildTabBar(BuildContext context, LessonController controller) {
    return Obx(
          () => Row(
        children: List.generate(controller.tabs.length, (index) {
          final isActive = controller.currentTab.value == index;
          final barColor = index <= controller.currentTab.value
              ? const Color(0xFFE8A838)
              : const Color(0xFFE0E0E0);

          return Expanded(
            child: GestureDetector(
              onTap: () => controller.switchTab(index),
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      data: controller.tabs[index],
                      fontSize: 13,
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                      color: isActive
                          ? const Color(0xFF2D2D2D)
                          : const Color(0xFF9E9E9E),
                      useResponsiveFontSize: true,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: context.responsiveSize(6)),
                    Container(
                      height: context.responsiveSize(6),
                      decoration: BoxDecoration(
                        color: barColor,
                        borderRadius: BorderRadius.circular(
                          context.responsiveSize(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
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

  // ══════════════════════════════════════════════════════
  // BOTTOM BUTTON
  // ══════════════════════════════════════════════════════
  Widget _buildBottomButton(BuildContext context, LessonController controller) {
    String primaryText;
    String translationText;
    VoidCallback onTap;

    switch (controller.currentTab.value) {
      case 0:
        primaryText = 'Got it';
        translationText = 'Verstanden';
        onTap = () => controller.onGotIt(context);
        break;
      case 1:
        if (controller.isForLesson) {
          primaryText = "Done! Let\u2019s practice";
          translationText = 'Fertig! Lass uns üben';
        } else {
          primaryText = 'Done';
          translationText = 'Fertig';
        }
        onTap = () => controller.onDonePractice(context);
        break;
      case 2:
        primaryText = 'Done';
        translationText = 'Fertig';
        onTap = () => controller.onDone(context);
        break;
      default:
        primaryText = 'Next';
        translationText = 'Weiter';
        onTap = () {};
    }

    return Padding(
      padding: EdgeInsets.only(
        left: context.responsiveSize(24),
        right: context.responsiveSize(24),
        bottom: context.responsiveSize(24),
        top: context.responsiveSize(8),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: context.responsiveSize(56),
          decoration: BoxDecoration(
            color: const Color(0xFF4CB8B3),
            borderRadius: BorderRadius.circular(context.responsiveSize(28)),
          ),
          child: Center(
            child: Text.rich(
              TextSpan(
                children: _buildBilingualButtonSpans(
                  context,
                  primaryText,
                  translationText,
                  controller,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<TextSpan> _buildBilingualButtonSpans(
      BuildContext context,
      String primaryText,
      String translationText,
      LessonController lessonController,
      ) {
    const yellowColor = Color(0xFFFFEB3B);
    const whiteColor = Colors.white;
    final fontSize = lessonController.currentTab.value == 0
        ? context.responsiveSize(14)
        : lessonController.currentTab.value == 1
        ? context.responsiveSize(12)
        : context.responsiveSize(14);

    TextSpan buildStyledWord(String word) {
      if (word.isEmpty) return const TextSpan();
      return TextSpan(
        children: [
          TextSpan(
            text: word[0],
            style: TextStyle(
              color: yellowColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: word.substring(1),
            style: TextStyle(
              color: whiteColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }

    final primaryWords = primaryText.split(' ');
    final translationWords = translationText.split(' ');
    final spans = <TextSpan>[];

    for (int i = 0; i < primaryWords.length; i++) {
      if (i > 0) spans.add(TextSpan(text: ' ', style: TextStyle(fontSize: fontSize)));
      spans.add(buildStyledWord(primaryWords[i]));
    }

    spans.add(TextSpan(
      text: ' → ',
      style: TextStyle(
        color: whiteColor,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    ));

    for (int i = 0; i < translationWords.length; i++) {
      if (i > 0) spans.add(TextSpan(text: ' ', style: TextStyle(fontSize: fontSize)));
      spans.add(buildStyledWord(translationWords[i]));
    }

    return spans;
  }
}
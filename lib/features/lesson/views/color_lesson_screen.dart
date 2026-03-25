import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assert_image.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/app_bar/build_app_bar.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/color_lesson_controller.dart';
import '../widgets/learn_tab.dart';
import '../widgets/lesson_text_input.dart';
import '../widgets/lesson_voice_input.dart';
import '../widgets/mission_tab.dart';
import '../widgets/practice_tab.dart';
class LessonScreen extends StatelessWidget {
  final String lessonTitle;
  final String lessonTranslation;
  final String unitTitle;
  final bool isForLesson;
  final LessonController controller;

  LessonScreen({
    super.key,
    required this.lessonTitle,
    required this.lessonTranslation,
    required this.unitTitle,
    required this.isForLesson,
  }) : controller = Get.put(
    LessonController(
      lessonTitle: lessonTitle,
      lessonTranslation: lessonTranslation,
      unitTitle: unitTitle,
      isForLesson: isForLesson,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) print("Popped from memory");
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F5ED),
        body: Stack(
          children: [
            // ── Background Image ──
            Positioned.fill(
              child: Image.asset(
                AppAssertImage.instance.backgroundImage,
                fit: BoxFit.cover,
              ),
            ),

            // ── Foreground Content ──
            SafeArea(
              child: Column(
                children: [
                  BuildAppBar(
                    useMinimalStyle: true,
                    title: controller.lessonTitle,
                    subtitle: controller.lessonTranslation,
                    onBackButtonPressed: () {
                      Get.delete<LessonController>();
                      Navigator.pop(context);
                    },
                  ),

                  Container(height: 1, color: const Color(0xFFE8E4DC)),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.responsiveSize(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.responsiveSize(12)),

                          AppText(
                            data: controller.unitTitle,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF9CA3AF),
                            useResponsiveFontSize: true,
                          ),
                          AppText(
                            data: "Colors",
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF1F2937),
                            useResponsiveFontSize: true,
                          ),

                          SizedBox(height: context.responsiveSize(8)),

                          _buildTabBar(context, controller),

                          SizedBox(height: context.responsiveSize(20)),

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

                  Obx(() {
                    if (controller.currentTab.value != 2) return const SizedBox();
                    return Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                        horizontal: context.responsiveSize(20),
                        vertical: context.responsiveSize(8),
                      ),
                      child: Column(
                        children: [
                          VoiceInput(controller: controller),
                          SizedBox(height: context.responsiveSize(12)),
                          LessonTextInput(controller: controller),
                          SizedBox(height: context.responsiveSize(12)),
                        ],
                      ),
                    );
                  }),

                  Obx(() => _buildBottomButton(context, controller)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTabBar(BuildContext context, LessonController controller) {
    return Obx(
          () => Row(
        children: List.generate(controller.tabs.length, (index) {
          final isActive = controller.currentTab.value == index;
          final isFilled = index <= controller.currentTab.value;

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
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                      color: isActive
                          ? const Color(0xFF2D2D2D)
                          : const Color(0xFF9E9E9E),
                      useResponsiveFontSize: true,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: context.responsiveSize(6)),
                    Container(
                      height: context.responsiveSize(12),
                      decoration: BoxDecoration(
                        gradient: isFilled
                            ? const LinearGradient(
                          colors: [
                            Color(0xFFFB923C),
                            Color(0xFFFDE047),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                            : const LinearGradient(
                          colors: [
                            Color(0xFFE0E0E0),
                            Color(0xFFE0E0E0),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(
                          context.responsiveSize(12),
                        ),
                        border: Border.all(
                          color: Color(0xFFCACACA)
                        )
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




  Widget _buildBottomButton(
      BuildContext context, LessonController controller) {
    String primaryText;
    String translationText;
    VoidCallback onTap;

    switch (controller.currentTab.value) {
      case 0:
        primaryText = 'Got it';
        translationText = '--> Verstanden';
        onTap = () => controller.onGotIt(context);
        break;
      case 1:
        if (controller.isForLesson) {
          primaryText = "I found it !";
          translationText = '';
        } else {
          primaryText = 'Done';
          translationText = 'Fertig';
        }
        onTap = () => controller.onDonePractice(context);
        break;
      case 2:
        translationText  = 'Done';
        primaryText = '--> Fertig';
        onTap = () => controller.onDone(context);
        break;
      default:
        primaryText = 'Next';
        translationText = '--> Weiter';
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
          height: context.responsiveSize(45),
          decoration: BoxDecoration(
            color: const Color(0xFF2FA8B6),
            borderRadius:
            BorderRadius.circular(context.responsiveSize(28)),
          ),
          child: Center(
            child: AppText(
              data: '${controller.currentTab.value == 0 ? primaryText : translationText} ${
                  controller.currentTab.value == 0 ? translationText : primaryText}',
              fontSize: context.responsiveSize(20),
              fontWeight: FontWeight.w700,
              color: Colors.white,
              useResponsiveFontSize: true,
            ),

          ),
        ),
      ),
    );
  }

}
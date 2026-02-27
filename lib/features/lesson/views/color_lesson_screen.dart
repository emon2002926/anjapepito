import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assert_image.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/text/app_text.dart';
import '../../video_player/widgets/app_video_player.dart';
import '../controllers/color_lesson_controller.dart';
class ColorLessonScreen extends StatelessWidget {
  final String lessonTitle;
  final String lessonTranslation;
  final String unitTitle;

  const ColorLessonScreen({
    super.key,
    required this.lessonTitle,
    required this.lessonTranslation,
    required this.unitTitle,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ColorLessonController(
      lessonTitle: lessonTitle,
      lessonTranslation: lessonTranslation,
      unitTitle: unitTitle,
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
                          return _buildLearnTab(context, controller);
                        case 1:
                          return _buildMissionTab(context, controller);
                        case 2:
                          return _buildPracticeTab(context, controller);
                        default:
                          return const SizedBox();
                      }
                    }),
                  ],
                ),
              ),
            ),

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
  Widget _buildAppBar(
      BuildContext context, ColorLessonController controller) {
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
  Widget _buildTabBar(
      BuildContext context, ColorLessonController controller) {
    final tabs = ['Learn / Lerne', 'Mission', 'Practice / üben'];

    return Obx(
          () => Row(
        children: List.generate(tabs.length, (index) {
          final isActive = controller.currentTab.value == index;
          // Determine progress color
          Color barColor;
          if (index < controller.currentTab.value) {
            barColor = const Color(0xFFE8A838); // Completed = orange
          } else if (index == controller.currentTab.value) {
            barColor = const Color(0xFFE8A838); // Current = orange
          } else {
            barColor = const Color(0xFFE0E0E0); // Upcoming = gray
          }

          return Expanded(
            child: GestureDetector(
              onTap: () => controller.switchTab(index),
              child: Column(
                children: [
                  AppText(
                    data: tabs[index],
                    fontSize: 13,
                    fontWeight:
                    isActive ? FontWeight.w700 : FontWeight.w500,
                    color: isActive
                        ? const Color(0xFF2D2D2D)
                        : const Color(0xFF9E9E9E),
                    useResponsiveFontSize: true,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.responsiveSize(6)),
                  Container(
                    height: context.responsiveSize(4),
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(
                        context.responsiveSize(2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // LEARN TAB
  // ══════════════════════════════════════════════════════
  Widget _buildLearnTab(
      BuildContext context, ColorLessonController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Video Player
        AppVideoPlayer(
          videoSource: controller.learnVideoSource,
          tag: 'learn_video',
          width: double.infinity,
          height: context.responsiveSize(280),
          borderRadius: context.responsiveSize(16),
          autoPlay: false,
          showThumbnail: true,
        ),

        SizedBox(height: context.responsiveSize(8)),

        // Progress bar below video
        _buildVideoProgressBar(context),

        SizedBox(height: context.responsiveSize(20)),

        // Anja Says Card
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

  Widget _buildVideoProgressBar(BuildContext context) {
    // This connects to the video controller - simplified version
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveSize(4),
      ),
      child: Row(
        children: [
          AppText(
            data: '00:15',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF9E9E9E),
            useResponsiveFontSize: true,
          ),
          SizedBox(width: context.responsiveSize(8)),
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
  // MISSION TAB
  // ══════════════════════════════════════════════════════
  Widget _buildMissionTab(
      BuildContext context, ColorLessonController controller) {
    return Column(
      children: [
        // Video Player
        AppVideoPlayer(
          videoSource: controller.missionVideoSource,
          tag: 'mission_video',
          width: double.infinity,
          height: context.responsiveSize(280),
          borderRadius: context.responsiveSize(16),
          autoPlay: false,
          showThumbnail: true,
        ),

        SizedBox(height: context.responsiveSize(20)),

        // Real-Life Mission Title
        AppText(
          data: controller.missionTitle,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF2D2D2D),
          useResponsiveFontSize: true,
          textAlign: TextAlign.center,
        ),

        SizedBox(height: context.responsiveSize(4)),

        AppText(
          data: controller.missionTitleTranslation,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF4CB8B3),
          useResponsiveFontSize: true,
          textAlign: TextAlign.center,
        ),

        SizedBox(height: context.responsiveSize(20)),

        // Mission Instruction Card
        _buildAnjaSaysCard(
          context,
          label: 'Anja says / Anja sagt :',
          germanText: controller.missionInstruction,
          englishText: controller.missionTranslation,
        ),

        SizedBox(height: context.responsiveSize(40)),
      ],
    );
  }

  // ══════════════════════════════════════════════════════
  // PRACTICE TAB
  // ══════════════════════════════════════════════════════
  Widget _buildPracticeTab(
      BuildContext context, ColorLessonController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Anja Avatar + Title
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Anja avatar
            ClipOval(
              child: Image.asset(
                controller.appImage.appLogo, // Anja avatar
                width: context.responsiveSize(48),
                height: context.responsiveSize(48),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: context.responsiveSize(48),
                    height: context.responsiveSize(48),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEDE8DF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: context.responsiveSize(28),
                      color: Colors.grey,
                    ),
                  );
                },
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
                  borderRadius: BorderRadius.circular(
                    context.responsiveSize(16),
                  ),
                ),
                child: AppText(
                  data: 'Talk to me (Anja-bot) 😊',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9E9E9E),
                  useResponsiveFontSize: true,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: context.responsiveSize(12)),

        // Chat Messages
        Obx(
              () => ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.chatMessages.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: context.responsiveSize(10)),
            itemBuilder: (context, index) {
              return _buildChatBubble(
                context,
                controller.chatMessages[index],
              );
            },
          ),
        ),

        SizedBox(height: context.responsiveSize(24)),

        // Talk with Pocket Anja
        _buildVoiceInput(context, controller),

        SizedBox(height: context.responsiveSize(12)),

        // Chat with Pocket Anja
        _buildTextInput(context, controller),

        SizedBox(height: context.responsiveSize(40)),
      ],
    );
  }

  Widget _buildChatBubble(BuildContext context, ChatMessage message) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.responsiveSize(60), // indent for bot messages
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(context.responsiveSize(16)),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F0E8),
          borderRadius: BorderRadius.circular(
            context.responsiveSize(16),
          ),
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

  Widget _buildVoiceInput(
      BuildContext context, ColorLessonController controller) {
    return Container(
      width: double.infinity,
      height: context.responsiveSize(56),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(
          context.responsiveSize(28),
        ),
        border: Border.all(
          color: const Color(0xFF4CB8B3),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: context.responsiveSize(16)),
          Icon(
            Icons.mic_outlined,
            size: context.responsiveSize(22),
            color: const Color(0xFF4CB8B3),
          ),
          SizedBox(width: context.responsiveSize(10)),
          Expanded(
            child: AppText(
              data: 'Talk with Pocket Anja',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF4CB8B3),
              useResponsiveFontSize: true,
            ),
          ),
          GestureDetector(
            onTap: () => controller.onTalkWithAnja(),
            child: Padding(
              padding: EdgeInsets.only(
                right: context.responsiveSize(16),
              ),
              child: Icon(
                Icons.send_rounded,
                size: context.responsiveSize(22),
                color: const Color(0xFF4CB8B3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextInput(
      BuildContext context, ColorLessonController controller) {
    return Container(
      width: double.infinity,
      height: context.responsiveSize(56),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(
          context.responsiveSize(28),
        ),
        border: Border.all(
          color: const Color(0xFFD1D1D1),
          width: 1,
        ),
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
            child: AppText(
              data: 'Chat with Pocket Anja',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFB0B0B0),
              useResponsiveFontSize: true,
            ),
          ),
          GestureDetector(
            onTap: () => controller.onSendChat(),
            child: Padding(
              padding: EdgeInsets.only(
                right: context.responsiveSize(16),
              ),
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
  // SHARED: ANJA SAYS CARD
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
      padding: EdgeInsets.all(context.responsiveSize(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          context.responsiveSize(16),
        ),
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
          // Anja avatar
          ClipOval(
            child: Image.asset(
              appImage.appLogo,
              width: context.responsiveSize(56),
              height: context.responsiveSize(56),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: context.responsiveSize(56),
                  height: context.responsiveSize(56),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEDE8DF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    size: context.responsiveSize(30),
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: context.responsiveSize(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2D2D2D),
                  useResponsiveFontSize: true,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.responsiveSize(2)),
                AppText(
                  data: englishText,
                  fontSize: 13,
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

  // ══════════════════════════════════════════════════════
  // BOTTOM BUTTON (changes per tab)
  // ══════════════════════════════════════════════════════
  Widget _buildBottomButton(
      BuildContext context, ColorLessonController controller) {
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
        primaryText = "Done! Let\u2019s practice";
        translationText = 'Fertig! Lass uns üben';
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
            borderRadius: BorderRadius.circular(
              context.responsiveSize(28),
            ),
          ),
          child: Center(
            child: Text.rich(
              TextSpan(
                children: _buildBilingualButtonSpans(
                  context,
                  primaryText,
                  translationText,
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
      ) {
    const yellowColor = Color(0xFFFFEB3B);
    const whiteColor = Colors.white;
    final fontSize = context.responsiveSize(16);

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

    // Split into words and style each
    final primaryWords = primaryText.split(' ');
    final translationWords = translationText.split(' ');

    final spans = <TextSpan>[];

    for (int i = 0; i < primaryWords.length; i++) {
      if (i > 0) {
        spans.add(TextSpan(
          text: ' ',
          style: TextStyle(fontSize: fontSize),
        ));
      }
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
      if (i > 0) {
        spans.add(TextSpan(
          text: ' ',
          style: TextStyle(fontSize: fontSize),
        ));
      }
      spans.add(buildStyledWord(translationWords[i]));
    }

    return spans;
  }
}
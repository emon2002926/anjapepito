import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assert_image.dart';
import '../../video_player/models/video_source.dart';
class ColorLessonController extends GetxController {
  final RxInt currentTab = 0.obs; // 0=Learn, 1=Mission, 2=Practice
  final String lessonTitle;
  final String lessonTranslation;
  final String unitTitle;
  final appImage = AppAssertImage.instance;

  ColorLessonController({
    required this.lessonTitle,
    required this.lessonTranslation,
    required this.unitTitle,
  });

  // ── Learn Tab Data ──
  late final VideoSource learnVideoSource = VideoSource.asset(
    'assets/video/video_demo.mp4', // Replace with your asset
    thumbnailAssetPath: 'assets/images/learn_thumb.png',
  );
  final String anjaSays = '"Das ist orange"';
  final String anjaTranslation = '" This is orange "';

  // ── Mission Tab Data ──
  late final VideoSource missionVideoSource = VideoSource.asset(
    'assets/video/video_demo.mp4', // Replace with your asset
    thumbnailAssetPath: 'assets/images/mission_thumb.png',
  );
  final String missionTitle = 'Real–Life Mission !';
  final String missionTitleTranslation = 'Echte Mission';
  final String missionInstruction =
      'Finde etwas Oranges in deiner Wohnung';
  final String missionTranslation =
      'Find something orange in your apartment';

  // ── Practice Tab Data ──
  final RxList<ChatMessage> chatMessages = <ChatMessage>[
    ChatMessage(
      text: 'I can help you in English,\n'
          'or you can start speaking German right away.\n'
          'I will also ask you simple questions to help you practice.',
      isBot: true,
    ),
    ChatMessage(
      text: 'For example',
      isBot: true,
      germanExample: '„Wo ist … ?"',
      englishExample: '(Where is … ?)',
    ),
  ].obs;
  final chatInputController = TextEditingController();
  final RxBool isRecording = false.obs;

  void switchTab(int index) {
    currentTab.value = index;
  }

  void onGotIt(BuildContext context) {
    // Move to Mission tab
    currentTab.value = 1;
  }

  void onDonePractice(BuildContext context) {
    // Move to Practice tab
    currentTab.value = 2;
  }

  void onDone(BuildContext context) {
    // Complete lesson, go back
    Navigator.pop(context);
  }

  void onTalkWithAnja() {
    isRecording.value = !isRecording.value;
    // TODO: Implement voice recording
  }

  void onSendChat() {
    final text = chatInputController.text.trim();
    if (text.isEmpty) return;

    chatMessages.add(ChatMessage(text: text, isBot: false));
    chatInputController.clear();

    // TODO: Send to AI and get response
  }

  void onSendVoice() {
    // TODO: Send voice message
  }

  @override
  void onClose() {
    chatInputController.dispose();
    super.onClose();
  }
}

// ── Chat Message Model ──
class ChatMessage {
  final String text;
  final bool isBot;
  final String? germanExample;
  final String? englishExample;

  ChatMessage({
    required this.text,
    required this.isBot,
    this.germanExample,
    this.englishExample,
  });
}
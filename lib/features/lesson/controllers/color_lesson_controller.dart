import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assert_image.dart';
import '../../video_player/controllers/video_player_controller.dart';
import '../../video_player/models/video_source.dart';
class LessonController extends GetxController {
  final RxInt currentTab = 0.obs;
  final String lessonTitle;
  final String lessonTranslation;
  final String unitTitle;
  final bool isForLesson;
  final appImage = AppAssertImage.instance;

  LessonController({
    required this.lessonTitle,
    required this.lessonTranslation,
    required this.unitTitle,
    required this.isForLesson,
  });

  // ── Tab labels — 2 or 3 tabs depending on isForLesson ──
  List<String> get tabs => isForLesson
      ? ['Learn / Lerne', 'Mission', 'Practice / üben']
      : ['Learn / Lerne', 'Mission'];

  // ── Learn Tab Data ──
  late final VideoSource learnVideoSource = VideoSource.asset(
    'assets/video/video_demo.mp4',
    thumbnailAssetPath: 'assets/images/learn_thumb.png',
  );
  final String anjaSays = '"Das ist rot"';
  final String anjaTranslation = '" This is red "';

  // ── Mission Tab Data ──
  late final VideoSource missionVideoSource = VideoSource.asset(
    'assets/video/video_demo.mp4',
    thumbnailAssetPath: 'assets/images/secound_thumbnail.png',
  );
  final String missionTitle = 'Real–Life Mission !';
  final String missionTitleTranslation = 'Echte Mission';
  final String missionInstruction = '"Finde etwas Red in deiner Wohnung"';
  final String missionTranslation = '"Find something red in your apartment"';

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

  late final TextEditingController chatInputController = TextEditingController();
  final RxBool isRecording = false.obs;
  final RxString selectedInput = ''.obs; // '' | 'voice' | 'text'

  void switchTab(int index) {
    // Pause video of the tab we're leaving
    if (currentTab.value == 0) {
      try {
        final learnController =
        Get.find<AppVideoPlayerController>(tag: 'learn_video');
        learnController.videoController?.pause();
      } catch (_) {}
    } else if (currentTab.value == 1) {
      try {
        final missionController =
        Get.find<AppVideoPlayerController>(tag: 'mission_video');
        missionController.videoController?.pause();
      } catch (_) {}
    }

    // Reset input selection when leaving practice tab
    if (currentTab.value == 2) {
      selectedInput.value = '';
    }

    currentTab.value = index;
  }

  void onGotIt(BuildContext context) {
    currentTab.value = 1;
  }

  void onDonePractice(BuildContext context) {
    if (isForLesson) {
      currentTab.value = 2;
    } else {
      Navigator.pop(context);
    }
  }

  void onDone(BuildContext context) {
    Navigator.pop(context);
  }

  void onTalkWithAnja() {
    selectedInput.value = 'voice';
    isRecording.value = !isRecording.value;
  }

  void onSendChat() {
    final text = chatInputController.text.trim();
    if (text.isEmpty) return;
    chatMessages.add(ChatMessage(text: text, isBot: false));
    chatInputController.clear();
    // TODO: Send to AI and get response
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
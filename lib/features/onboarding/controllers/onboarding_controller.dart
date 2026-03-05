// onboarding_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assert_image.dart';
import '../../../core/util/app_navigation.dart';
import '../../../core/util/storage_service.dart';
import '../views/account_selection_screen.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;
  final appImage = AppAssertImage.instance;

  late final List<OnboardingPage> pages = [
    // Screen 1: Image first, then text
    OnboardingPage(
      title: 'Meet Anja! 👋',
      titleTranslation: 'Triff Anja!',
      image: appImage.onboardingImage1,
      bottomTitle: 'Your personal German coach',
      bottomSubtitle:
      'Learn through real-life missions and practical conversations.\nNo boring grammar drills — just real-world German.',
      bottomSubtitleTranslation:
      'Lerne durch echte Alltagssituationen\nund praktische Gespräche.\nKein langweiliges Pauken — nur\nechtes Deutsch.',
      buttonText: 'Next',
      buttonTranslation: 'Weiter',
      imageFirst: true,
    ),
    // Screen 2: Title first, then image
    OnboardingPage(
      title: 'Learn by Doing! 🎯',
      titleTranslation: 'Lernen durch Tun!',
      image: appImage.onboardingImage2,
      bottomTitle: 'Learn fast. Practice instantly.\nImprove daily.',
      bottomSubtitle:
      'Short lessons. Real missions. AI feedback\n— all in 5 minutes.',
      bottomSubtitleTranslation:
      'Schau kurze Videos, erledige echte Aufgaben\nund übe mit KI — alles in 5 Minuten.',
      buttonText: 'Next',
      buttonTranslation: 'Weiter',
      imageFirst: false,
    ),
    // Screen 3: Image first, then text
    OnboardingPage(
      title: 'Ready for your first\nmission ?',
      titleTranslation: 'Bereit für deine erste Mission?',
      image: appImage.onboardingImage3,
      bottomTitle: "Let's start with something simple —\nColors",
      bottomSubtitle: '',
      bottomSubtitleTranslation:
      'Lass uns mit etwas Einfachem beginnen\n— Farben',
      buttonText: 'Start',
      buttonTranslation: 'Gleiches',
      imageFirst: true,
    ),
  ];

  void nextPage(BuildContext context) {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding(context);
    }
  }

  void skipOnboarding(BuildContext context) {
    completeOnboarding(context);
  }

  void completeOnboarding(BuildContext context) {
    StorageService.saveOnboardingCompleted();
    AppNavigation.pushAndClear( AccountSelectionScreen());
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
class OnboardingPage {
  final String title;
  final String titleTranslation;
  final String image;
  final String bottomTitle;
  final String bottomSubtitle;
  final String bottomSubtitleTranslation;
  final String buttonText;
  final String buttonTranslation;
  final bool imageFirst;

  OnboardingPage({
    required this.title,
    this.titleTranslation = '',
    required this.image,
    required this.bottomTitle,
    required this.bottomSubtitle,
    this.bottomSubtitleTranslation = '',
    this.buttonText = 'Next',
    this.buttonTranslation = 'Weiter',
    this.imageFirst = true,
  });
}
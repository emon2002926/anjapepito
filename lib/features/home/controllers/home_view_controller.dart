import 'package:anjapepito/core/util/app_navigation.dart';
import 'package:anjapepito/features/notification/views/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/snakbar/custom_snackbar.dart';
import '../../lesson/views/color_lesson_screen.dart';
import '../models/lesson_item.dart';


class HomeViewController extends GetxController {
  final RxInt totalXp = 0.obs;
  final RxInt streak = 0.obs;
  final RxInt completedLessons = 0.obs;
  final RxInt totalLessons = 5.obs;
  final RxDouble unitProgress = 0.0.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late final RxList<LessonItem> lessons = <LessonItem>[
    LessonItem(
      title: 'Color : Red',
      translation: 'Farbe : Rot',
      xp: 20,
      isUnlocked: true,
      colorIcon: Colors.red,
    ),
    LessonItem(
      title: 'Color : Blue',
      translation: 'Farbe : Blau',
      xp: 20,
      isUnlocked: false,
    ),
    LessonItem(
      title: 'Color : Blue',
      translation: 'Farbe : Blau',
      xp: 20,
      isUnlocked: false,
    ),
    LessonItem(
      title: 'Color : Blue',
      translation: 'Farbe : Blau',
      xp: 20,
      isUnlocked: false,
    ),
    LessonItem(
      title: 'Color : Blue',
      translation: 'Farbe : Blau',
      xp: 20,
      isUnlocked: false,
    ),
  ].obs;

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void onNotificationTap(BuildContext context) {
    // TODO: Navigate to notifications
    AppNavigation.push( NotificationPage());
  }

  void onLessonTap(BuildContext context, int index) {
    if (!lessons[index].isUnlocked) {
      CustomSnackBar.info('Complete previous lessons to unlock');
      return;
    }
    Get.to(
      () => LessonScreen(
        lessonTitle: 'Color : Orange',
        lessonTranslation: 'Farbe : Orange',
        unitTitle: 'Unit 1 : Colors',
        isForLesson: true,
      )
    );
    // AppNavigation.push(
    //   context,
    //   ColorLessonScreen(
    //     lessonTitle: 'Color : Orange',
    //     lessonTranslation: 'Farbe : Orange',
    //     unitTitle: 'Unit 1 : Colors',
    //   ),
    // );
  }
}


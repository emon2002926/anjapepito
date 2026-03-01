
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../lesson/views/color_lesson_screen.dart';
enum LessonStatus { completed, incomplete }

class UnitLesson {
  final String title;
  final String translation;
  final int xp;
  final LessonStatus status;

  UnitLesson({
    required this.title,
    required this.translation,
    required this.xp,
    required this.status,
  });
}

class UnitDetailController extends GetxController {
  final String unitTitle;

  UnitDetailController({required this.unitTitle});

  final RxList<UnitLesson> lessons = <UnitLesson>[
    UnitLesson(
      title: 'Color : Orange',
      translation: 'Farbe : Orange',
      xp: 20,
      status: LessonStatus.completed,
    ),
    UnitLesson(
      title: 'Color : Orange',
      translation: 'Farbe : Orange',
      xp: 20,
      status: LessonStatus.completed,
    ),
    UnitLesson(
      title: 'Color : Orange',
      translation: 'Farbe : Orange',
      xp: 20,
      status: LessonStatus.completed,
    ),
    UnitLesson(
      title: 'Color : Orange',
      translation: 'Farbe : Orange',
      xp: 20,
      status: LessonStatus.completed,
    ),
    UnitLesson(
      title: 'Color : Orange',
      translation: 'Farbe : Orange',
      xp: 20,
      status: LessonStatus.incomplete,
    ),
  ].obs;

  void onLessonTap(BuildContext context, int index) {
    Get.to(
            () => LessonScreen(
          lessonTitle: 'Color : Orange',
          lessonTranslation: 'Farbe : Orange',
          unitTitle: 'Unit 1 : Colors',
          isForLesson: false,
        )
    );

  }
}
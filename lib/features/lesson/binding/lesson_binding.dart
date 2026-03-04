import 'package:anjapepito/features/lesson/controllers/color_lesson_controller.dart';
import 'package:get/get.dart';

class LessonBinding {
  LessonBinding._();

  static void dependencies() {
    Get.lazyPut<LessonController>(
          () => throw UnimplementedError(
          "LessonController must be created with parameters"),
      fenix: false,
    );
  }

  static LessonController create({
    required String lessonTitle,
    required String lessonTranslation,
    required String unitTitle,
    required bool isForLesson,
  }) {
    return Get.put(
      LessonController(
        lessonTitle: lessonTitle,
        lessonTranslation: lessonTranslation,
        unitTitle: unitTitle,
        isForLesson: isForLesson,
      ),
    );
  }
}
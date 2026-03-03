import 'dart:ui';

class LessonItem {
  final String title;
  final String translation;
  final int xp;
  final bool isUnlocked;
  final Color? colorIcon;

  LessonItem({
    required this.title,
    required this.translation,
    required this.xp,
    required this.isUnlocked,
    this.colorIcon,
  });
}
import 'dart:ui';

class StatItem {
  final String emoji;
  final String value;
  final String label;
  final Color color;
  final List<Color> gradientColors;
  final double barFill;
  final bool isSplit;

  const StatItem({
    required this.emoji,
    required this.value,
    required this.label,
    required this.gradientColors,
    required this.barFill,
    required this.isSplit, required this.color,
  });
}
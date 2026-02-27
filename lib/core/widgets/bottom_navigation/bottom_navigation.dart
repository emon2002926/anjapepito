import 'package:flutter/material.dart';
import '../../constants/app_assert_image.dart';
import '../../util/screen_size.dart';
import '../text/app_text.dart';



// ══════════════════════════════════════════════════════
// custom_bottom_navigation_bar.dart
// ══════════════════════════════════════════════════════

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.home_rounded,
        'label': 'Home',
      },
      {
        'icon': Icons.track_changes_rounded,
        'label': 'Units',
      },
      {
        'icon': Icons.emoji_events_rounded,
        'label': 'Badges',
      },
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF4CB8B3),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.responsiveSize(12),
            horizontal: context.responsiveSize(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = currentIndex == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTabSelected(index),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon with yellow gradient for selected
                      ShaderMask(
                        shaderCallback: (bounds) {
                          if (isSelected) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFFFEB3B),
                                Color(0xFFFFD600),
                              ],
                            ).createShader(bounds);
                          }
                          return const LinearGradient(
                            colors: [Colors.white, Colors.white],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcIn,
                        child: Icon(
                          item['icon'] as IconData,
                          size: context.responsiveSize(28),
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: context.responsiveSize(4)),
                      AppText(
                        data: item['label'] as String,
                        fontSize: 12,
                        fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? const Color(0xFFFFEB3B) // Yellow
                            : Colors.white,
                        useResponsiveFontSize: true,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
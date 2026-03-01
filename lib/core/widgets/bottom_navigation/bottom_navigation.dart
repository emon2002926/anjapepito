import 'package:flutter/material.dart';
import '../../constants/app_assert_image.dart';
import '../../util/screen_size.dart';
import '../text/app_text.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;
  final assets = AppAssertImage.instance;


   CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'selectedIcon': assets.homeSelected,
        'unselectedIcon': assets.home,
        'label': 'Home',
      },
      {
        'selectedIcon': assets.unitsSelected,
        'unselectedIcon': assets.units,
        'label': 'Units',
      },
      {
        'selectedIcon': assets.trophySelected,
        'unselectedIcon': assets.trophy,
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
            vertical: context.responsiveSize(8),
            horizontal: context.responsiveSize(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = currentIndex == index;
              final label = item['label'] as String;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTabSelected(index),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ── Icon ──
                      SizedBox(height: context.responsiveSize(4),),
                      Image.asset(
                        isSelected
                            ? item['selectedIcon'] as String
                            : item['unselectedIcon'] as String,
                        width: context.responsiveSize(24),
                        height: context.responsiveSize(24),
                      ),

                      SizedBox(height: context.responsiveSize(4)),

                      // ── Label (first letter yellow, rest white when selected) ──
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: label[0],
                              style: TextStyle(
                                fontSize: context.responsiveSize(12),
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? const Color(0xFFFFEB3B)
                                    : Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: label.substring(1),
                              style: TextStyle(
                                fontSize: context.responsiveSize(12),
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
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
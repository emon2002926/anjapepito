// onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/util/screen_size.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9F5ED),
      body: SafeArea(
        child: Column(
          children: [
            // PageView
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: (index) {
                  controller.currentPage.value = index;
                },
                itemCount: controller.pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(context, controller.pages[index]);
                },
              ),
            ),

            // Bilingual Button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveSize(24),
              ),
              child: Obx(() {
                final page =
                controller.pages[controller.currentPage.value];
                return GestureDetector(
                  onTap: () => controller.nextPage(context),
                  child: Container(
                    width: double.infinity,
                    height: context.responsiveSize(56),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CB8B3),
                      borderRadius: BorderRadius.circular(
                        context.responsiveSize(28),
                      ),
                    ),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: _buildButtonTextSpans(
                            context,
                            page.buttonText,
                            page.buttonTranslation,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: context.responsiveSize(20)),

            // Dot Indicators
            Obx(
                  () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.pages.length,
                      (index) => _buildDot(
                    context,
                    index,
                    controller.currentPage.value,
                  ),
                ),
              ),
            ),

            SizedBox(height: context.responsiveSize(20)),
          ],
        ),
      ),
    );
  }

  // ── Page Builder ──
  Widget _buildPage(BuildContext context, OnboardingPage page) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveSize(24),
      ),
      child: Column(
        children: [
          if (page.imageFirst) ...[
            // IMAGE FIRST layout (Screen 1 & 3)
            SizedBox(height: context.responsiveSize(34)),
            _buildCircularImage(context, page.image),
            SizedBox(height: context.responsiveSize(24)),
            _buildTitle(context, page.title),
            if (page.titleTranslation.isNotEmpty) ...[
              SizedBox(height: context.responsiveSize(4)),
              _buildOrangeText(context, page.titleTranslation, 16),
            ],
            SizedBox(height: context.responsiveSize(16)),
            _buildBoldSubtitle(context, page.bottomTitle),
            if (page.bottomSubtitle.isNotEmpty) ...[
              SizedBox(height: context.responsiveSize(12)),
              _buildGrayText(context, page.bottomSubtitle),
            ],
            if (page.bottomSubtitleTranslation.isNotEmpty) ...[
              SizedBox(height: context.responsiveSize(12)),
              _buildOrangeText(
                context,
                page.bottomSubtitleTranslation,
                14,
              ),
            ],
          ] else ...[
            // TITLE FIRST layout (Screen 2)
            SizedBox(height: context.responsiveSize(24)),
            _buildTitle(context, page.title),
            if (page.titleTranslation.isNotEmpty) ...[
              SizedBox(height: context.responsiveSize(4)),
              _buildOrangeText(context, page.titleTranslation, 16),
            ],
            SizedBox(height: context.responsiveSize(20)),
            _buildCircularImage(context, page.image),
            SizedBox(height: context.responsiveSize(24)),
            _buildBoldSubtitle(context, page.bottomTitle),
            if (page.bottomSubtitle.isNotEmpty) ...[
              SizedBox(height: context.responsiveSize(12)),
              _buildGrayText(context, page.bottomSubtitle),
            ],
            if (page.bottomSubtitleTranslation.isNotEmpty) ...[
              SizedBox(height: context.responsiveSize(12)),
              _buildOrangeText(
                context,
                page.bottomSubtitleTranslation,
                14,
              ),
            ],
          ],
        ],
      ),
    );
  }

  // ── Circular Image with White Border ──
  Widget _buildCircularImage(BuildContext context, String imagePath) {
    final size = context.responsiveSize(280);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.8),
          width: context.responsiveSize(4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFEDE8DF),
              child: Center(
                child: Icon(
                  Icons.image,
                  size: context.responsiveSize(60),
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ── Main Title (Dark, Bold) ──
  Widget _buildTitle(BuildContext context, String text) {
    return AppText(
      data: text,
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF2D2D2D),
      useResponsiveFontSize: true,
      textAlign: TextAlign.center,
    );
  }

  // ── Orange Translation Text ──
  Widget _buildOrangeText(
      BuildContext context, String text, double size) {
    return AppText(
      data: text,
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFE8842A),
      useResponsiveFontSize: true,
      textAlign: TextAlign.center,
    );
  }

  // ── Bold Subtitle ──
  Widget _buildBoldSubtitle(BuildContext context, String text) {
    return AppText(
      data: text,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF2D2D2D),
      useResponsiveFontSize: true,
      textAlign: TextAlign.center,
    );
  }

  // ── Gray Description Text ──
  Widget _buildGrayText(BuildContext context, String text) {
    return AppText(
      data: text,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF8E8E8E),
      useResponsiveFontSize: true,
      textAlign: TextAlign.center,
    );
  }

  // ── Bilingual Button Text with First Letters Yellow ──
  List<TextSpan> _buildButtonTextSpans(
      BuildContext context,
      String primaryText,
      String translationText,
      ) {
    const yellowColor = Color(0xFFFFEB3B);
    const whiteColor = Colors.white;
    final fontSize = context.responsiveSize(17);

    TextSpan buildStyledWord(String word) {
      if (word.isEmpty) return const TextSpan();
      return TextSpan(
        children: [
          // First letter — yellow
          TextSpan(
            text: word[0],
            style: TextStyle(
              color: yellowColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
            ),
          ),
          // Rest of the word — white
          TextSpan(
            text: word.substring(1),
            style: TextStyle(
              color: whiteColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }

    return [
      buildStyledWord(primaryText),
      TextSpan(
        text: ' → ',
        style: TextStyle(
          color: whiteColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
      buildStyledWord(translationText),
    ];
  }

  // ── Dot Indicator ──
  Widget _buildDot(BuildContext context, int index, int currentPage) {
    final isActive = index == currentPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(
        horizontal: context.responsiveSize(4),
      ),
      width: isActive
          ? context.responsiveSize(24)
          : context.responsiveSize(8),
      height: context.responsiveSize(8),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFFE8A838)
            : const Color(0xFFCCCCCC),
        borderRadius: BorderRadius.circular(
          context.responsiveSize(4),
        ),
      ),
    );
  }
}
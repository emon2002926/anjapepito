import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/util/screen_size.dart';
import '../../../core/widgets/app_bar/build_app_bar.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/terms_controller.dart';
class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TermsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9F5ED),extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: BuildAppBar(
        title: 'Terms and Conditions',
        showBackButton: true,
        onBackButtonPressed: () => Navigator.pop(context),
        titleFontSize: 20,
        fontWeight: FontWeight.w900,
        backButtonIcon: Icons.chevron_left,
        useMinimalStyle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveSize(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.responsiveSize(12)),

                    // Header Card
                    _buildHeaderCard(context, controller),

                    SizedBox(height: context.responsiveSize(20)),

                    // Main Title
                    AppText(
                      data: controller.mainTitle,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2D2D2D),
                      useResponsiveFontSize: true,
                    ),

                    SizedBox(height: context.responsiveSize(16)),

                    // Sections
                    ...controller.sections.map(
                          (section) => _buildSection(context, section),
                    ),

                    SizedBox(height: context.responsiveSize(40)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(
      BuildContext context, TermsController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.responsiveSize(20)),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E8),
        borderRadius: BorderRadius.circular(
          context.responsiveSize(16),
        ),
        border: Border.all(
          color: const Color(0xFFE8E4DC),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Lock Icon
          Icon(
            Icons.lock_outlined,
            size: context.responsiveSize(28),
            color: const Color(0xFFE8A838),
          ),

          SizedBox(height: context.responsiveSize(8)),

          // Title
          AppText(
            data: controller.headerTitle,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2D2D2D),
            useResponsiveFontSize: true,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: context.responsiveSize(8)),

          // Description
          AppText(
            data: controller.headerDescription,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6B6B6B),
            useResponsiveFontSize: true,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, TermsSection section) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.responsiveSize(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          AppText(
            data: section.title,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2D2D2D),
            useResponsiveFontSize: true,
          ),

          SizedBox(height: context.responsiveSize(8)),

          // Content
          AppText(
            data: section.content,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF4A4A4A),
            useResponsiveFontSize: true,
          ),

          // Bullets
          if (section.bullets != null) ...[
            SizedBox(height: context.responsiveSize(6)),
            ...section.bullets!.map(
                  (bullet) => Padding(
                padding: EdgeInsets.only(
                  left: context.responsiveSize(12),
                  bottom: context.responsiveSize(4),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: context.responsiveSize(6),
                      ),
                      child: Container(
                        width: context.responsiveSize(4),
                        height: context.responsiveSize(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFF4A4A4A),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(width: context.responsiveSize(8)),
                    Expanded(
                      child: AppText(
                        data: bullet,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF4A4A4A),
                        useResponsiveFontSize: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Extra Content
          if (section.extraContent != null) ...[
            SizedBox(height: context.responsiveSize(8)),
            AppText(
              data: section.extraContent!,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF4A4A4A),
              useResponsiveFontSize: true,
            ),
          ],

          // Footer Content
          if (section.footerContent != null) ...[
            SizedBox(height: context.responsiveSize(8)),
            AppText(
              data: section.footerContent!,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF4A4A4A),
              useResponsiveFontSize: true,
            ),
          ],
        ],
      ),
    );
  }
}
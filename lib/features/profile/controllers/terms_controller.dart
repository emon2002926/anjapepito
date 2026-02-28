import 'package:get/get.dart';
class TermsController extends GetxController {
  // Terms content - can be fetched from API later
  final String headerTitle = 'Your Privacy Matters';
  final String headerDescription =
      'We respect your privacy and are committed to protecting your data while you create and share dance videos';

  final String mainTitle = 'Fair Use Policy (Unlimited & High-Volume Plans)';

  final List<TermsSection> sections = [
    TermsSection(
      title: '1. Purpose of Fair Use',
      content:
      'Flowverse offers high-volume and unlimited subscription plans to support professional creators, choreographers, and studios. This Fair Use Policy exists to ensure platform stability, performance, and equitable access for all users.',
    ),
    TermsSection(
      title: '2. Scope',
      content: 'This policy applies to:',
      bullets: [
        'Pro+ Unlimited subscriptions',
        'Any plan or add-on that includes high-volume or unlimited exports',
      ],
    ),
    TermsSection(
      title: '3. Acceptable Use',
      content: 'Subscribers may use Flowverse to:',
      bullets: [
        'Generate dance videos for personal or professional creative projects',
        'Create social media content, auditions, showcases, and promotional materials',
        'Produce client work as part of choreography, instruction, or studio operations',
        'Revise, iterate, and export multiple versions of the same choreography',
      ],
      extraContent:
      'Use should reflect human-initiated, creative workflows consistent with individual creators or small teams.',
    ),
    TermsSection(
      title: '4. Prohibited Use',
      content: 'The following activities are not permitted under any plan:',
      bullets: [
        'Automated, scripted, or programmatic generation of exports',
        'Use of bots or third-party automation tools',
        'Resale or sublicensing of Flowverse outputs as a standalone service',
        'Excessive usage intended to benchmark, stress-test, or reverse engineer the system',
        'Any activity that interferes with or degrades platform performance',
      ],
    ),
    TermsSection(
      title: '5. Reasonable Usage Thresholds',
      content:
      'While Flowverse does not impose hard export caps on unlimited plans, usage significantly exceeding typical creator patterns may be reviewed.',
      extraContent: 'As general guidance:',
      bullets: [
        'Usage above approximately 300 exports per billing cycle may trigger a review for compliance with this policy',
      ],
      footerContent:
      'Reviews are conducted to understand usage needs and are not punitive by default.',
    ),
    TermsSection(
      title: '6. Enforcement & Resolution',
      content: 'If usage appears inconsistent with this policy, Flowverse may:',
      bullets: [
        'Contact the account holder to discuss usage patterns',
        'Recommend an alternative plan or custom enterprise agreement',
      ],
    ),
  ];
}

class TermsSection {
  final String title;
  final String content;
  final List<String>? bullets;
  final String? extraContent;
  final String? footerContent;

  TermsSection({
    required this.title,
    required this.content,
    this.bullets,
    this.extraContent,
    this.footerContent,
  });
}
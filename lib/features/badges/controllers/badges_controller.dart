import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/snakbar/custom_snackbar.dart';
import '../../base_screen/controllers/base_controller.dart';
import '../models/badge_item.dart';

class BadgesController extends GetxController {
  final RxList<BadgeItem> badges = <BadgeItem>[
    BadgeItem(title: 'Unit:1', subtitle: 'Color', isUnlocked: true),
    BadgeItem(title: 'Unit:2', subtitle: 'Fruit', isUnlocked: false),
    BadgeItem(title: 'Unit:3', subtitle: 'Fruit', isUnlocked: false),
    BadgeItem(title: 'Unit:4', subtitle: 'Fruit', isUnlocked: false),
    BadgeItem(title: 'Unit:5', subtitle: 'Fruit', isUnlocked: false),
    BadgeItem(title: 'Unit:6', subtitle: 'Fruit', isUnlocked: false),
    BadgeItem(title: 'Unit:7', subtitle: 'Fruit', isUnlocked: false),
    BadgeItem(title: 'Unit:8', subtitle: 'Fruit', isUnlocked: false),
    BadgeItem(title: 'Unit:9', subtitle: 'Fruit', isUnlocked: false),
  ].obs;

  void openDrawer() {
    Get.find<BaseController>().openDrawer();
  }

  void onNotificationTap(BuildContext context) {
    // TODO: Navigate to notifications
  }

  void onNextTap(BuildContext context) {
    // TODO: Navigate to next
  }

  void onBadgeTap(BuildContext context, BadgeItem badge) {
    if (!badge.isUnlocked) {
      CustomSnackBar.info('Complete this unit to earn the badge');
      return;
    }
    // TODO: Show badge detail
    // AppNavigation.push(context, UnitDetailPage(unitTitle: 'Unit 1: Colors',));
  }
}
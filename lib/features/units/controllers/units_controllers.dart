import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/util/app_navigation.dart';
import '../../../core/widgets/snakbar/custom_snackbar.dart';
import '../views/unit_detail_page.dart';
enum UnitStatus { completed, inProgress, locked }

class UnitItem {
  final String title;
  final String subtitle;
  final int xp;
  final UnitStatus status;
  final double progress; // 0.0 to 1.0

  UnitItem({
    required this.title,
    required this.subtitle,
    required this.xp,
    required this.status,
    required this.progress,
  });
}

class UnitsController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final RxList<UnitItem> completedUnits = <UnitItem>[
    UnitItem(
      title: 'Unit : 1',
      subtitle: 'Colors/Farbe',
      xp: 100,
      status: UnitStatus.completed,
      progress: 1.0,
    ),
    UnitItem(
      title: 'Unit : 2',
      subtitle: 'Fruit/das Obst',
      xp: 100,
      status: UnitStatus.inProgress,
      progress: 0.5,
    ),
  ].obs;

  final RxList<UnitItem> availableUnits = <UnitItem>[
    UnitItem(
      title: 'Unit : 3',
      subtitle: 'Colors/Farbe',
      xp: 100,
      status: UnitStatus.locked,
      progress: 0.0,
    ),
    UnitItem(
      title: 'Unit : 4',
      subtitle: 'Colors/Farbe',
      xp: 100,
      status: UnitStatus.locked,
      progress: 0.0,
    ),
    UnitItem(
      title: 'Unit : 5',
      subtitle: 'Colors/Farbe',
      xp: 100,
      status: UnitStatus.locked,
      progress: 0.0,
    ),
    UnitItem(
      title: 'Unit : 6',
      subtitle: 'Colors/Farbe',
      xp: 100,
      status: UnitStatus.locked,
      progress: 0.0,
    ),
    UnitItem(
      title: '3rd Mission',
      subtitle: 'Colors/Farbe',
      xp: 100,
      status: UnitStatus.locked,
      progress: 0.0,
    ),
  ].obs;

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void onNotificationTap(BuildContext context) {
    // TODO: Navigate to notifications
  }

  void onUnitTap(BuildContext context, UnitItem unit) {
    if (unit.status == UnitStatus.locked) {
      CustomSnackBar.info('Complete previous units to unlock');
      return;
    }
    AppNavigation.push( UnitDetailPage(unitTitle: 'Unit 1: Colors',));


    // TODO: Navigate to unit detail
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BaseController extends GetxController {
  final RxInt currentIndex = 0.obs;
  int lastTapTime = 0;

  final homeNavKey = GlobalKey<NavigatorState>();
  final unitsNavKey = GlobalKey<NavigatorState>();
  final badgesNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void onTabSelected(int index) {
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (index == currentIndex.value && currentTime - lastTapTime < 500) {
      if (index == 0) {
        homeNavKey.currentState?.popUntil((route) => route.isFirst);
      } else if (index == 1) {
        unitsNavKey.currentState?.popUntil((route) => route.isFirst);
      } else if (index == 2) {
        badgesNavKey.currentState?.popUntil((route) => route.isFirst);
      }
    } else {
      currentIndex.value = index;
    }

    lastTapTime = currentTime;
  }
}
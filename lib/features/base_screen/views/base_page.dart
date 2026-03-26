import 'package:anjapepito/features/units/views/units_page.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_assert_image.dart';
import '../../../core/widgets/Drawer/app_drawer.dart';
import '../../../core/widgets/bottom_navigation/bottom_navigation.dart';
import '../../../core/widgets/guest_overlay/guest_overlay.dart';
import '../../badges/views/badges_page.dart';
import '../controllers/base_controller.dart';
import '../../home/views/home_view.dart';
import 'package:get/get.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BaseController>();
    final screens = [
      HomeView(),
      GuestOverlay(child: const UnitsPage()),
      GuestOverlay(child: const BadgesPage()),
    ];

    return Obx(() => Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: Colors.transparent,
      extendBody: true,
      drawer: const CustomAppDrawer(),
      body: Stack(
        children: [
          // ── Background image ──
          Positioned.fill(
            child: Image.asset(
              AppAssertImage.instance.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),

          // ── Page content ──
          WillPopScope(
            onWillPop: () {
              if (controller.currentIndex.value == 0 &&
                  controller.homeNavKey.currentState!.canPop()) {
                controller.homeNavKey.currentState?.pop();
                return Future.value(false);
              } else if (controller.currentIndex.value == 1 &&
                  controller.unitsNavKey.currentState!.canPop()) {
                controller.unitsNavKey.currentState?.pop();
                return Future.value(false);
              } else if (controller.currentIndex.value == 2 &&
                  controller.badgesNavKey.currentState!.canPop()) {
                controller.badgesNavKey.currentState?.pop();
                return Future.value(false);
              }
              return Future.value(true);
            },
            child: IndexedStack(
              index: controller.currentIndex.value,
              children: [
                Navigator(
                  key: controller.homeNavKey,
                  onGenerateInitialRoutes: (navigator, initialRoute) =>
                  [MaterialPageRoute(builder: (context) => screens[0])],
                ),
                Navigator(
                  key: controller.unitsNavKey,
                  onGenerateInitialRoutes: (navigator, initialRoute) =>
                  [MaterialPageRoute(builder: (context) => screens[1])],
                ),
                Navigator(
                  key: controller.badgesNavKey,
                  onGenerateInitialRoutes: (navigator, initialRoute) =>
                  [MaterialPageRoute(builder: (context) => screens[2])],
                ),
              ],
            ),
          ),

          // ── Floating Navbar ──
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              onTabSelected: controller.onTabSelected,
            ),
          ),
        ],
      ),
    ));
  }
}
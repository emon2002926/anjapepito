import 'package:anjapepito/features/units/views/units_page.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/bottom_navigation/bottom_navigation.dart';
import '../../../core/widgets/guest_overlay/guest_overlay.dart';
import '../../badges/views/badges_page.dart';
import 'home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentIndex = 0;
  int lastTapTime = 0;

  final homeNavKey = GlobalKey<NavigatorState>();
  final unitsNavKey = GlobalKey<NavigatorState>();
  final badgesNavKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  void onTabSelected(int index) {
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (index == currentIndex && currentTime - lastTapTime < 500) {
      if (index == 0) {
        homeNavKey.currentState?.popUntil((route) => route.isFirst);
      } else if (index == 1) {
        unitsNavKey.currentState?.popUntil((route) => route.isFirst);
      } else if (index == 2) {
        badgesNavKey.currentState?.popUntil((route) => route.isFirst);
      }
    } else {
      setState(() {
        currentIndex = index;
      });
    }

    lastTapTime = currentTime;
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeView(),
      GuestOverlay(child: const UnitsPage()),
      GuestOverlay(child: const BadgesPage()),

    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F5ED),
      extendBody: true,
      body: WillPopScope(
        onWillPop: () {
          if (currentIndex == 0 && homeNavKey.currentState!.canPop()) {
            homeNavKey.currentState?.pop();
            return Future.value(false);
          } else if (currentIndex == 1 &&
              unitsNavKey.currentState!.canPop()) {
            unitsNavKey.currentState?.pop();
            return Future.value(false);
          } else if (currentIndex == 2 &&
              badgesNavKey.currentState!.canPop()) {
            badgesNavKey.currentState?.pop();
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: IndexedStack(
          index: currentIndex,
          children: [
            Navigator(
              key: homeNavKey,
              onGenerateInitialRoutes: (navigator, initialRoute) {
                return [
                  MaterialPageRoute(builder: (context) => screens[0])
                ];
              },
            ),
            Navigator(
              key: unitsNavKey,
              onGenerateInitialRoutes: (navigator, initialRoute) {
                return [
                  MaterialPageRoute(builder: (context) => screens[1])
                ];
              },
            ),
            Navigator(
              key: badgesNavKey,
              onGenerateInitialRoutes: (navigator, initialRoute) {
                return [
                  MaterialPageRoute(builder: (context) => screens[2])
                ];
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTabSelected: onTabSelected,
      ),
    );
  }
}
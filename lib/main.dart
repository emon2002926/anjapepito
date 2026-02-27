import 'package:anjapepito/features/home/views/home_page.dart';
import 'package:anjapepito/features/onboarding/views/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'features/splash/controller/splash_controller.dart';
import 'features/splash/views/splash_screen.dart';
void main() {
  Get.lazyPut(() => SplashController());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Ensure status bar styling is applied to all AppBars
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
          ),
        ),
        // home: const OnboardingScreen(),
        home: const HomePage(),
      );
  }

}
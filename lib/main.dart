import 'package:anjapepito/core/bindings/app_bindings.dart';
import 'package:anjapepito/core/util/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'features/home/views/home_page.dart';
void main() {
  AppBindings.init();
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
        navigatorKey: AppNavigation.navigatorKey,
        theme: ThemeData(
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
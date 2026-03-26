import 'package:anjapepito/core/bindings/app_bindings.dart';
import 'package:anjapepito/core/constants/app_strings.dart';
import 'package:anjapepito/core/util/app_navigation.dart';
import 'package:anjapepito/core/util/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'core/services/api_services.dart';
import 'features/auth/sign_in/views/sign_in_screen.dart';
import 'features/base_screen/views/base_page.dart';
  void main() {
    Get.put(ApiServices(baseUrl: AppStrings.instance.baseUrl));

    AppBindings.init();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,   // dark icons on light bg
        statusBarBrightness: Brightness.light,       // iOS
      ),
    );
    runApp(const MyApp());
  }
  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      String? token = StorageService.accessToken;
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
          // home: const SignUpScreen(),
          home: (token == null || token.isEmpty)
              ? const SignInScreen()
              : const BasePage()
        );
    }

  }
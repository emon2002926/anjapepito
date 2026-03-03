import 'package:get/get.dart';

import '../../features/home/binding/home_binding.dart';
import '../../features/home/controllers/home_view_controller.dart';
import '../../features/splash/controller/splash_controller.dart';

class AppBindings {
  AppBindings._();

  static void init() {
    HomeBinding.dependencies();
  }

}
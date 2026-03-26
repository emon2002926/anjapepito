import 'package:get/get.dart';

import '../controllers/badges_controller.dart';


class HomeBinding {
  static void dependencies(){
    Get.lazyPut<BadgesController>(
          ()=> BadgesController(),
      fenix: true,
    );
  }
}
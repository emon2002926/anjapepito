import 'package:anjapepito/features/home/controllers/home_view_controller.dart';
import 'package:get/get.dart';
class HomeBinding {
  static void dependencies(){
    Get.lazyPut<HomeViewController>(
        ()=> HomeViewController(),
      fenix: true,
    );
  }
}
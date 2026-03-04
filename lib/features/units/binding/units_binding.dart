import 'package:anjapepito/features/units/controllers/units_controllers.dart';
import 'package:get/get.dart';
class UnitsBinding {
  static void dependencies(){
    Get.lazyPut<UnitsController>(
          ()=> UnitsController(),
      fenix: true,
    );
  }
}
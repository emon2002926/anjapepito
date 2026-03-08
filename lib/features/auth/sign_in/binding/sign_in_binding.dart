import 'package:anjapepito/features/auth/sign_in/controllers/sign_in_controller.dart';
import 'package:get/get.dart';
class SignInBinding {
  static void dependencies(){
    Get.lazyPut<SignInController>(
          ()=> SignInController(),
      fenix: true,
    );
  }
}
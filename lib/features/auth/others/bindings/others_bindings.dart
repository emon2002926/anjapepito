import 'package:get/get.dart';
import '../controllers/enter_otp_controller.dart';
import '../controllers/forgot_password_controller.dart';
import '../controllers/reset_password_controller.dart';
class OtherAuthBindings {
  static void otpDependencies(){
    Get.lazyPut<EnterOtpController>(
          ()=> EnterOtpController(),
      fenix: true,
    );
  }
  static void forgotPassDependencies(){
    Get.lazyPut<ForgotPasswordController>(
          ()=> ForgotPasswordController(),
      fenix: true,
    );
  }
  static void resetPassDependencies(){
    Get.lazyPut<ResetPasswordController>(
          ()=> ResetPasswordController(),
      fenix: true,
    );
  }
}
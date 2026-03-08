import 'package:anjapepito/features/notification/controllers/notification_controller.dart';
import 'package:get/get.dart';

class NotificationBinding {
  static void dependencies(){
    Get.lazyPut<NotificationController>(
          ()=> NotificationController(),
      fenix: true,
    );
  }
}
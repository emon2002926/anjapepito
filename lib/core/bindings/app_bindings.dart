import 'package:anjapepito/features/notification/bindings/notification_binding.dart';
import '../../features/home/binding/home_binding.dart';
import '../../features/units/binding/units_binding.dart';

class AppBindings {
  AppBindings._();
  static void init() {
    HomeBinding.dependencies();
    NotificationBinding.dependencies();
    UnitsBinding.dependencies();
  }

}
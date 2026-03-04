import 'package:get/get.dart';
import '../models/notification_item.dart';


class NotificationController extends GetxController {
  final RxList<NotificationItem> todayNotifications = <NotificationItem>[
    NotificationItem(
      title: 'New badge earned',
      description: 'You have successfully earned the color batch',
      emoji: '🏆',
      timeAgo: '2 hours ago',
    ),
    NotificationItem(
      title: 'Congratulations',
      description: 'You have successfully unlocked Unit 2: Fruits',
      emoji: '🎉',
      timeAgo: '2 hours ago',
    ),
  ].obs;

  void onNotificationTap(NotificationItem item) {
    // TODO: Handle notification tap
  }
}
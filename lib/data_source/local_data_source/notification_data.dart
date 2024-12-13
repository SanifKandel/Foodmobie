import 'package:foodreminder/helper/objectbox.dart';
import 'package:foodreminder/model/notification.dart';
import 'package:foodreminder/state/objectbox_state.dart';

class NotificationsDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;
  Future<int> addNotifications(FoodMobieNotification notifications) async {
    try {
      return objectBoxInstance.addNotification(notifications);
    } catch (e) {
      return 0;
    }
  }

  Future addAllNotifications(
      List<FoodMobieNotification> lstNotifications) async {
    try {
      return objectBoxInstance.addAllNotification(lstNotifications);
    } catch (e) {
      throw Exception("error adding notifications to object box $e");
    }
  }

  Future<List<FoodMobieNotification>> getAllNotifications() async {
    try {
      return objectBoxInstance.getAllNotification();
    } catch (e) {
      return [];
    }
  }
}

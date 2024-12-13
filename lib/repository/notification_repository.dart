import 'package:foodreminder/app/network_connectivity.dart';
import 'package:foodreminder/data_source/local_data_source/notification_data.dart';
import 'package:foodreminder/data_source/remote_data_source/notification_remote_data_source.dart';
import 'package:foodreminder/model/notification.dart';

abstract class NotificationsRepository {
  Future<List<FoodMobieNotification>> getAllNotifications();
}

class NotificationsRepositoryImpl extends NotificationsRepository {
  @override
  Future<List<FoodMobieNotification>> getAllNotifications() async {
    bool status = await NetworkConnectivity.isOnline();
    List<FoodMobieNotification> lstnotify = [];
    if (status) {
      lstnotify = await NotificationsRemoteDataSource().getAllNotifications();
      await NotificationsDataSource().addAllNotifications(lstnotify);
      return lstnotify;
    } else {
      return NotificationsDataSource().getAllNotifications();
    }
  }
}

import 'package:foodreminder/model/notification.dart';
import 'package:foodreminder/model/reminder.dart';
import 'package:foodreminder/model/userfeedbacks.dart';
import 'package:foodreminder/model/food.dart';
import 'package:foodreminder/model/user.dart';
import 'package:foodreminder/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ObjectBoxInstance {
  late final Store _store;
  late final Box<User> _user;
  late final Box<Food> _food;
  late final Box<Reminder> _reminder;
  late final Box<UserFeedback> _feedback;
  late final Box<FoodMobieNotification> _notification;

  //Constructor to initialize database and its tables
  ObjectBoxInstance(this._store) {
    _user = Box<User>(_store);
    _food = Box<Food>(_store);
    _feedback = Box<UserFeedback>(_store);
    _reminder = Box<Reminder>(_store);
    _notification = Box<FoodMobieNotification>(_store);
  }

  //Initialization of ObjectBox
  static Future<ObjectBoxInstance> init() async {
    var dir = await getApplicationDocumentsDirectory();
    final store = Store(
      getObjectBoxModel(),
      directory: '${dir.path}/foodmobie_users',
    );

    return ObjectBoxInstance(store);
  }

  // Delete Store and all boxes
  static Future<void> deleteDatabase() async {
    var dir = await getApplicationDocumentsDirectory();
    Directory('${dir.path}/foodmobie_users').deleteSync(recursive: true);
  }
  //=========================User Queries============================

  int addUser(User user) {
    return _user.put(user);
  }

  int createFeedback(UserFeedback feedback) {
    return _feedback.put(feedback);
  }

  List<User> getAllUser() {
    return _user.getAll();
  }

  User getUserById(int userId) {
    try {
      User user = _user.get(userId)!;
      if (user == null) {
        throw Exception('User not found');
      }
      return user;
    } catch (e) {
      throw Exception('Error in getting user by ID: ${e.toString()}');
    }
  }

  //Login User
  User? loginUser(String email, String password) {
    return _user
        .query(User_.email.equals(email) & User_.password.equals(password))
        .build()
        .findFirst();
  }

  // Foods
  int addFoods(Food foods) {
    return _food.put(foods);
  }

  // Search food by foodName
  Food? getFoodsByFoodsName(String foodName) {
    return _food.query(Food_.foodId.equals(foodName)).build().findFirst();
  }

  List<Food> getAllFoods() {
    return _food.getAll();
  }

  List<Reminder> getAllReminders() {
    return _reminder.getAll();
  }

  addAllFoods(List<Food> lstFood) {
    for (var item in lstFood) {
      if (_food.query(Food_.foodId.equals(item.foodId)).build().findFirst() ==
          null) {
        _food.put(item);
      }
    }
  }

  // Reminder
  int addReminders(Reminder reminder) {
    return _reminder.put(reminder);
  }

  addAllReminders(List<Reminder> lstReminder) {
    for (var items in lstReminder) {
      if (_reminder
              .query(Reminder_.reminderId.equals(items.reminderId!))
              .build()
              .findFirst() ==
          null) {
        _reminder.put(items);
      }
    }
  }

  // Notifications
  int addNotification(FoodMobieNotification notification) {
    return _notification.put(notification);
  }

  List<FoodMobieNotification> getAllNotification() {
    return _notification.getAll();
  }

  addAllNotification(List<FoodMobieNotification> lstNotification) {
    for (var item in lstNotification) {
      if (_notification
              .query(FoodMobieNotification_.notificationId
                  .equals(item.notificationId))
              .build()
              .findFirst() ==
          null) {
        _notification.put(item);
      }
    }
  }
}

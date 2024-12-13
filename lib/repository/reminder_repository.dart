import 'package:foodreminder/app/network_connectivity.dart';
import 'package:foodreminder/data_source/local_data_source/reminder_data_source.dart';
import 'package:foodreminder/data_source/remote_data_source/reminder_remote_data_source.dart';
import 'package:foodreminder/model/reminder.dart';
import 'dart:io';

abstract class ReminderRepository {
  Future<int> createReminder(File? file, Reminder reminder);
  Future<int> updateReminder(File? file, Reminder reminder);
  Future<int> deleteReminder(String reminderId);
  Future<List<Reminder>> getAllReminders();
}

class ReminderRepositoryImpl extends ReminderRepository {
  @override
  Future<int> createReminder(File? file, Reminder reminder) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return RemindersRemoteDataSource().createReminder(file, reminder);
    } else {
      print('error');
      throw Exception("jhsdjk");

      // return FeedbackDataSource().createFeedback(file, reminder);
    }
  }

  @override
  Future<int> updateReminder(File? file, Reminder reminder) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return RemindersRemoteDataSource().updateReminder(file, reminder);
    } else {
      throw Exception("no local datasource");
    }
  }

  @override
  Future<int> deleteReminder(String reminderId) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return RemindersRemoteDataSource().deleteReminder(reminderId);
    } else {
      throw Exception("no local datasource");
    }
  }

  @override
  Future<List<Reminder>> getAllReminders() async {
    bool status = await NetworkConnectivity.isOnline();
    List<Reminder> lstReminders = [];
    if (status) {
      lstReminders = await RemindersRemoteDataSource().getAllReminder();
      await RemindersDataSource().addAllReminders(lstReminders);
      return lstReminders;
    } else {
      return RemindersDataSource().getAllReminders();
    }
  }
}

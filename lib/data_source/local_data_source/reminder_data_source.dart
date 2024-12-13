import 'package:foodreminder/helper/objectbox.dart';
import 'package:foodreminder/model/reminder.dart';
import 'package:foodreminder/state/objectbox_state.dart';

class RemindersDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;
  Future<int> addreminders(Reminder reminders) async {
    try {
      return objectBoxInstance.addReminders(reminders);
    } catch (e) {
      return 0;
    }
  }

  Future addAllReminders(List<Reminder> lstReminders) async {
    try {
      return objectBoxInstance.addAllReminders(lstReminders);
    } catch (e) {
      throw Exception("error adding food to object box $e");
    }
  }

  Future<List<Reminder>> getAllReminders() async {
    try {
      return objectBoxInstance.getAllReminders();
    } catch (e) {
      return [];
    }
  }

}

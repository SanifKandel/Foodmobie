import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/model/reminder.dart';
import 'package:foodreminder/repository/reminder_repository.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:foodreminder/screen/utils/snackbar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReminderCard extends StatefulWidget {
  const ReminderCard({super.key});

  @override
  State<ReminderCard> createState() => _ReminderCardState();
}

class _ReminderCardState extends State<ReminderCard> {
  final List<Reminder> _reminderList = [];
  final _reminderRepo = ReminderRepositoryImpl();

  void _getAllReminder() async {
    _reminderList.clear();
    List<Reminder> reminders = await _reminderRepo.getAllReminders();
    if (reminders.isNotEmpty) {
      _reminderList.addAll(reminders);
    }
    setState(() {});
  }

  @override
  void initState() {
    _getAllReminder();
    super.initState();
  }

  void _deleteReminder(String reminderId) async {
    int result = await ReminderRepositoryImpl().deleteReminder(reminderId);
    _showMessage(result);
  }

  _showMessage(int status) {
    if (status > 0) {
      showSnackbar(context, 'Reminder Deleted Successfully', Colors.green);
    } else {
      showSnackbar(context, 'Error Deleting Reminder', Colors.red);
    }
  }

  String formattedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        List<Reminder> filteredReminders =
            _reminderList.where((r) => r.date == formattedDate).toList();
        return filteredReminders.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      const Text(
                        "No Reminder Today",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/AddReminder',
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(
                              Icons.add_alarm,
                              color: Colors.greenAccent,
                              size: 40,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Create New Reminder",
                              style: TextStyle(color: Colors.greenAccent),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredReminders.length,
                itemBuilder: (BuildContext context, int index) {
                  Reminder reminder = filteredReminders[index];
                  return Card(
                      color: themeProvider.darkTheme
                          ? Colors.grey.shade900
                          : Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (BuildContext context) {
                                if (reminder.reminderId != null) {
                                  _deleteReminder(reminder.reminderId!);
                                }
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                            const SlidableAction(
                              onPressed: (null),
                              backgroundColor: Color(0xFF21B7CA),
                              foregroundColor: Colors.white,
                              icon: Icons.share,
                              label: 'Share',
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, '/ReminderDetail',
                                arguments: reminder);
                          },
                          leading: Container(
                            height: responsiveHeight(context, 0.04, 0.12),
                            width: responsiveWidth(context, 0.2, 0.06),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: reminder.meal == 'Breakfast'
                                  ? Colors.lightGreenAccent.shade200
                                  : reminder.meal == 'Lunch'
                                      ? Colors.orange.shade300
                                      : Colors.yellowAccent.shade200,
                            ),
                            child: Center(
                              child: Text(
                                "${reminder.meal}",
                                style: TextStyle(
                                  color: themeProvider.darkTheme
                                      ? Colors.black
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                "${reminder.foodname}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize:
                                        responsiveHeight(context, 0.016, 0.04),
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${reminder.calories} Calories',
                                style: TextStyle(
                                    fontSize:
                                        responsiveHeight(context, 0.015, 0.035),
                                    color: Colors.white70),
                              ),
                            ],
                          ),
                          trailing: SizedBox(
                            child: IconButton(
                              icon: Icon(
                                Icons.edit_outlined,
                                color: themeProvider.darkTheme
                                    ? Colors.white70
                                    : Colors.white,
                                size: responsiveHeight(context, 0.03, 0.1),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/ReminderUpdate',
                                    arguments: reminder);
                              },
                            ),
                          ),
                        ),
                      ));
                },
              );
      },
    );
  }
}

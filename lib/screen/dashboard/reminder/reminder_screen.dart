import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/model/reminder.dart';
import 'package:foodreminder/repository/reminder_repository.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:foodreminder/screen/utils/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final _reminderRepo = ReminderRepositoryImpl();

  final List<Reminder> _reminderList = [];
  void _getAllReminder() async {
    _reminderList.clear();
    List<Reminder> reminders = await _reminderRepo.getAllReminders();
    if (reminders.isNotEmpty) {
      _reminderList.addAll(reminders);
    }
    setState(() {});
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

  @override
  void initState() {
    _getAllReminder();
    super.initState();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    double posX = 0, posY = responsiveHeight(context, 0.3, 0.2);

    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Reminder',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: responsiveHeight(context, 0.022, 0.05),
          ),
        ),
        backgroundColor:
            themeProvider.darkTheme ? Colors.grey.shade900 : Colors.teal,
        titleSpacing: 00.0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        toolbarHeight: responsiveHeight(context, 0.072, 0.15),
        toolbarOpacity: 0.8,
        elevation: 0.00,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            children: [
              Center(
                  child: _reminderList.isNotEmpty
                      ? Column(
                          children: [
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
                                children: [
                                  Icon(
                                    Icons.add_alarm,
                                    color: themeProvider.darkTheme
                                        ? Colors.greenAccent
                                        : Colors.grey.shade900,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "Create New Reminder",
                                    style: TextStyle(
                                      color: themeProvider.darkTheme
                                          ? Colors.greenAccent
                                          : Colors.grey.shade900,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      : Container()),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 100,
                      maxWidth: 750,
                    ),
                    child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      color: Colors.white,
                      backgroundColor: themeProvider.darkTheme
                          ? Colors.teal
                          : Colors.grey.shade900,
                      onRefresh: () async {
                        _getAllReminder();
                      },
                      child: _reminderList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: _reminderList.length,
                              itemBuilder: (BuildContext context, int index) {
                                Reminder reminder = _reminderList[index];
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
                                                _deleteReminder(
                                                    reminder.reminderId!);
                                              }
                                            },
                                            backgroundColor:
                                                const Color(0xFFFE4A49),
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
                                          Navigator.pushNamed(
                                              context, '/ReminderDetail',
                                              arguments: reminder);
                                        },
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        leading: Container(
                                          height: responsiveHeight(
                                              context, 0.4, 0.12),
                                          width: responsiveWidth(
                                              context, 0.2, 0.2),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: reminder.meal == 'Breakfast'
                                                ? Colors
                                                    .lightGreenAccent.shade200
                                                : reminder.meal == 'Lunch'
                                                    ? Colors.orange.shade300
                                                    : Colors
                                                        .yellowAccent.shade200,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${reminder.meal}",
                                              style: TextStyle(
                                                color: themeProvider.darkTheme
                                                    ? Colors.black
                                                    : Colors.black,
                                                fontSize: responsiveHeight(
                                                    context, 0.018, 0.05),
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${reminder.foodname}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: responsiveHeight(
                                                      context, 0.016, 0.06),
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_month,
                                              color: Colors.white70,
                                              size: responsiveHeight(
                                                  context, 0.016, 0.06),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              "${reminder.date} at ${reminder.time}",
                                              style: TextStyle(
                                                  fontSize: responsiveHeight(
                                                      context, 0.016, 0.06),
                                                  color: Colors.white70),
                                            ),
                                          ],
                                        ),
                                        trailing: SizedBox(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.edit_outlined,
                                              color: Colors.white70,
                                              size: responsiveHeight(
                                                  context, 0.03, 0.1),
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/ReminderUpdate',
                                                  arguments: reminder);
                                            },
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                            )
                          : Center(
                              child: StreamBuilder<GyroscopeEvent>(
                                  stream:
                                      SensorsPlatform.instance.gyroscopeEvents,
                                  builder: (context, snapshot) {
                                    // print("");
                                    if (snapshot.hasData) {
                                      posX = posX + (snapshot.data!.y * 10);
                                      posY = posY + (snapshot.data!.x * 10);
                                    }
                                    return Transform.translate(
                                        offset: Offset(posX, posY),
                                        child: InkWell(
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
                                                style: TextStyle(
                                                    color: Colors.greenAccent),
                                              )
                                            ],
                                          ),
                                        ));
                                  }),
                            ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

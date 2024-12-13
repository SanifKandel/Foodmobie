import 'dart:io';
import 'dart:ui';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/model/reminder.dart';
import 'package:foodreminder/repository/reminder_repository.dart';
import 'package:foodreminder/screen/utils/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodreminder/app/user_permission.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateReminderScreen extends StatefulWidget {
  const UpdateReminderScreen({super.key});

  @override
  State<UpdateReminderScreen> createState() => UpdateReminderScreenState();
}

class UpdateReminderScreenState extends State<UpdateReminderScreen> {
  @override
  void initState() {
    _checkUserPermission();
    super.initState();
  }

  _checkUserPermission() async {
    await UserPermission.checkCameraPermission();
  }

  late Reminder reminder;

  @override
  void didChangeDependencies() {
    reminder = ModalRoute.of(context)!.settings.arguments as Reminder;
    super.didChangeDependencies();
  }

  final _formKey = GlobalKey<FormState>();

  final _foodController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _recipeController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _calorieController = TextEditingController();
  final _timetoCookController = TextEditingController();
  final _messageController = TextEditingController();

  String _dropdownvalue = 'breakfast';
  var mealType = [
    'Breakfast',
    'Lunch',
    'Dinner',
  ];
  _saveReminder() async {
    Reminder updatedReminders = Reminder(
      reminderId: reminder.reminderId,
      foodname: _foodController.text,
      calories: _calorieController.text,
      cookingtime: _calorieController.text,
      meal: _dropdownvalue,
      recipe: _recipeController.text,
      ingredients: _ingredientsController.text,
      message: _messageController.text,
      date: _dateController.text,
      time: _timeController.text,
    );
    // updatedUser.target = _dropdownvalue;
    int status =
        await ReminderRepositoryImpl().updateReminder(_img, updatedReminders);
    _showMessage(status);
  }
 _showMessage(int status) {
    if (status > 0) {
      showSnackbar(context, 'Reminder Updated Successfully', Colors.green);
    } else {
      showSnackbar(context, 'Error Updating Reminder', Colors.red);
    }
  }
  File? _img;

  Future _browseImage(ImageSource imageSource) async {
    try {
      // Source is either Gallary or Camera
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

 

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    reminder = ModalRoute.of(context)!.settings.arguments as Reminder;
    _foodController.text = _foodController.text.isEmpty
        ? "${reminder.foodname}"
        : _foodController.text;
    _calorieController.text = _calorieController.text.isEmpty
        ? "${reminder.calories}"
        : _calorieController.text;
    _dateController.text = _dateController.text.isEmpty
        ? "${reminder.date}"
        : _dateController.text;
    _timeController.text = _timeController.text.isEmpty
        ? "${reminder.time}"
        : _timeController.text;
    _recipeController.text = _recipeController.text.isEmpty
        ? "${reminder.recipe}"
        : _recipeController.text;
    _ingredientsController.text = _ingredientsController.text.isEmpty
        ? "${reminder.ingredients}"
        : _ingredientsController.text;
    _timetoCookController.text = _timetoCookController.text.isEmpty
        ? "${reminder.cookingtime}"
        : _timetoCookController.text;
    _messageController.text = _messageController.text.isEmpty
        ? "${reminder.message}"
        : _messageController.text;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark),
            expandedHeight: 70.0,
            elevation: 0.0,
            pinned: true,
            stretch: true,
            leadingWidth: 80.0,
            title: Text(
              'Update Reminder',
              style: TextStyle(
                fontSize: responsiveHeight(context, 0.022, 0.05),
              ),
            ),
            leading: Container(
              margin: const EdgeInsets.only(left: 24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(56.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 56.0,
                      width: 56.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.20),
                      ),
                      child: SvgPicture.asset(
                          'assets/icons/arrow-ios-back-outline.svg'),
                    ),
                  ),
                ),
              ),
            ),
            actions: const [],
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Food Info",
                            style: TextStyle(
                              fontSize: responsiveHeight(context, 0.022, 0.05),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          child: TextFormField(
                            controller: _foodController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Name of the Food';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  MediaQuery.of(context).size.height < 1200
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15)
                                      : const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 30),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: themeProvider.darkTheme
                                  ? Colors.black.withOpacity(0.1)
                                  : Colors.white,
                              labelText: 'Food Name',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          child: TextFormField(
                            controller: _ingredientsController,
                            maxLines: 2,
                            decoration: InputDecoration(
                              contentPadding:
                                  MediaQuery.of(context).size.height < 1200
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15)
                                      : const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 30),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: themeProvider.darkTheme
                                  ? Colors.black.withOpacity(0.1)
                                  : Colors.white,
                              labelText: 'Recipe Ingredients (opt)',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          child: TextFormField(
                            maxLines: 3,
                            controller: _recipeController,
                            decoration: InputDecoration(
                              contentPadding:
                                  MediaQuery.of(context).size.height < 1200
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15)
                                      : const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 30),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: themeProvider.darkTheme
                                  ? Colors.black.withOpacity(0.1)
                                  : Colors.white,
                              labelText: 'Recipe Steps (opt)',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _calorieController,
                                decoration: InputDecoration(
                                    contentPadding:
                                        MediaQuery.of(context).size.height <
                                                1200
                                            ? const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 15)
                                            : const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 30),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: themeProvider.darkTheme
                                        ? Colors.black.withOpacity(0.1)
                                        : Colors.white,
                                    labelText: 'Calorie (opt)',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    hintText: 'Calorie Amount'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: _timetoCookController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    contentPadding:
                                        MediaQuery.of(context).size.height <
                                                1200
                                            ? const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 15)
                                            : const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 30),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: themeProvider.darkTheme
                                        ? Colors.black.withOpacity(0.1)
                                        : Colors.white,
                                    labelText: 'Time (opt)',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    hintText: 'Time to cook'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          child: DropdownButtonFormField(
                            hint: const Text('Select Meal Type'),
                            items: mealType.map((food) {
                              return DropdownMenuItem(
                                value: food,
                                child: Text(food),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _dropdownvalue = newValue!;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Select Meal Type';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  MediaQuery.of(context).size.height < 1200
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15)
                                      : const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 30),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: themeProvider.darkTheme
                                  ? Colors.black.withOpacity(0.1)
                                  : Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Schedule",
                            style: TextStyle(
                              fontSize: responsiveHeight(context, 0.022, 0.05),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _dateController,
                                readOnly: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Date';
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2023),
                                      lastDate: DateTime(2024));
                                  if (pickedDate != null) {
                                    setState(() {
                                      String formattedDate =
                                          DateFormat("yyyy-MM-dd")
                                              .format(pickedDate);
                                      _dateController.text =
                                          formattedDate.toString();
                                    });
                                  } else {
                                    print("not selected");
                                  }
                                },
                                decoration: InputDecoration(
                                    contentPadding:
                                        MediaQuery.of(context).size.height <
                                                1200
                                            ? const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 15)
                                            : const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 30),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: themeProvider.darkTheme
                                        ? Colors.black.withOpacity(0.1)
                                        : Colors.white,
                                    // labelText: 'Date',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    hintText: 'Date'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: _timeController,
                                readOnly: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Time';
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now());
                                  if (pickedTime != null) {
                                    setState(() {
                                      _timeController.text =
                                          pickedTime.format(context).toString();
                                    });
                                  } else {
                                    print("not selected");
                                  }
                                },
                                decoration: InputDecoration(
                                    contentPadding:
                                        MediaQuery.of(context).size.height <
                                                1200
                                            ? const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 15)
                                            : const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 30),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: themeProvider.darkTheme
                                        ? Colors.black.withOpacity(0.1)
                                        : Colors.white,
                                    // labelText: 'Date',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    hintText: 'Time'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          child: TextFormField(
                            controller: _messageController,
                            maxLines: 2,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Message for Reminder';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  MediaQuery.of(context).size.height < 1200
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15)
                                      : const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 30),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: themeProvider.darkTheme
                                  ? Colors.black.withOpacity(0.1)
                                  : Colors.white,
                              labelText: 'Message',
                            ),
                          ),
                        ),
                        const SizedBox(height: 44),
                        SizedBox(
                          height: responsiveHeight(context, 0.07, 0.2),
                          width: responsiveWidth(
                              context, double.infinity, double.infinity),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _saveReminder();
                              }
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Form
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

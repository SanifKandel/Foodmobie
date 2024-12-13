import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodreminder/screen/utils/snackbar.dart';
import 'package:foodreminder/repository/user_repository.dart';
import 'package:foodreminder/screen/home/loginScreen.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool light0 = true;
  bool light1 = true;
  bool light2 = true;
  final MaterialStateProperty<Icon?> appearance =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.dark_mode);
      }
      return const Icon(Icons.sunny);
    },
  );

  final MaterialStateProperty<Icon?> notification =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.notifications_active);
      }
      return const Icon(Icons.notifications_off);
    },
  );
  final MaterialStateProperty<Icon?> biometric =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.fingerprint);
      }
      return const Icon(Icons.fingerprint);
    },
  );

  _loginOutUser() async {
    final islogout = await UserRepositoryImpl().logoutUser();
    if (islogout) {
      _goToAnotherPage();
    } else {
      _showMessage();
    }
  }

  _goToAnotherPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
    showSnackbar(context, 'Log Out Successful', Colors.teal);
  }

  _showMessage() {
    showSnackbar(context, 'Error Login Out', Colors.red);
  }

  _showalert() {
    showSnackbar(context, 'Link copied to clipboard!', Colors.teal);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Settings',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: responsiveHeight(context, 0.022, 0.05),
            ),
          ),
          scrolledUnderElevation: 0,
          backgroundColor:
              themeProvider.darkTheme ? Colors.grey.shade900 : Colors.teal,
          toolbarOpacity: 1,
          elevation: 0.00,
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: responsiveHeight(context, 0.072, 0.15),
        ),
        body: Align(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.topCenter,
            constraints: const BoxConstraints(
              minWidth: 100,
              maxWidth: 750,
            ),
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListTile(
                      leading: Icon(
                        Icons.color_lens,
                        color: themeProvider.darkTheme
                            ? Colors.white
                            : Colors.teal,
                      ),
                      title: Text("Appearance",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                // fontSize: responsiveHeight(context, 0.02, 0.04),
                                color: themeProvider.darkTheme
                                    ? Colors.white
                                    : Colors.teal,
                                fontSize: responsiveHeight(context, 0.02, 0.04),
                              )),
                      trailing: Switch(
                        thumbIcon: appearance,
                        value: themeProvider.darkTheme,
                        onChanged: (value) {
                          themeProvider.darkTheme = value;
                          showSnackbar(
                              context,
                              themeProvider.darkTheme
                                  ? 'Dark mode enabled'
                                  : 'Light mode enabled',
                              themeProvider.darkTheme
                                  ? Colors.white
                                  : Colors.black);
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListTile(
                      leading: Icon(
                        Icons.notifications_active,
                        color: themeProvider.darkTheme
                            ? Colors.white
                            : Colors.teal,
                      ),
                      title: Text(
                        "Notification",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              // fontSize: responsiveHeight(context, 0.02, 0.04),

                              color: themeProvider.darkTheme
                                  ? Colors.white
                                  : Colors.teal,
                              fontSize: responsiveHeight(context, 0.02, 0.04),
                            ),
                      ),
                      trailing: Switch(
                        thumbIcon: notification,
                        value: light1,
                        onChanged: (bool value) {
                          setState(() {
                            light1 = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListTile(
                      leading: Icon(
                        Icons.fingerprint,
                        color: themeProvider.darkTheme
                            ? Colors.white
                            : Colors.teal,
                      ),
                      title: Text(
                        "Biometric",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              // fontSize: responsiveHeight(context, 0.02, 0.04),
                              color: themeProvider.darkTheme
                                  ? Colors.white
                                  : Colors.teal,
                              fontSize: responsiveHeight(context, 0.02, 0.04),
                            ),
                      ),
                      trailing: Switch(
                        thumbIcon: biometric,
                        value: light0,
                        onChanged: (bool value) {
                          setState(() {
                            light0 = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListTile(
                      leading: Icon(
                        Icons.info,
                        color: themeProvider.darkTheme
                            ? Colors.white
                            : Colors.teal,
                      ),
                      title: Text(
                        "About",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              // fontSize: responsiveHeight(context, 0.02, 0.04),
                              color: themeProvider.darkTheme
                                  ? Colors.white
                                  : Colors.teal,
                              fontSize: responsiveHeight(context, 0.02, 0.04),
                            ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: themeProvider.darkTheme
                            ? Colors.white
                            : Colors.teal,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/AboutScreen');
                        // Navigate to about screen
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListTile(
                      leading: Icon(
                        Icons.question_answer,
                        color: themeProvider.darkTheme
                            ? Colors.white
                            : Colors.teal,
                      ),
                      title: Text(
                        "Help and FAQs",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              // fontSize: responsiveHeight(context, 0.02, 0.04),
                              color: themeProvider.darkTheme
                                  ? Colors.white
                                  : Colors.teal,
                              fontSize: responsiveHeight(context, 0.02, 0.04),
                            ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: themeProvider.darkTheme
                            ? Colors.white
                            : Colors.teal,
                      ),
                      onTap: () {
                        // Navigate to FAQ screen
                        Navigator.pushNamed(context, '/FAQScreen');
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListTile(
                      leading: Icon(
                        Icons.share,
                        color: themeProvider.darkTheme
                            ? Colors.white
                            : Colors.teal,
                      ),
                      title: Text(
                        "Share",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              // fontSize: responsiveHeight(context, 0.02, 0.04),
                              color: themeProvider.darkTheme
                                  ? Colors.white
                                  : Colors.teal,
                              fontSize: responsiveHeight(context, 0.02, 0.04),
                            ),
                      ),
                      trailing: Icon(
                        Icons.copy,
                        color: themeProvider.darkTheme
                            ? Colors.white
                            : Colors.teal,
                      ),
                      onTap: () {
                        Clipboard.setData(const ClipboardData(
                            text: "https://www.example.com"));
                        _showalert();
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListTile(
                      leading: Icon(
                        Icons.feedback,
                        color: themeProvider.darkTheme
                            ? Colors.white
                            : Colors.teal,
                      ),
                      title: Text(
                        "Feedback",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              // fontSize: responsiveHeight(context, 0.02, 0.04),
                              color: themeProvider.darkTheme
                                  ? Colors.white
                                  : Colors.teal,
                              fontSize: responsiveHeight(context, 0.02, 0.04),
                            ),
                      ),
                      onTap: () {
                        // FeedbackDialog.show(context);
                        Navigator.pushNamed(context, '/FeedBack');
                      },
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: themeProvider.darkTheme
                            ? Colors.white
                            : Colors.teal,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListTile(
                      leading: Icon(
                        Icons.info,
                        color: themeProvider.darkTheme
                            ? Colors.white
                            : Colors.teal,
                      ),
                      title: Text(
                        "More Info",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              // fontSize: responsiveHeight(context, 0.02, 0.04),
                              color: themeProvider.darkTheme
                                  ? Colors.white
                                  : Colors.teal,
                              fontSize: responsiveHeight(context, 0.02, 0.04),
                            ),
                      ),
                      onTap: () {
                        Dialogs.bottomMaterialDialog(
                          msg: 'Version: 1.0.1',
                          title: 'FoodMobie',
                          msgStyle: TextStyle(
                            fontSize: responsiveHeight(context, 0.02, 0.04),
                          ),
                          titleStyle: TextStyle(
                            fontSize: responsiveHeight(context, 0.02, 0.04),
                          ),
                          context: context,
                          color: themeProvider.darkTheme
                              ? Colors.grey.shade900
                              : Colors.white,
                          actions: [
                            IconsButton(
                              onPressed: () {
// Navigator.of(context).pop();
                              },
                              text: 'Check For Update',
                              textStyle: TextStyle(
                                color: themeProvider.darkTheme
                                    ? Colors.white
                                    : Colors.white,
                                fontSize: responsiveHeight(context, 0.02, 0.04),
                              ),
                              iconData: Icons.update,
                              iconColor: Colors.white,
                              color: Colors.teal,
                            ),
                          ],
                        );
                      },
                      // trailing: const Icon(Icons.update, color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        // color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.redAccent,
                      ),
                      title: Text(
                        "Log Out",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Colors.redAccent,
                                fontSize:
                                    responsiveHeight(context, 0.02, 0.04)),
                      ),
                      onTap: () {
                        Dialogs.bottomMaterialDialog(
                            color: themeProvider.darkTheme
                                ? Colors.grey.shade900
                                : Colors.white,
                            msg: 'Are you sure? you want to Log Out',
                            title: 'Logout Account?',
                            context: context,
                            actions: [
                              IconsOutlineButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                text: 'Cancel',
                                iconData: Icons.cancel_outlined,
                                textStyle: const TextStyle(color: Colors.grey),
                                iconColor: Colors.grey,
                              ),
                              IconsButton(
                                onPressed: () {
                                  _loginOutUser();
                                },
                                text: 'Log Out',
                                iconData: Icons.logout,
                                color: Colors.red,
                                textStyle: const TextStyle(color: Colors.white),
                                iconColor: Colors.white,
                              ),
                            ]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

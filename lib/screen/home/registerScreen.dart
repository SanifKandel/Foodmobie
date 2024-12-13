import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/screen/utils/snackbar.dart';
import 'package:foodreminder/app/user_permission.dart';
import 'package:foodreminder/model/user.dart';
import 'package:foodreminder/repository/user_repository.dart';
import 'package:foodreminder/screen/home/loginScreen.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String route = "registerScreen";
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    _checkUserPermission();
    super.initState();
  }

  _checkUserPermission() async {
    await UserPermission.checkCameraPermission();
  }

  bool _obscureText =
      true; // stores the current state of the obscureText property
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  // final _confirmPasswordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  _saveUser() async {
    User user = User(
      email: _emailController.text,
      password: _passwordController.text,
      firstName: _fnameController.text,
      lastName: _lnameController.text,
    );
    int status = await UserRepositoryImpl().addUser(_img, user);
    _showMessage(status);
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

  _showMessage(int status) {
    if (status > 0) {
      // showSnackbar(context, 'User Register Successfull', Colors.teal);
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
      Dialogs.bottomMaterialDialog(
        color: Colors.white,
        lottieBuilder: Lottie.asset(
          'assets/lottie/register.json',
          fit: BoxFit.contain,
        ),
        context: context,
      );
    } else {
      showSnackbar(context, 'Error Registering User', Colors.red);
    }
  }

  _showalert() {
    showSnackbar(
        context, 'Sorry, the service is currently unavailable.', Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        // show the confirm dialog

        await Dialogs.materialDialog(
            msg: 'Are you sure ? you want to exit',
            title: "Exit FoodMobie",
            color: Colors.white,
            context: context,
            actions: [
              IconsOutlineButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'Cancel',
                color: Colors.teal,
                iconData: Icons.cancel_outlined,
                textStyle: const TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
              IconsButton(
                onPressed: () {
                  willLeave = true;
                  Navigator.of(context).pop();
                  SystemNavigator.pop();
                },
                text: 'Confirm',
                iconData: Icons.exit_to_app,
                color: Colors.grey,
                textStyle: const TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
            ]);
        return willLeave;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: 100,
                  maxWidth: 650,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 105, right: 30, left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Hello Dear!',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Create new ',
                              style: TextStyle(
                                color: themeProvider.darkTheme
                                    ? Colors.white
                                    : Colors.black87,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: 'Account',
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              key: const Key('fnameField'),
                              controller: _fnameController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter you First Name';
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
                                  labelText: 'First Name',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  hintText: 'Enter Your First Name'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              key: const Key('lnameField'),
                              controller: _lnameController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter you Last Name';
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
                                  labelText: 'Last Name',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  hintText: 'Enter Your Last Name'),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      SizedBox(
                        child: TextFormField(
                          key: const Key('emailField'),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
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
                              labelText: 'Email',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: 'Enter Your Email'),
                        ),
                      ),

                      const SizedBox(height: 16),
                      SizedBox(
                        child: TextFormField(
                          key: const Key('passwordField'),
                          controller: _passwordController,
                          obscureText: _obscureText,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
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
                              suffixIcon: IconButton(
                                icon: _obscureText
                                    ? const Icon(Icons.remove_red_eye)
                                    : const Icon(
                                        Icons.visibility_off), // eye icon
                                onPressed: () {
                                  // toggle the obscureText value
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: themeProvider.darkTheme
                                  ? Colors.black.withOpacity(0.1)
                                  : Colors.white,
                              labelText: 'Password',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: 'Enter Your Password'),
                        ),
                      ),

                      const SizedBox(height: 44),
                      SizedBox(
                        height: responsiveHeight(context, 0.07, 0.2),
                        width: responsiveWidth(
                            context, double.infinity, double.infinity),
                        child: ElevatedButton(
                          key: const Key('regBtn'),
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              _saveUser();
                              // Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Or continue with",
                            style: TextStyle(
                                color: themeProvider.darkTheme
                                    ? Colors.white
                                    : Colors.black87,
                                fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48), //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              _showalert();
                              // Add code to handle Google icon click
                            },
                            child: Container(
                              width: 100,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Image(
                                image: AssetImage('assets/images/google.png'),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _showalert();
                              // Add code to handle Apple icon click
                            },
                            child: Container(
                              width: 100,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Image(
                                image: AssetImage('assets/images/apple.png'),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _showalert();
                              // Add code to handle Facebook icon click
                            },
                            child: Container(
                              width: 100,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Image(
                                image: AssetImage('assets/images/facebook.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: themeProvider.darkTheme
                                ? Colors.white
                                : Colors.black87,
                            fontSize: responsiveHeight(context, 0.02, 0.06),
                          ),
                          children: [
                            const TextSpan(
                              text: "Already a member? ",
                            ),
                            TextSpan(
                              text: "Login Now",
                              style: const TextStyle(
                                color: Colors.teal,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, '/Login');
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

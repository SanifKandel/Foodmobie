import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/screen/utils/snackbar.dart';
import 'package:foodreminder/repository/user_repository.dart';
import 'package:foodreminder/screen/dashboard/dashboard.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String route = "loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _loginUser();
  }

  bool _obscureText = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _loginUser() async {
    final islogin = await UserRepositoryImpl()
        .loginUser(_emailController.text, _passwordController.text);
    if (islogin) {
      _goToAnotherPage();
    } else {
      if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
        return;
      } else {
        _showMessage();
      }
    }
  }

  _goToAnotherPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
    showSnackbar(context, 'Login Successful', Colors.teal);
  }

  _showMessage() {
    showSnackbar(context, 'Invalid username or password', Colors.red);
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
              child: Center(
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 100,
            maxWidth: 650,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 105, right: 30, left: 30),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Hello Dear!',
                style: TextStyle(
                  fontSize: responsiveHeight(context, 0.03, 0.06),
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Login to ',
                      style: TextStyle(
                        color: themeProvider.darkTheme
                            ? Colors.white
                            : Colors.black87,
                        fontSize: responsiveHeight(context, 0.035, 0.1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Food',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: responsiveHeight(context, 0.035, 0.1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Mobie',
                      style: TextStyle(
                        color: themeProvider.darkTheme
                            ? Colors.white
                            : Colors.black87,
                        fontSize: responsiveHeight(context, 0.035, 0.1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      child: TextFormField(
                        key: const ValueKey('emailField'),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
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
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintText: 'Enter Your Email'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      child: TextFormField(
                        key: const ValueKey('pwdField'),
                        controller: _passwordController,
                        obscureText:
                            _obscureText, // sets the obscureText property using the boolean variable
                        // makes the password characters obscure
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
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
                                  ? const Icon(
                                      Icons.remove_red_eye,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      color: Colors.teal,
                                    ), // eye icon
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
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintText: 'Enter Your Password',
                            hintStyle: const TextStyle()),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          _showalert();
                          // code to be executed when the text is tapped
                        },
                        child: Text(
                          "Recover Password",
                          style: TextStyle(
                              color: themeProvider.darkTheme
                                  ? Colors.white
                                  : Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 44),
                    SizedBox(
                      height: responsiveHeight(context, 0.07, 0.2),
                      width: responsiveWidth(
                          context, double.infinity, double.infinity),
                      child: ElevatedButton(
                        key: const Key('login'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _loginUser();
                          }
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      "Or continue with",
                      style: TextStyle(
                        color: themeProvider.darkTheme
                            ? Colors.white
                            : Colors.black87,
                        fontSize: responsiveHeight(context, 0.02, 0.06),
                      ),
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
                              border: Border.all(
                                color: themeProvider.darkTheme
                                    ? Colors.white
                                    : Colors.white,
                              ),
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
                              border: Border.all(
                                color: themeProvider.darkTheme
                                    ? Colors.white
                                    : Colors.white,
                              ),
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
                              border: Border.all(
                                color: themeProvider.darkTheme
                                    ? Colors.white
                                    : Colors.white,
                              ),
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
                            text: "Not a member? ",
                          ),
                          TextSpan(
                            text: "Register Now",
                            style: const TextStyle(
                              color: Colors.teal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/Register');
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ))),
    );
  }
}

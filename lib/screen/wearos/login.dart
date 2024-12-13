import 'package:flutter/material.dart';
import 'package:foodreminder/screen/utils/snackbar.dart';
import 'package:foodreminder/repository/user_repository.dart';
import 'package:foodreminder/screen/wearos/dashboard.dart';
import 'package:wear/wear.dart';

class WearLoginScreen extends StatefulWidget {
  const WearLoginScreen({super.key});

  @override
  State<WearLoginScreen> createState() => _WearLoginScreenState();
}

class _WearLoginScreenState extends State<WearLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _loginUser() async {
    final islogin = await UserRepositoryImpl()
        .loginUser(_emailController.text, _passwordController.text);
    if (islogin) {
      _goToAnotherPage();
    } else {
      _showMessage();
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

  @override
  Widget build(BuildContext context) {
    return WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
      return AmbientMode(builder: (context, mode, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('FoodMobie'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: const InputDecoration(
                          fillColor: Colors.amber, labelText: "Email"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                          fillColor: Colors.amber, labelText: "Password"),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _loginUser();
                          }
                        },
                        child: const Text('Login'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
    });
  }
}

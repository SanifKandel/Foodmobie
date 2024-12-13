import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => EditPasswordScreenState();
}

class EditPasswordScreenState extends State<EditPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark),
            expandedHeight: 275.0,
            elevation: 0.0,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Lottie.asset(
                'assets/lottie/password.json',
                fit: BoxFit.cover,
              ),
              stretchModes: const [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
              ],
            ),
            leadingWidth: 80.0,
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
                          color: Colors.white.withOpacity(0.20)),
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
                const SizedBox(height: 20.0),
                const Text(
                  'Edit Your Password',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    color: themeProvider.darkTheme
                        ? Colors.grey.shade900
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Current Password',
                              hintText: 'Enter Current Password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Current Password';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'New Password',
                              hintText: 'Enter New Password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter New Password';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),

                    // Form
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: responsiveHeight(context, 0.07, 0.2),
                  width: responsiveWidth(
                      context, double.infinity, double.infinity),
                  child: IconsButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    text: 'Update',
                    iconData: Icons.password_outlined,
                    color: Colors.teal,
                    textStyle: const TextStyle(color: Colors.white),
                    iconColor: Colors.white,
                  ),
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

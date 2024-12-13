import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/screen/utils/snackbar.dart';
import 'package:foodreminder/model/userfeedbacks.dart';
import 'package:foodreminder/repository/feedback_repository.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  _saveFeedback() async {
    UserFeedback feedbacks = UserFeedback(
        subject: _subjectController.text, message: _messageController.text);
    int status = await FeedbackRepositoryImpl().createFeedback(_img, feedbacks);
    _showMessage(status);
  }

  File? _img;
  // ignore: unused_element
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
            MaterialPageRoute(builder: (context) => const FeedBackScreen()));
      });
      Dialogs.bottomMaterialDialog(
        title: "Feedback sent successfuls",
        msg: "Thank You For your Valuable Feedback",
        color: Colors.white,
        lottieBuilder: Lottie.asset(
          'assets/lottie/sent.json',
          fit: BoxFit.contain,
        ),
        context: context,
      );
    } else {
      showSnackbar(context, 'Error Sending Feedback', Colors.red);
    }
  }

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
                'assets/lottie/feedback.json',
                fit: BoxFit.cover,
              ),
              stretchModes: const [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Container(
                height: 32.0,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                ),
                child: Text(
                  'FeedBack',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: responsiveHeight(context, 0.02, 0.06),
                  ),
                ),
              ),
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
                        color: Colors.white.withOpacity(0.20),
                      ),
                      child: SvgPicture.asset(
                          'assets/icons/arrow-ios-back-outline.svg'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                const Text(
                  'Your feedback helps us improve FoodMobie.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    color: themeProvider.darkTheme
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _subjectController,
                            decoration: const InputDecoration(
                              labelText: 'Subject',
                              hintText: 'Enter feedback subject',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter subject';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.white),
                          ),
                          TextFormField(
                            controller: _messageController,
                            decoration: const InputDecoration(
                              labelText: 'Message',
                              hintText: 'Enter feedback message',
                            ),
                            maxLines: 4,
                            style: const TextStyle(color: Colors.white),
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
                      _saveFeedback();
                    },
                    text: 'Submit Feedback',
                    iconData: Icons.feedback,
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

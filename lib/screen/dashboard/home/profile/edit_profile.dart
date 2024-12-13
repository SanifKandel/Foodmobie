import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodreminder/app/constants.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/screen/utils/snackbar.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodreminder/app/user_permission.dart';
import 'package:foodreminder/model/user.dart';
import 'package:foodreminder/repository/user_repository.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    _checkUserPermission();
    super.initState();
  }

  _checkUserPermission() async {
    await UserPermission.checkCameraPermission();
  }

  late User user;

  @override
  void didChangeDependencies() {
    user = ModalRoute.of(context)!.settings.arguments as User;
    super.didChangeDependencies();
  }

  final _formKey = GlobalKey<FormState>();

  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _emailController = TextEditingController();
  // final _phoneController = TextEditingController(text: '9818984104');

  _saveProfile() async {
    User updatedUser = User(
      userId: user.userId,
      firstName: _fnameController.text,
      lastName: _lnameController.text,
      email: _emailController.text,
      // phone: _passwordController.text,
    );
    int status = await UserRepositoryImpl().updateUser(_img, updatedUser);
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
      showSnackbar(context, 'Profile Updated Successfully', Colors.green);
    } else {
      showSnackbar(context, 'Error Updating Profile', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    user = ModalRoute.of(context)!.settings.arguments as User;
    _fnameController.text = _fnameController.text.isEmpty
        ? "${user.firstName}"
        : _fnameController.text;
    _lnameController.text = _lnameController.text.isEmpty
        ? "${user.lastName}"
        : _lnameController.text;
    _emailController.text =
        _emailController.text.isEmpty ? "${user.email}" : _emailController.text;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark),
            expandedHeight: responsiveHeight(context, 0.45, 0.8),
            elevation: 0.0,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox(
                child: _img == null
                    ? user.image != null
                        ? CachedNetworkImage(
                            imageUrl: "${Constant.foodImageUrl}${user.image}",
                            fit: BoxFit.cover,
                            fadeOutDuration: const Duration(seconds: 0),
                            fadeInDuration: const Duration(seconds: 0),
                            placeholder: (context, url) => Container(
                              color: Colors.grey[300],
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : const Center(child: Text("Upload New Image"))
                    : Image.file(
                        _img!,
                        fit: BoxFit.cover,
                      ),
              ),
              stretchModes: const [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 24.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(56.0),
                    child: InkWell(
                      onTap: () {
                        Dialogs.bottomMaterialDialog(
                            color: themeProvider.darkTheme
                                ? Colors.grey.shade900
                                : Colors.white,
                            title: 'Choose Option to Upload Image?',
                            context: context,
                            actions: [
                              IconsButton(
                                color: Colors.teal,
                                onPressed: () {
                                  _browseImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                text: 'Camera',
                                iconData: Icons.camera_enhance,
                                textStyle: const TextStyle(color: Colors.white),
                                iconColor: Colors.white,
                              ),
                              IconsButton(
                                onPressed: () {
                                  _browseImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                text: 'Gallery',
                                iconData: Icons.photo,
                                color: Colors.teal,
                                textStyle: const TextStyle(color: Colors.white),
                                iconColor: Colors.white,
                              ),
                            ]);
                      },
                      child: Container(
                        height: 56.0,
                        width: 56.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: themeProvider.darkTheme
                              ? Colors.white.withOpacity(0.20)
                              : Colors.black.withOpacity(0.20),
                        ),
                        child: const Icon(Icons.camera_enhance),
                      ),
                    ),
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
                  'Edit Your Profile',
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
                            controller: _fnameController,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                              hintText: 'Enter to Edit Your First Name',
                            ),
                          ),
                          TextFormField(
                            controller: _lnameController,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                              hintText: 'Enter to Edit Your First Last Name',
                            ),
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter to Edit Your Email',
                            ),
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
                      if (_formKey.currentState!.validate()) {
                        _saveProfile();
                      }
                    },
                    text: 'Update Profile',
                    iconData: Icons.person,
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

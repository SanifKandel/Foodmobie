import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodreminder/app/constants.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/model/user.dart';
import 'package:foodreminder/app/themes/colors.dart';
import 'package:foodreminder/repository/user_repository.dart';
import 'package:foodreminder/screen/home/mainScreen.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:foodreminder/screen/utils/snackbar.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});
  static const String route = "profileScreen";

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late User user;
  @override
  void didChangeDependencies() {
    user = ModalRoute.of(context)!.settings.arguments as User;
    super.didChangeDependencies();
  }

  void _deleteUser(String userId) async {
    int result = await UserRepositoryImpl().deleteUser(userId);
    _showMessage(result);
  }

  @override
  void initState() {
    super.initState();
  }

  _showMessage(int status) {
    if (status > 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
      showSnackbar(context, 'Account Deleted Successfully', Colors.green);
    } else {
      showSnackbar(context, 'Error Deleting Account', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark),
            expandedHeight: responsiveHeight(context, 0.45, 0.8),
            backgroundColor: themeProvider.darkTheme
                ? Colors.grey.shade900
                : Colors.grey.shade500,
            elevation: 0.0,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: user.image != null
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
                  : const Center(child: Text("Upload New Image")),
              stretchModes: const [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Container(
                height: responsiveHeight(context, 0.05, 0.1),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                ),
                child: Text(
                  "User Profile",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: responsiveHeight(context, 0.022, 0.06),
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            "${user.firstName}"
                            " "
                            "${user.lastName}",
                            style: TextStyle(
                                fontSize:
                                    responsiveHeight(context, 0.023, 0.06),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(56.0),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/EditProfileScreen',
                                      arguments: user);
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
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 24.0,
                          width: 24.0,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 16.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: kMainTextColor,
                          ),
                          child: Icon(
                            Icons.email,
                            color: Colors.white,
                            size: responsiveHeight(context, 0.023, 0.06),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${user.email}",
                            style: TextStyle(
                              fontSize: responsiveHeight(context, 0.020, 0.05),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 24.0,
                          width: 24.0,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 16.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: kMainTextColor,
                          ),
                          child: Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: responsiveHeight(context, 0.023, 0.06),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '9818984104',
                            style: TextStyle(
                              fontSize: responsiveHeight(context, 0.020, 0.05),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/EditPassword');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 14.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(56.0),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                                child: Container(
                                  height: 36.0,
                                  width: 36.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.teal.withOpacity(0.20),
                                  ),
                                  child: Icon(
                                    Icons.password,
                                    color: Colors.white,
                                    size:
                                        responsiveHeight(context, 0.023, 0.06),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              'Update Password',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize:
                                      responsiveHeight(context, 0.020, 0.05),
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Dialogs.bottomMaterialDialog(
                            color: themeProvider.darkTheme
                                ? Colors.grey.shade900
                                : Colors.white,
                            msg: 'Are you sure? you can\'t undo this action',
                            title: 'Delete Account?',
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
                                  _deleteUser(user.userId!);
                                },
                                text: 'Delete',
                                iconData: Icons.delete,
                                color: Colors.red,
                                textStyle: const TextStyle(color: Colors.white),
                                iconColor: Colors.white,
                              ),
                            ]);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 14.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(56.0),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                                child: Container(
                                  height: 36.0,
                                  width: 36.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.redAccent.withOpacity(0.20),
                                  ),
                                  child: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.redAccent,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              'Delete Account',
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize:
                                      responsiveHeight(context, 0.020, 0.05),
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

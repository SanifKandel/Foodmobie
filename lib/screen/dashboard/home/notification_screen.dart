import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodreminder/app/constants.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/model/notification.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  static const String route = "notificationScreen";

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late List<FoodMobieNotification> notification;
  @override
  void didChangeDependencies() {
    notification = ModalRoute.of(context)!.settings.arguments
        as List<FoodMobieNotification>;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor:
                themeProvider.darkTheme ? Colors.grey.shade900 : Colors.teal,
            automaticallyImplyLeading: true,
            title: Text(
              'Notification',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: responsiveHeight(context, 0.022, 0.05),
              ),
            ),
            titleSpacing: 00.0,
            centerTitle: true,
            toolbarHeight: responsiveHeight(context, 0.072, 0.15),
            toolbarOpacity: 1,
            elevation: 0.00,
            scrolledUnderElevation: 0,
          ),
          body: notification != null
              ? Center(
                  child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 100,
                    maxWidth: 750,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.builder(
                      itemCount: notification.length,
                      itemBuilder: (context, index) {
                        FoodMobieNotification notifications =
                            notification[index];
                        return Card(
                            color: themeProvider.darkTheme
                                ? Colors.grey.shade900
                                : Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                                leading: ClipOval(
                                  child: Container(
                                    color: Colors.white,
                                    width: 45.0,
                                    height: 45.0,
                                    child: const Icon(
                                      Icons.notifications,
                                      color: Colors.teal,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.only(top: 10)),
                                      Text(
                                        notifications.title,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: responsiveHeight(
                                                context, 0.017, 0.05),
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        notifications.description,
                                        style: TextStyle(
                                            fontSize: responsiveHeight(
                                                context, 0.017, 0.04),
                                            color: Colors.white70),
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                          child: notifications.image == null
                                              ? const SizedBox()
                                              : ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(6)),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        Constant.foodImageUrl +
                                                            notifications.image,
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) =>
                                                            Container(
                                                      color: Colors.grey[300],
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const SizedBox(),
                                                  ),
                                                )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "${notifications.time} ${notifications.date}",
                                          style: TextStyle(
                                              fontSize: responsiveHeight(
                                                  context, 0.016, 0.05),
                                              color: Colors.white70),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ])));
                      },
                    ),
                  ),
                ))
              : const Center(
                  child: CircularProgressIndicator(),
                ));
    });
  }
}

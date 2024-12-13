import 'package:permission_handler/permission_handler.dart';

class UserPermission {
  static Future<void> checkCameraPermission() async {
    final cameraStatus = await Permission.camera.status;
    if (cameraStatus.isDenied ||
        cameraStatus.isRestricted ||
        cameraStatus.isLimited) {
      await Permission.camera.request();
    }
  }

  // static Future<void> checkLocatonPermission() async {
  //   final locationStatus = await Permission.location.status;
  //   if (locationStatus.isDenied || locationStatus.isRestricted || locationStatus.isLimited) {
  //     await Permission.location.request();
  //   }
  // }
}

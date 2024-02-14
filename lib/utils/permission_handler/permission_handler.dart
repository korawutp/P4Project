import 'package:permission_handler/permission_handler.dart';

Future<bool> requestLocationPermission() async {
  var status = await Permission.location.status;
  if (status.isGranted) {
    return true;
  } else if (status.isDenied) {
    status = await Permission.location.request();
    return status.isGranted;
  } else if (status.isPermanentlyDenied) {
    openAppSettings(); // ให้ผู้ใช้เปิดการตั้งค่าแอปเพื่อเปิดสิทธิ์
    return false;
  }
  return false;
}

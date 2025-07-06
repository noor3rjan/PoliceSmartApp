import 'package:device_info_plus/device_info_plus.dart';
import 'package:hive/hive.dart';

class AuthHelper {
  static Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id ?? "unknown_device";
  }

  static Future<void> saveLogin(String username) async {
    final box = await Hive.openBox('auth');
    String deviceId = await getDeviceId();

    await box.put('username', username);
    await box.put('device_id', deviceId);
  }

  static Future<bool> isAuthorized(String username) async {
    final box = await Hive.openBox('auth');
    final savedDeviceId = box.get('device_id');
    final currentDeviceId = await getDeviceId();

    // إذا كان نفس الجهاز المسموح به
    return savedDeviceId == null || savedDeviceId == currentDeviceId;
  }
}

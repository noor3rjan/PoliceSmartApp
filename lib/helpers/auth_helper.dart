import 'package:device_info_plus/device_info_plus.dart';
import 'package:hive/hive.dart';

class AuthHelper {
  /// ✅ الحصول على ID الجهاز الحالي
  static Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id ?? "unknown_device";
  }

  /// ✅ حفظ معلومات تسجيل الدخول
  static Future<void> saveLogin(String username) async {
    final box = await Hive.openBox('auth');
    String deviceId = await getDeviceId();

    await box.put('username', username);
    await box.put('device_id', deviceId);
  }

  /// ✅ التحقق إذا الحساب مسموح له الدخول من هذا الجهاز
  static Future<bool> isAuthorized(String username) async {
    final box = await Hive.openBox('auth');
    final savedDeviceId = box.get('device_id');
    final currentDeviceId = await getDeviceId();

    // إذا كان الحساب جديد أو الجهاز الحالي مطابق للجهاز المخزن
    return savedDeviceId == null || savedDeviceId == currentDeviceId;
  }

  /// ✅ تسجيل الخروج - حذف بيانات الجهاز والمستخدم
  static Future<void> logout() async {
    final box = await Hive.openBox('auth');
    await box.clear();
  }
}

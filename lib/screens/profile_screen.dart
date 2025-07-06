import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../helpers/auth_helper.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String deviceId = "جارٍ التحميل...";

  @override
  void initState() {
    super.initState();
    loadDeviceId();
  }

  void loadDeviceId() async {
    final info = DeviceInfoPlugin();
    final android = await info.androidInfo;
    setState(() {
      deviceId = android.id ?? "غير معروف";
    });
  }

  void logout() async {
    await AuthHelper.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الملف الشخصي"),
        backgroundColor: const Color(0xff0c2340),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            infoRow("الاسم", "نور الدين عرجان"),
            infoRow("الرتبة", "ملازم أول"),
            infoRow("زمرة الدم", "O+"),
            infoRow("رقم الهوية", "403637292"),
            infoRow("معرف الجهاز", deviceId),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: logout,
              icon: const Icon(Icons.logout),
              label: const Text("تسجيل الخروج"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size.fromHeight(50),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget infoRow(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(title, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}

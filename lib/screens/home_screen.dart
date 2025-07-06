import 'package:flutter/material.dart';
import '../helpers/auth_helper.dart';
import 'login_screen.dart';
import 'emergency_report_screen.dart';
import 'posts_screen.dart';
import 'patrols_screen.dart'; // ✅ استدعاء شاشة الدوريات

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void logout(BuildContext context) async {
    await AuthHelper.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: const Color(0xff0c2340),
        title: const Text(
          "الشرطة الفلسطينية",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
            tooltip: "تسجيل الخروج",
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Image.asset('assets/logo.png', width: 100),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Icon(Icons.warning, color: Colors.red),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Emergency",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Major disturbance reported, additional support required",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("DASHBOARD", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                DashboardTile(
                  title: "الأحداث",
                  subtitle: "Posts",
                  icon: Icons.article,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PostsScreen()),
                    );
                  },
                ),
                DashboardTile(
                  title: "الطلاع الطارئ",
                  subtitle: "Emergency Report",
                  icon: Icons.local_hospital,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EmergencyReportScreen()),
                    );
                  },
                ),
                DashboardTile(
                  title: "الدوريات",
                  subtitle: "Patrols",
                  icon: Icons.location_on,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PatrolsScreen()),
                    );
                  },
                ),
                const DashboardTile(
                  title: "الجرائم السيبرانية",
                  subtitle: "Cyber Crimes",
                  icon: Icons.shield,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const DashboardTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title, textAlign: TextAlign.right),
        subtitle: Text(subtitle, textAlign: TextAlign.right),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap ?? () {},
      ),
    );
  }
}

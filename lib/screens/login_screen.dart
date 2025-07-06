import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../helpers/auth_helper.dart'; // ✅ استدعاء ملف المساعد

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final users = {
    'noor': '123123',
    'mohammad': '12341234',
    'ahmad': '1234512345',
  };

  void handleLogin() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (!users.containsKey(email) || users[email] != password) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ اسم المستخدم أو كلمة المرور غير صحيحة")),
      );
      return;
    }

    bool authorized = await AuthHelper.isAuthorized(email);

    if (!authorized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠️ هذا الحساب مربوط بجهاز آخر. تواصل مع مدير النظام لإعادة التعيين."),
        ),
      );
      return;
    }

    // ✅ حفظ معلومات الدخول على هذا الجهاز لأول مرة
    await AuthHelper.saveLogin(email);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0c2340),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset('assets/logo.png', width: 120),
              const SizedBox(height: 20),
              const Text(
                "الشرطة الفلسطينية",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: handleLogin,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text("LOGIN"),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Forgot password?"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CyberCrimeScreen extends StatefulWidget {
  const CyberCrimeScreen({super.key});

  @override
  State<CyberCrimeScreen> createState() => _CyberCrimeScreenState();
}

class _CyberCrimeScreenState extends State<CyberCrimeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedType;

  final List<String> crimeTypes = [
    "تحرش إلكتروني",
    "تهديد أو ابتزاز",
    "اختراق حساب",
    "موقع مشبوه",
    "تزوير أو احتيال",
    "رسائل مريبة",
    "أخرى"
  ];

  void sendReport() {
    if (_formKey.currentState!.validate() && selectedType != null) {
      String type = selectedType!;
      String desc = descriptionController.text.trim();

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("✅ تم إرسال البلاغ"),
          content: Text("النوع: $type\nالوصف: $desc"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("حسناً"),
            )
          ],
        ),
      );

      // إعادة تعيين النموذج
      descriptionController.clear();
      setState(() => selectedType = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("بلاغ جريمة إلكترونية"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: selectedType,
                items: crimeTypes
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type, textAlign: TextAlign.right),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedType = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "نوع الجريمة",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null ? "الرجاء اختيار نوع الجريمة" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "وصف الجريمة",
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) =>
                    value == null || value.isEmpty ? "أدخل وصفًا" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: sendReport,
                icon: const Icon(Icons.shield),
                label: const Text("إرسال البلاغ"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

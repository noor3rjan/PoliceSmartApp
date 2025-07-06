import 'package:flutter/material.dart';

class EmergencyReportScreen extends StatefulWidget {
  const EmergencyReportScreen({super.key});

  @override
  State<EmergencyReportScreen> createState() => _EmergencyReportScreenState();
}

class _EmergencyReportScreenState extends State<EmergencyReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedType;

  final List<String> eventTypes = [
    "شغب",
    "حادث سير",
    "سرقة",
    "اعتداء",
    "حالة طبية",
    "مشتبه به",
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

      // Reset
      descriptionController.clear();
      setState(() => selectedType = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إرسال بلاغ طارئ"),
        backgroundColor: Colors.red.shade700,
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
                items: event

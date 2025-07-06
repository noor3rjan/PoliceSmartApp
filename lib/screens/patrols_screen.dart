import 'package:flutter/material.dart';

class PatrolsScreen extends StatelessWidget {
  const PatrolsScreen({super.key});

  final List<Map<String, dynamic>> patrols = const [
    {
      'id': 'الدورية 1001',
      'members': [
        {'name': 'نور الدين عرجان', 'active': true},
        {'name': 'أحمد يوسف', 'active': false},
      ],
    },
    {
      'id': 'الدورية 1002',
      'members': [
        {'name': 'ليلى عامر', 'active': true},
        {'name': 'رؤى دغامين', 'active': true},
      ],
    },
    {
      'id': 'الدورية 1003',
      'members': [
        {'name': 'محمد عودة', 'active': false},
        {'name': 'سارة جمال', 'active': false},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الدوريات"),
        backgroundColor: const Color(0xff0c2340),
      ),
      body: ListView.builder(
        itemCount: patrols.length,
        itemBuilder: (context, index) {
          final patrol = patrols[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    patrol['id'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  ...List.generate(
                    patrol['members'].length,
                    (i) {
                      final member = patrol['members'][i];
                      return ListTile(
                        leading: Icon(
                          member['active']
                              ? Icons.circle
                              : Icons.circle_outlined,
                          color:
                              member['active'] ? Colors.green : Colors.grey,
                          size: 16,
                        ),
                        title: Text(member['name'], textAlign: TextAlign.right),
                        subtitle: Text(
                          member['active'] ? "نشط" : "غير نشط",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: member['active']
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

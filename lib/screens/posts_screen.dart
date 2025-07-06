import 'package:flutter/material.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  final List<Map<String, dynamic>> posts = const [
    {
      'sender': 'الملازم نور الدين',
      'type': 'إدارة',
      'content': 'يرجى من جميع الأفراد الالتزام بالزي الرسمي أثناء المناوبة.',
      'time': 'منذ 5 دقائق',
    },
    {
      'sender': 'الجندي أحمد يوسف',
      'type': 'فرد',
      'content': 'تم الإبلاغ عن مركبة مشبوهة في شارع الوحدة.',
      'time': 'منذ 12 دقيقة',
    },
    {
      'sender': 'الرائد ليلى عامر',
      'type': 'إدارة',
      'content': 'اجتماع طارئ اليوم الساعة 3:00 في مقر القيادة.',
      'time': 'قبل ساعة',
    },
  ];

  Color getColor(String type) {
    return type == "إدارة" ? Colors.blue.shade100 : Colors.grey.shade200;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الأحداث"),
        backgroundColor: const Color(0xff0c2340),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: getColor(post['type']),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      post['type'] == "إدارة" ? Icons.verified_user : Icons.person,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 8),
                    Text(post['sender'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Text(post['time'], style: const TextStyle(fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 10),
                Text(post['content'], textAlign: TextAlign.right),
              ],
            ),
          );
        },
      ),
    );
  }
}

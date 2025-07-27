import 'package:flutter/material.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // 👇 Dummy data for frontend testing
    final fakeClasses = [
      {'title': 'Intro to Singing', 'link': 'meet.google.com/abc-defg-hij'},
      {
        'title': 'Advanced Raga Practice',
        'link': 'meet.google.com/klm-nopq-rst'
      },
      {'title': 'Live Q&A Session', 'link': 'meet.google.com/uvw-xyz1-234'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Dashboard"),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: fakeClasses.length,
        itemBuilder: (context, index) {
          final cls = fakeClasses[index];
          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                cls['title']!,
                style: const TextStyle(color: Colors.amber, fontSize: 18),
              ),
              subtitle: Text(
                cls['link']!,
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.open_in_new, color: Colors.amber),
                onPressed: () {
                  // later: launch URL
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

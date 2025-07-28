import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// your screens
import 'screens/login_screen.dart';
import 'screens/teacher_dashboard.dart';
import 'screens/schedule_page.dart';

// your provider
import 'providers/class_schedule_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ClassScheduleProvider(),
      child: const BlackGoldApp(),
    ),
  );
}

class BlackGoldApp extends StatelessWidget {
  const BlackGoldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Black & Gold Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.amber),
          titleLarge: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      /// 👉 Start with login
      home: const LoginScreen(),

      /// 👉 Routes for navigation
      routes: {
        '/teacherDashboard': (context) => const TeacherDashboard(),
        '/schedule': (context) => const SchedulePage(),
      },
    );
  }
}

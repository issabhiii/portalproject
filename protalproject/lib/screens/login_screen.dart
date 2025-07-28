import 'package:flutter/material.dart';
import 'teacher_dashboard.dart';
import 'student_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool isTeacher = false;

  void _navigateAfterLogin() {
    if (isTeacher) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const TeacherDashboard()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const StudentDashboard()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(Icons.music_note, color: Colors.amber, size: 48),
                const SizedBox(height: 16),
                const Text(
                  "Black & Gold Portal",
                  style: TextStyle(fontSize: 28, color: Colors.amber),
                ),
                const SizedBox(height: 40),

                // Email
                TextField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.amber),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Password
                TextField(
                  controller: passController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.amber),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Switch
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Student",
                        style: TextStyle(color: Colors.amber)),
                    Switch(
                      value: isTeacher,
                      onChanged: (v) => setState(() => isTeacher = v),
                      activeColor: Colors.amber,
                    ),
                    const Text("Teacher",
                        style: TextStyle(color: Colors.amber)),
                  ],
                ),
                const SizedBox(height: 20),

                // Normal Login Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _navigateAfterLogin,
                  child: const Text("Login"),
                ),
                const SizedBox(height: 16),

                // ✅ DEVELOPMENT BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _navigateAfterLogin,
                  child: const Text(
                    "🚀 Development (Skip Login)",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

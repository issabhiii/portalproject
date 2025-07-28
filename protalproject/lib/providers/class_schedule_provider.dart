import 'package:flutter/material.dart';

class ClassSchedule {
  final String title;
  final DateTime startTime;
  final DateTime endTime;

  ClassSchedule(
      {required this.title, required this.startTime, required this.endTime});
}

class ClassScheduleProvider extends ChangeNotifier {
  final List<ClassSchedule> _classes = [];

  List<ClassSchedule> get classes => List.unmodifiable(_classes);

  void addClass(String title, DateTime start, DateTime end) {
    _classes.add(ClassSchedule(title: title, startTime: start, endTime: end));
    notifyListeners();
  }
}

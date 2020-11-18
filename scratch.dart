// import 'dart:io';
//
// void main() {
//   performTasks();
// }
//
// void performTasks() async {
//   task1();
//   print(task2());
// //  task3(task2Result);
// }
//
// void task1() {
//   String result = 'task 1 data';
//   print('Task 1 complete');
// }
//
// Future<String> task2() async {
//   Duration threeSeconds = Duration(seconds: 3);
//
//   String result;
//
//   await Future.delayed(threeSeconds, () {
//     result = 'task 2 data';
//     print('Task 2 complete');
//   });
//
//   return result;
// }
//
// void task3(String task2Data) {
//   String result = 'task 3 data';
//   print('Task 3 complete with $task2Data');
// }

// import 'package:intl/intl.dart';
//
// void main() {
//   timeConverter(16029323);
// }
//
// String timeConverter(int number) {
//   final int secondsSinceEpoch = number;
//   final int millisecondsSinceEpoch = secondsSinceEpoch * 1000;
//   final DateTime result =
//   DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
//   return DateFormat.jm().format(result);
// }

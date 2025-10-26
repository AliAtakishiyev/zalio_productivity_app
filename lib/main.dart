import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zalio_app/data/task_repository.dart';
import 'package:zalio_app/screens/todo_screen.dart';

void main() async {

  await TaskRepository.initialize();
  //   await Hive.initFlutter();

  // await Hive.deleteBoxFromDisk('tasks'); // ✅ delete first
  // await Hive.openBox('tasks'); // ✅ then open


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TodoScreen(),
    );
  }
}

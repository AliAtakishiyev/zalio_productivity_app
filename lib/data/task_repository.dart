import 'package:hive_flutter/hive_flutter.dart';
import '../models/tasks.dart';

class TaskRepository {
  static const String _boxName = "tasks";

  

  Box<Tasks> _getBox() => Hive.box(_boxName);

  // Initialize - call this in main.dart
  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TasksAdapter());
    await Hive.openBox<Tasks>(_boxName);
  }

  Future<void> addTask(Tasks task) async {
    final box = _getBox();
    await box.put(task.id, task);
  }

  Tasks? getTask(int id) {
    final box = _getBox();
    return box.get(id);
  }

  List<Tasks> getTasksByCategory(String category) {
    final box = _getBox();
    return box.values.where((task) => task.category == category).toList();
  }

  List<Tasks> getAllTasks(){
    final box = _getBox();
    return box.values.toList();
  }

  int getTasksLength() {
    final box = _getBox();
    return box.length; //return box.length;
  }

  int getDoneTaskCount(){
    final box = _getBox();
    int count = 0;
    for(Tasks task in box.values){
      if(task.isChecked == true){
        count++;
      }
    }

    return count;
  }

  Future<void> deleteTask(int id) async {
    final box = _getBox();
    await box.delete(id);
  }

  int getNextId(){
    final box = _getBox();
    
    if(box.isEmpty){
      return 0;
    }
// Find the highest ID and add 1
  int maxId = 0;
  for (var task in box.values) {
    if (task.id > maxId) {
      maxId = task.id;
    }
  }
  
  return maxId + 1;

  }
}

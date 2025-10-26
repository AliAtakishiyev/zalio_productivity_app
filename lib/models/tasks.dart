import 'package:hive/hive.dart';

part 'tasks.g.dart';

@HiveType(typeId: 0)
class Tasks extends HiveObject {

  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String category;

  @HiveField(3)
  String date;

  @HiveField(4)
  bool isChecked = false;

  Tasks({required this.id,required this.title, required this.category, required this.date, required this.isChecked});
}
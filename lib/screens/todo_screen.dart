import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:zalio_app/data/task_repository.dart';
import 'package:zalio_app/models/tasks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zalio_app/widgets/add_task_dialog.dart';
import 'package:zalio_app/widgets/bottom_nav_bar.dart';
import 'package:zalio_app/widgets/todays_progress.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  //Tasks Repository instance
  final TaskRepository _taskRepository = TaskRepository();

  Set<String> selected = {'All'};
  int bottomMenuIndex = 0;

  int dotCount = 0;

  String selectedCategory = 'Study';

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  var tasksBox = Hive.box<Tasks>("Tasks");

  //List<Tasks> get tasks => _taskRepository.getAllTasks();
  //late List<Tasks> tasks = _taskRepository.getAllTasks(); //_taskRepository.getAllTasks();
  List<Tasks> tasks = [];

  bool isChecked = false;

  int finishedTaskCount = 0;

  @override
  void initState() {
    super.initState();
    tasks = _taskRepository.getAllTasks();
    finishedTaskCount = _taskRepository.getDoneTaskCount();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xff0B0B0A),
      appBar: AppBar(
        backgroundColor: Color(0xff0D0D0D),
        toolbarHeight: 70,

        title: Text(
          "Zalio Tasks",
          style: TextStyle(
            color: Color(0xff7D3BEC),
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1), // height of the line
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  "Organize your life, one task at a time",
                  style: TextStyle(color: Color(0xff999999)),
                ),
              ),
              SizedBox(height: 8),
              Container(
                color: const Color.fromARGB(122, 158, 158, 158), // line color
                height: 1, // line thickness
              ),
            ],
          ),
        ),

        centerTitle: false,
      ),

      body: ListView(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //SizedBox(height: screenHeight * 0.03),
              SizedBox(height: 30),

              TodaysProgress(
                finishedTaskCount: finishedTaskCount,
                tasks: tasks,
                screenWidth: screenWidth,
              ),

              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 20),
                    child: SizedBox(
                      width: 95,
                      child: Text(
                        "Your Tasks",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          final result = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddTaskDialog(
                                selectedCategory: selectedCategory,
                                tasks: tasks,
                                selected: selected,
                                isChecked: isChecked,
                              );
                            },
                          );

                          if (result == true) {
                            setState(() {
                              tasks = _taskRepository.getAllTasks();
                              finishedTaskCount = _taskRepository
                                  .getDoneTaskCount();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color(0xff7D3BEC),
                        ),
                        child: Text(
                          "+  Add Task",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              SizedBox(
                width: screenHeight * 0.9,
                child: SegmentedButton(
                  segments: [
                    ButtonSegment(
                      value: "All",
                      label: Text(
                        "All",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    ButtonSegment(
                      value: "Work",
                      label: Text(
                        "Work",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    ButtonSegment(
                      value: "Study",
                      label: Text(
                        "Study",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    ButtonSegment(
                      value: "Personal",
                      label: Text(
                        "Personal",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Color(0xff1e1e1f); // selected color
                      }
                      return Color(0xff1e1e1f); // selected color
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white; // selected color
                      }
                      return Color(0xff999999); // selected color
                    }),

                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    side: WidgetStateProperty.all(BorderSide.none),

                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                  selected: selected,

                  showSelectedIcon: false,

                  onSelectionChanged: (newselection) {
                    setState(() {
                      selected = newselection;
                      if (selected.contains("All")) {
                        tasks = _taskRepository.getAllTasks();
                      } else {
                        tasks = _taskRepository.getTasksByCategory(
                          selected.first,
                        );
                      }
                    });
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: 32),

          // Column for tasks
          Column(
            children: tasks.map((task) {
              return Card(
                color: task.isChecked
                    ? Color(0xff0D0D0D)
                    : Color(0xff0F0E0E), //0xff0D0D0D
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: task.isChecked
                        ? Color(0xff161617)
                        : Color(0xff1E1E1F),
                  ), //true: 161617 false:0xff1E1E1F
                ),
                margin: EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 28, horizontal: 12),
                  child: Row(
                    children: [
                      Checkbox(
                        value: task.isChecked,
                        onChanged: (value) async {
                          setState(() {
                            task.isChecked = value!;
                            finishedTaskCount = _taskRepository
                                .getDoneTaskCount();
                          });

                          await task.save();
                        },
                        shape: CircleBorder(),
                        checkColor: Colors.white,
                        fillColor: WidgetStateProperty.resolveWith<Color>((
                          states,
                        ) {
                          if (states.contains(WidgetState.selected)) {
                            return Color(0xff186431);
                          } else {
                            return Colors.transparent;
                          }
                        }),
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.title,
                                  style: TextStyle(
                                    color: task.isChecked
                                        ? Color(0xff606161)
                                        : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,

                                    decoration: task.isChecked
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    decorationColor: Color(0xff606161),
                                  ),
                                ),

                                Row(
                                  children: [
                                    Text(
                                      task.category,
                                      style: TextStyle(
                                        color: task.isChecked
                                            ? Color(0xff77539B)
                                            : Color(0xffC185FC),
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Row(
                                      children: [
                                        if (task.date.isNotEmpty) ...[
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            color: task.isChecked
                                                ? Color(0xff606161)
                                                : Color(0xff999999),
                                            size: 16,
                                          ),
                                        ],

                                        SizedBox(width: 4),
                                        Text(
                                          task.date,
                                          style: TextStyle(
                                            color: task.isChecked
                                                ? Color(0xff606161)
                                                : Color(0xff999999),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            IconButton(
                              alignment: Alignment.centerLeft,
                              color: task.isChecked
                                  ? Color(0xff606161)
                                  : Color(0xff999999),
                              onPressed: () async {
                                await _taskRepository.deleteTask(task.id);
                                setState(() {
                                  finishedTaskCount = _taskRepository
                                      .getDoneTaskCount();
                                  if (selected.contains("All")) {
                                    tasks = _taskRepository.getAllTasks();
                                  } else {
                                    tasks = _taskRepository.getTasksByCategory(
                                      selected.first,
                                    );
                                  }
                                });
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }
}

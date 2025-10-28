import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:zalio_app/data/task_repository.dart';
import 'package:zalio_app/models/tasks.dart';
import 'package:zalio_app/screens/pomodoro_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
              SizedBox(height: screenHeight * 0.03),
              SizedBox(
                width: screenWidth * 0.98,
                //height: screenHeight * 0.3,
                child: Card(
                  color: Color(0xff0D0D0D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
                    side: const BorderSide(color: Color(0xff1E1E1F)),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30.0,
                      bottom: 30.0,
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'lib/assets/icons/graph-up.svg',
                                width: 60,
                              ),
                              Text(
                                "Today's Progress",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              text: "$finishedTaskCount",
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(
                                  text: " / ",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xff999999),
                                  ),
                                ),

                                TextSpan(
                                  text: "${tasks.length} tasks",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff999999),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 24),

                        LinearProgressIndicator(
                          value: (tasks.isEmpty)
                              ? 0
                              : finishedTaskCount / tasks.length,
                          minHeight: 16,
                          backgroundColor: Color(0xff1E1E1F),
                          color: Color(0xff7D3BEC),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        SizedBox(height: 24),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "🎉 All tasks completed! Great work!",
                            style: TextStyle(
                              color: Color(0xff999999),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                        onPressed: () {
                          setState(() {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: Dialog(
                                    insetPadding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ), // Reduce default padding

                                    backgroundColor: Color(0xff0A0B0A),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(Icons.close),
                                              ),
                                            ),

                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Create New Task",
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: 24),

                                            Text(
                                              "Task Title",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),

                                            SizedBox(height: 8),

                                            TextField(
                                              controller: _controller,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),

                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),

                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                          0xff7D3BEC,
                                                        ),
                                                        width: 3,
                                                      ),
                                                    ),
                                                fillColor: Colors.white,
                                              ),

                                              onChanged: (value) {},
                                            ),

                                            SizedBox(height: 24),

                                            Text(
                                              "Category",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),

                                            SizedBox(height: 8),

                                            DropdownMenu<String>(
                                              width: double.infinity,
                                              initialSelection:
                                                  selectedCategory,
                                              onSelected: (value) {
                                                selectedCategory = value!;
                                              },

                                              menuStyle: MenuStyle(
                                                minimumSize:
                                                    WidgetStateProperty.all(
                                                      Size(
                                                        double.infinity,
                                                        0,
                                                      ), // Width of dropdown list
                                                    ),
                                                maximumSize:
                                                    WidgetStateProperty.all(
                                                      Size(
                                                        double.infinity,
                                                        400,
                                                      ), // Width and max height
                                                    ),
                                                side: WidgetStatePropertyAll(
                                                  BorderSide(
                                                    color: Color(0xff1E1E1F),
                                                  ),
                                                ),

                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                      Color(0xff0D0D0D),
                                                    ),
                                                surfaceTintColor:
                                                    WidgetStatePropertyAll(
                                                      Colors.transparent,
                                                    ),
                                              ),

                                              inputDecorationTheme:
                                                  const InputDecorationTheme(
                                                    filled: true,
                                                    fillColor: Color(
                                                      0xFF1A1A1A,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                            Radius.circular(8),
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                          0xFF6A0DAD,
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                              textStyle: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              trailingIcon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.white,
                                              ),

                                              dropdownMenuEntries: [
                                                DropdownMenuEntry(
                                                  value: 'Work',
                                                  label: 'Work',
                                                  style: ButtonStyle(
                                                    foregroundColor:
                                                        WidgetStateProperty.all(
                                                          Colors.white,
                                                        ),
                                                  ),
                                                ),
                                                DropdownMenuEntry(
                                                  value: 'Study',
                                                  label: 'Study',
                                                  style: ButtonStyle(
                                                    foregroundColor:
                                                        WidgetStateProperty.all(
                                                          Colors.white,
                                                        ),
                                                  ),
                                                ),
                                                DropdownMenuEntry(
                                                  value: 'Personal',
                                                  label: 'Personal',

                                                  style: ButtonStyle(
                                                    foregroundColor:
                                                        WidgetStateProperty.all(
                                                          Colors.white,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: 24),

                                            Text(
                                              "Due Date(Optional)",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),

                                            TextField(
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),

                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9.]'),
                                                ),
                                                LengthLimitingTextInputFormatter(
                                                  10,
                                                ),
                                              ],

                                              onChanged: (value) {
                                                if (value.contains("."))
                                                  dotCount++;

                                                if (value.length == 10) {
                                                  if (dotCount == 2) {
                                                    try {
                                                      final parts = value.split(
                                                        ".",
                                                      );
                                                      if (parts.length == 3) {
                                                        int day = int.parse(
                                                          parts[0],
                                                        );
                                                        int month = int.parse(
                                                          parts[1],
                                                        );
                                                        int year = int.parse(
                                                          parts[2],
                                                        );

                                                        DateTime date =
                                                            DateTime(
                                                              year,
                                                              month,
                                                              day,
                                                            );

                                                        if (date.day != day ||
                                                            date.month !=
                                                                month ||
                                                            date.year != year) {
                                                          Fluttertoast.showToast(
                                                            msg:
                                                                "Invalid type of date",
                                                          );
                                                          _dateController
                                                              .clear();
                                                        }
                                                      }
                                                    } catch (e) {
                                                      // Fluttertoast.showToast(
                                                      //   msg:
                                                      //       "Invalid type of date",
                                                      // );
                                                      // _dateController.clear();
                                                    }
                                                  } else {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "Invalid type of date",
                                                    );
                                                    _dateController.clear();
                                                  }
                                                }
                                              },

                                              decoration: InputDecoration(
                                                hintText: 'dd.mm.yyyy',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                          0xff7D3BEC,
                                                        ),
                                                        width: 3,
                                                      ),
                                                    ),
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    Icons.calendar_today,
                                                  ),
                                                  onPressed: () async {
                                                    DateTime? pickedDate =
                                                        await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate: DateTime(
                                                            2000,
                                                          ),
                                                          lastDate: DateTime(
                                                            2100,
                                                          ),
                                                        );

                                                    if (pickedDate != null) {
                                                      // Format the date as dd.mm.yyyy
                                                      String formattedDate =
                                                          "${pickedDate.day.toString().padLeft(2, '0')}.${pickedDate.month.toString().padLeft(2, '0')}.${pickedDate.year}";
                                                      _dateController.text =
                                                          formattedDate;
                                                    }
                                                  },
                                                ),
                                              ),
                                              controller: _dateController,
                                              keyboardType:
                                                  TextInputType.datetime,
                                            ),

                                            SizedBox(height: 16),

                                            SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  if (_controller
                                                      .text
                                                      .isNotEmpty) {
                                                    Tasks newTask = Tasks(
                                                      id: _taskRepository
                                                          .getNextId(),
                                                      title: _controller.text,
                                                      category:
                                                          selectedCategory,
                                                      date:
                                                          _dateController.text,
                                                      isChecked: isChecked,
                                                    );

                                                    await _taskRepository
                                                        .addTask(newTask);
                                                  }

                                                  setState(() {
                                                    if (_dateController
                                                            .text
                                                            .length ==
                                                        10) {
                                                      if (selected.contains(
                                                        "All",
                                                      )) {
                                                        tasks = _taskRepository
                                                            .getAllTasks();
                                                      } else {
                                                        tasks = _taskRepository
                                                            .getTasksByCategory(
                                                              selected.first,
                                                            );
                                                      }
                                                      if (_controller
                                                          .text
                                                          .isEmpty) {
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              "Task Title can't be empty",
                                                        );
                                                      } else {
                                                        _controller.clear();
                                                        _dateController.clear();

                                                        Navigator.pop(context);
                                                      }
                                                    }else{
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Date input invalid",
                                                        );
                                                        _dateController.clear();
                                                    }
                                                  });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Color(
                                                    0xff7D3BEC,
                                                  ),
                                                ),
                                                child: Text(
                                                  "Create Task",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          });
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

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff141515),
        currentIndex: bottomMenuIndex,
        selectedItemColor: const Color(0xffFAFBFB),
        unselectedItemColor: const Color(0xffFAFBFB),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (index) {
          setState(() {
            bottomMenuIndex = index;
            if (bottomMenuIndex == 1) {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      PomodoroScreen(),
                  transitionDuration: Duration.zero, // 🧠 No animation
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            }
          });
          //widget.bottomMenuIndex(index); // notify parent screen
        },
        items: [
          BottomNavigationBarItem(
            icon: bottomMenuIndex == 0
                ? SvgPicture.asset(
                    'lib/assets/icons/tasks-selected.svg',
                    width: 30,
                  )
                : SvgPicture.asset('lib/assets/icons/tasks.svg', width: 30),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon: bottomMenuIndex == 1
                ? SvgPicture.asset(
                    'lib/assets/icons/pomodoro-selected.svg',
                    width: 30,
                  )
                : SvgPicture.asset('lib/assets/icons/pomodoro.svg', width: 30),
            label: "PomodoroTimer",
          ),
        ],
      ),
    );
  }
}

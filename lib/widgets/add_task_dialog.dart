import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zalio_app/data/task_repository.dart';
import 'package:zalio_app/models/tasks.dart';

class AddTaskDialog extends StatefulWidget {
  final dynamic selectedCategory;

  final dynamic tasks;

  final dynamic selected;

  final dynamic isChecked;

  const AddTaskDialog({
    super.key,
    required this.selectedCategory,
    required this.tasks,
    required this.selected,
    required this.isChecked,
  });

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  final TaskRepository _taskRepository = TaskRepository();

  int dotCount = 0;

  List<Tasks> tasks = [];

  @override
  void initState() {
    super.initState();
    tasks = _taskRepository.getAllTasks();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String selectedCategory = widget.selectedCategory;
    //var tasks = widget.tasks;
    Set<String> selected = widget.selected;
    bool isChecked = widget.isChecked;

    return SingleChildScrollView(
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: 20,
        ), // Reduce default padding

        backgroundColor: Color(0xff0A0B0A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  style: TextStyle(color: Colors.white),

                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xff7D3BEC),
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
                  initialSelection: selectedCategory,
                  onSelected: (value) {
                    selectedCategory = value!;
                  },

                  menuStyle: MenuStyle(
                    minimumSize: WidgetStateProperty.all(
                      Size(double.infinity, 0), // Width of dropdown list
                    ),
                    maximumSize: WidgetStateProperty.all(
                      Size(double.infinity, 400), // Width and max height
                    ),
                    side: WidgetStatePropertyAll(
                      BorderSide(color: Color(0xff1E1E1F)),
                    ),

                    backgroundColor: WidgetStatePropertyAll(Color(0xff0D0D0D)),
                    surfaceTintColor: WidgetStatePropertyAll(
                      Colors.transparent,
                    ),
                  ),

                  inputDecorationTheme: const InputDecorationTheme(
                    filled: true,
                    fillColor: Color(0xFF1A1A1A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Color(0xFF6A0DAD)),
                    ),
                  ),

                  textStyle: const TextStyle(color: Colors.white),
                  trailingIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),

                  dropdownMenuEntries: [
                    DropdownMenuEntry(
                      value: 'Work',
                      label: 'Work',
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                      ),
                    ),
                    DropdownMenuEntry(
                      value: 'Study',
                      label: 'Study',
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                      ),
                    ),
                    DropdownMenuEntry(
                      value: 'Personal',
                      label: 'Personal',

                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(Colors.white),
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
                  style: TextStyle(color: Colors.white),

                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    LengthLimitingTextInputFormatter(10),
                  ],

                  onChanged: (value) {
                    if (value.contains(".")) dotCount++;

                    if (value.length == 10) {
                      if (dotCount == 2) {
                        try {
                          final parts = value.split(".");
                          if (parts.length == 3) {
                            int day = int.parse(parts[0]);
                            int month = int.parse(parts[1]);
                            int year = int.parse(parts[2]);

                            DateTime date = DateTime(year, month, day);

                            if (date.day != day ||
                                date.month != month ||
                                date.year != year) {
                              Fluttertoast.showToast(
                                msg: "Invalid type of date",
                              );
                              _dateController.clear();
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
                        Fluttertoast.showToast(msg: "Invalid type of date");
                        _dateController.clear();
                      }
                    }
                  },

                  decoration: InputDecoration(
                    hintText: 'dd.mm.yyyy',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xff7D3BEC),
                        width: 3,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          // Format the date as dd.mm.yyyy
                          String formattedDate =
                              "${pickedDate.day.toString().padLeft(2, '0')}.${pickedDate.month.toString().padLeft(2, '0')}.${pickedDate.year}";
                          _dateController.text = formattedDate;
                        }
                      },
                    ),
                  ),
                  controller: _dateController,
                  keyboardType: TextInputType.datetime,
                ),

                SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_controller.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Task Title can't be empty",
                        );
                        return;
                      }

                      // Date check
                      if (_dateController.text.isNotEmpty &&
                          _dateController.text.length != 10) {
                        Fluttertoast.showToast(msg: "Date input invalid");
                        _dateController.clear();
                        return;
                      }

                      // ✅ Create and save task
                      Tasks newTask = Tasks(
                        id: _taskRepository.getNextId(),
                        title: _controller.text,
                        category: selectedCategory,
                        date: _dateController.text,
                        isChecked: isChecked,
                      );

                      await _taskRepository.addTask(newTask);

                      // ✅ Close dialog and send "true" to parent
                      Navigator.pop(context, true);
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff7D3BEC),
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
  }
}

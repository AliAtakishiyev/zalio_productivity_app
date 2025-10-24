import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zalio_app/screens/pomodoro_screen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  Set<String> selected = {'All'};
  int bottomMenuIndex = 0;

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
            children: [
              SizedBox(height: screenHeight * 0.03),
              SizedBox(
                width: screenWidth * 0.98,
                height: screenHeight * 0.3,
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
                              text: "0",
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
                                  text: "1 tasks",
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
                          value: 0.45,
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
                                return Dialog(
                                  backgroundColor: Color(0xff0A0B0A),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
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
                                        Text(
                                          "Task Title",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),

                                        TextField(
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),

                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                color: Color(0xff7D3BEC),
                                                width: 3,
                                              ),
                                            ),
                                            fillColor: Colors.white,
                                          ),

                                          onChanged: (value) {
                                            
                                          },
                                        ),
                                      ],
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
                    });
                  },
                ),
              ),
            ],
          ),

          //when user add new tast you should show it here
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

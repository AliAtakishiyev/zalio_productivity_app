import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zalio_app/data/pomodoro_settings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zalio_app/widgets/bottom_nav_bar.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  int bottomMenuIndex = 1;

  Timer? _timer;
  int _remainingSeconds = 0;
  bool isExpanded = false;
  bool _isRunning = false;
  bool studyMode = true;
  bool isPaused = true;

  final TextEditingController _studyMinuteController = TextEditingController(
    text: '25',
  );
  final TextEditingController _breakMinuteController = TextEditingController(
    text: '5',
  );

  PomodoroSettings settings = PomodoroSettings(
    studyMinutes: 25,
    breakMinutes: 5,
    studyMinutesRightNow: 25,
    breakMinutesRightNow: 5,
    sessionsToday: 0,
  );

  @override
  void initState() {
    super.initState();
    _resetTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _resetTimer() {
    setState(() {
      _remainingSeconds = studyMode
          ? settings.studyMinutes * 60
          : settings.breakMinutes * 60;
      _isRunning = false;
    });
    _timer?.cancel();
  }

  void _startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer?.cancel();
          _isRunning = false;

          if (studyMode) {
            settings.sessionsToday++;
          }
          // Timer finished - switch mode
          studyMode = !studyMode;

          _resetTimer();
          isPaused = !isPaused;
        }
      });
    });
  }

  void _pauseTimer() {
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
  }

  String formatSecond() {
    int seconds = _remainingSeconds % 60;

    return seconds.toString().padLeft(2, '0');
  }

  int returnMinute() {
    int minutes = _remainingSeconds ~/ 60;
    return minutes;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
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
              SizedBox(height: 24),
              AnimatedSize(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
                // width: screenWidth * 0.98,
                // height: isExpanded ? screenHeight * 0.2 : screenHeight * 0.08,
                child: Container(
                  width: screenWidth * 0.98,
                  child: Card(
                    color: Color(0xff0F0E0E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(10),
                      ),
                      side: const BorderSide(color: Color(0xff1E1E1F)),
                    ),

                    child: InkWell(
                      splashColor: Colors.transparent, // 💧 remove ripple
                      highlightColor: Colors.transparent, // 💡 remove tap glow
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },

                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.settings, color: Colors.white),
                                SizedBox(width: 12),
                                Text(
                                  "Timer Settings",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            if (isExpanded) ...[
                              SizedBox(height: 12),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Focus Duration (minutes)",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 12),
                                  TextField(
                                    controller: _studyMinuteController,
                                    keyboardType: TextInputType.number,
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

                                    onChanged: (value) {
                                      setState(() {
                                        if (value.isEmpty) {
                                          //studyMtext = '25';
                                          settings.studyMinutes = 25;
                                        } else {
                                          int valueINT = int.parse(value);
                                          if (valueINT <= 999) {
                                            settings.studyMinutes = valueINT;
                                          } else {
                                            Fluttertoast.showToast(
                                              msg:
                                                  "Times minute can't be more than 999",
                                            );
                                          }
                                        }

                                        if (studyMode && !_isRunning) {
                                          _resetTimer();
                                        }
                                      });
                                    },
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    "Break Duration (minutes)",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 12),
                                  TextField(
                                    controller: _breakMinuteController,
                                    keyboardType: TextInputType.number,
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

                                    onChanged: (value) {
                                      setState(() {
                                        if (value.isEmpty) {
                                          //studyMtext = '25';
                                          settings.breakMinutes = 5;
                                        } else {
                                          int valueINT = int.parse(value);
                                          if (valueINT <= 999) {
                                            settings.breakMinutes = valueINT;
                                          } else {
                                            Fluttertoast.showToast(
                                              msg:
                                                  "Times minute can't be more than 999",
                                            );
                                          }
                                        }

                                        if (!studyMode && !_isRunning) {
                                          _resetTimer();
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: screenWidth * 0.98,
                //height: screenHeight * 0.22,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      color: Color(0xff0F0E0E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(10),
                        ),
                        side: const BorderSide(color: Color(0xff1E1E1F)),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                "SESSIONS TODAY",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff999999),
                                ),
                              ),

                              Text(
                                "${settings.sessionsToday}",
                                style: TextStyle(
                                  fontSize: 56,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff7D3BEC),
                                ),
                              ),
                              Text(
                                "Start your first session!",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff999999),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: screenWidth * 0.98,
                //height: screenHeight * 0.57,
                child: Card(
                  color: Color(0xff0F0E0E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
                    side: const BorderSide(color: Color(0xff1E1E1F)),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 32,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                studyMode ? Icons.timer : Icons.coffee,
                                size: 30,
                                color: studyMode
                                    ? Color(0xff7D3BEC) //0xff7D3BEC
                                    : Color(0xff17A04A),
                              ),
                              SizedBox(width: 8),
                              Text(
                                studyMode ? "FOCUS TIME" : "BREAK TIME",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24),
                          //timer
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              //studyMode?  "${returnMinute()}:${returnSecond()}" : "${settings.studyMinutes}:00" ,
                              "${returnMinute()}:${formatSecond()}",
                              style: TextStyle(
                                fontSize: 110,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: LinearProgressIndicator(
                              value:
                                  1 -
                                  (_remainingSeconds /
                                      (studyMode
                                          ? settings.studyMinutes * 60
                                          : settings.breakMinutes * 60)),
                              minHeight: 16,
                              backgroundColor: Color(0xff1E1E1F),
                              color: Color(0xff7D3BEC),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Start",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                studyMode
                                    ? "${settings.studyMinutes} min focus"
                                    : "${settings.breakMinutes} min break",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 36),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 4,
                                child: TextButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      isPaused = !isPaused;

                                      if (isPaused == true) {
                                        _pauseTimer();
                                      } else {
                                        _startTimer();
                                      }
                                      print("started");
                                    });
                                  },
                                  label: Text(
                                    isPaused ? "Start" : "Pause",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  icon: Icon(
                                    isPaused
                                        ? Icons.play_arrow_outlined
                                        : Icons.pause_outlined,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                  style: TextButton.styleFrom(
                                    minimumSize: Size(240, 75),
                                    backgroundColor: Color(0xff7D3BEC),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        16,
                                      ), // rounded corners
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 12),
                              //Reset
                              Flexible(
                                flex: 2,
                                child: IconButton(
                                  style: IconButton.styleFrom(
                                    minimumSize: Size(100, 75),
                                    backgroundColor: Color(0xff1E1E1F),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        16,
                                      ), // rounded corners
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPaused = true;
                                      _resetTimer();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.restore,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 32),
                          ElevatedButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size(340, 50),
                              backgroundColor: _isRunning
                                  ? Color(0xff0D0D0D)
                                  : Color(0xff0B0B0A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  16,
                                ), // rounded corners
                              ),

                              side: BorderSide(
                                width: 0.5,
                                color: _isRunning
                                    ? Color(0xff1E1E1F)
                                    : Colors.white,
                              ),
                            ),
                            onPressed: _isRunning
                                ? () {
                                    setState(() {});
                                  }
                                : () {
                                    setState(() {
                                      studyMode = !studyMode;
                                      _resetTimer();
                                    });
                                  },
                            child: Text(
                              studyMode
                                  ? "Switch to Break Mode"
                                  : "Switch to Study Mode",
                              style: TextStyle(
                                color: _isRunning
                                    ? Color(0xff848584)
                                    : Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),

              SizedBox(
                width: screenWidth * 0.98,
                //height: screenHeight * 0.2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      color: Color(0xff0F0E0E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(10),
                        ),
                        side: const BorderSide(color: Color(0xff1E1E1F)),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "How it works",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              "• Focus for ${25} minutes on a single task",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff979797),
                              ),
                            ),

                            Text(
                              "• Take a ${5}-minute break",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff979797),
                              ),
                            ),

                            Text(
                              "• Repeat to boost productivity",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff979797),
                              ),
                            ),

                            Text(
                              "• After 4 sessions, take a longer break",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff979797),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

     bottomNavigationBar: BottomNavBar(currentIndex: 1,),
    );
  }
}

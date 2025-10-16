import 'package:flutter/material.dart';
import 'package:zalio_app/screens/todo_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  int bottomMenuIndex = 1;

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
              SizedBox(height: 24),
              SizedBox(
                width: screenWidth * 0.98,
                height: screenHeight * 0.08,
                child: Card(
                  color: Color(0xff0F0E0E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
                    side: const BorderSide(color: Color(0xff1E1E1F)),
                  ),

                  child: InkWell(
                    splashColor: Colors.transparent, // 💧 remove ripple
                    highlightColor: Colors.transparent, // 💡 remove tap glow
                    onTap: () {
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
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
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: screenWidth * 0.98,
                height: screenHeight * 0.22,
                child: Card(
                  color: Color(0xff0F0E0E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
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
                            "0",
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
              ),
              SizedBox(height: 24),
              SizedBox(
                width: screenWidth * 0.98,
                height: screenHeight * 0.57,
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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.timer,
                                size: 30,
                                color: Color(0xff7D3BEC),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "FOCUS TIME",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24),

                          Text(
                            "25:00",
                            style: TextStyle(
                              fontSize: 110,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: LinearProgressIndicator(
                              value: 0.0,
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
                                "${25} min focus",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 36),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton.icon(
                                onPressed: () {},
                                label: Text(
                                  "Start",
                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
                                ),
                                icon: Icon(
                                  Icons.play_arrow_outlined,
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

                              IconButton(
                                style: IconButton.styleFrom(
                                  minimumSize: Size(100, 75),
                                  backgroundColor: Color(0xff1E1E1F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      16,
                                    ), // rounded corners
                                  ),
                                ),
                                onPressed: () {},
                                icon: Icon(Icons.restore,color: Colors.white,),
                              ),
                            ],
                          ),
                          SizedBox(height: 32),
                          ElevatedButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size(340, 50),
                              backgroundColor: Color(0xff0B0B0A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  16,
                                ), // rounded corners
                              ),

                              side: BorderSide(width: 0.2, color: Colors.white),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Switch to Break Mode",
                              style: TextStyle(
                                color: Colors.white,
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
              SizedBox(height: 24,),

              SizedBox(
                width: screenWidth * 0.98,
                height: screenHeight * 0.2,
                child: Card(
                  color: Color(0xff0F0E0E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
                    side: const BorderSide(color: Color(0xff1E1E1F)),
                  ),
              
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "How it works",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
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
              ),
            ],
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
            if (bottomMenuIndex == 0) {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      TodoScreen(),
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

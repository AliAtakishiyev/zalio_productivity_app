import 'package:flutter/material.dart';
import 'package:zalio_app/screens/pomodoro_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zalio_app/screens/todo_screen.dart';


class BottomNavBar extends StatefulWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});
  

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  late int bottomMenuIndex = 0;

  @override
void initState() {
  super.initState();
  bottomMenuIndex = widget.currentIndex;
}

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
            }else if(bottomMenuIndex == 0){
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
      );
  }
}
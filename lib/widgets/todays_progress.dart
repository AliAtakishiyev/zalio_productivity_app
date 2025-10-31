import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TodaysProgress extends StatefulWidget {
  
  final dynamic tasks;
  final dynamic finishedTaskCount;
  
  final dynamic screenWidth;


   const TodaysProgress({super.key,required this.finishedTaskCount, required this.tasks, required this.screenWidth});

  @override
  State<TodaysProgress> createState() => _TodaysProgressState();
}

class _TodaysProgressState extends State<TodaysProgress> {

  @override
  Widget build(BuildContext context) {
    final int finishedTaskCount = widget.finishedTaskCount;
    final tasks = widget.tasks;
    final screenWidth = widget.screenWidth;
    
    return SizedBox(
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
                                'assets/icons/graph-up.svg',
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
              );
  }
}
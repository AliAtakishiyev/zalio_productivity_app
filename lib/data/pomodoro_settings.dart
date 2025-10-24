class PomodoroSettings {
  int studyMinutes;
  int breakMinutes;

  int studyMinutesRightNow;
  int breakMinutesRightNow;

  int sessionsToday;

  PomodoroSettings({
    required this.studyMinutes,
    required this.breakMinutes,
    required this.studyMinutesRightNow,
    required this.breakMinutesRightNow,
     this.sessionsToday = 0,
  });
}

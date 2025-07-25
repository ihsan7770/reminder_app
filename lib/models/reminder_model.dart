class ReminderModel {
  final String day;
  final String activity;
  final String time;

  ReminderModel({required this.day, required this.activity, required this.time});

  @override
  String toString() => "$day : $time : $activity";
}

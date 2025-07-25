import 'package:flutter/material.dart';
import '../models/reminder_model.dart';

class ReminderList extends StatelessWidget {
  final List<ReminderModel> reminders;
  const ReminderList({super.key, required this.reminders});

  @override
  Widget build(BuildContext context) {
    if (reminders.isEmpty) {
      return const Center(child: Text("No Reminders Added Yet"));
    }

    return ListView.builder(
  itemCount: reminders.length,
  itemBuilder: (_, index) {
    final reminder = reminders[index];
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.notifications_active, color: Colors.blue),
        title: Text(
          reminder.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        trailing: const Icon(Icons.alarm, color: Colors.grey),
      ),
    );
  },
);


  }
}

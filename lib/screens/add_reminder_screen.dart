import 'package:flutter/material.dart';

import '../models/reminder_model.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});
  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  final List<String> activities = ['Wake up', 'Go to gym', 'Breakfast', 'Meetings', 'Lunch', 'Quick nap', 'Go to library', 'Dinner', 'Go to sleep'];

  String? selectedDay;
  String? selectedActivity;
  TimeOfDay? selectedTime;
  

  void _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) setState(() => selectedTime = picked);
  }

  void _saveReminder() {
    if (selectedDay != null && selectedActivity != null && selectedTime != null) {
      final reminder = ReminderModel(
        day: selectedDay!,
        activity: selectedActivity!,
        time: selectedTime!.format(context),
      );
      Navigator.pop(context, reminder);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Reminder")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Select Day'),
              value: selectedDay,
              items: days.map((day) => DropdownMenuItem(value: day, child: Text(day))).toList(),
              onChanged: (value) => setState(() => selectedDay = value),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(selectedTime == null ? "No Time Selected" : "Time: ${selectedTime!.format(context)}"),
                const Spacer(),
                ElevatedButton(onPressed: _pickTime, child: const Text("Pick Time")),
              ],
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Select Activity'),
              value: selectedActivity,
              items: activities.map((activity) => DropdownMenuItem(value: activity, child: Text(activity))).toList(),
              onChanged: (value) => setState(() => selectedActivity = value),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: _saveReminder,
              icon: const Icon(Icons.save),
              label: const Text("Save Reminder"),
            )
          ],
        ),
      ),
    );
  }
}

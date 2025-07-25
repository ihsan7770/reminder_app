import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import '../models/reminder_model.dart';
import '../widgets/reminder_list.dart';
import 'add_reminder_screen.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});
  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  List<ReminderModel> reminders = [];
  late final AudioPlayer _audioPlayer;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _startCheckingTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _navigateToAddReminder() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddReminderScreen()),
    );
    if (result != null && result is ReminderModel) {
      setState(() => reminders.add(result));
    }
  }

  void _startCheckingTime() {
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      final now = DateTime.now();
      final currentDay = _getDayFromWeekday(now.weekday);
      final currentTime = TimeOfDay.fromDateTime(now);

      for (final reminder in reminders) {
        if (reminder.day == currentDay &&
            reminder.time == currentTime.format(context)) {
          _playChime();
        }
      }
    });
  }

  String _getDayFromWeekday(int weekday) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[weekday - 1];
  }

  void _playChime() async {
    try {
      await _audioPlayer.play(AssetSource('chime.mp3'));
    } catch (e) {
      debugPrint("Error playing chime: \$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Reminders')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ReminderList(reminders: reminders),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddReminder,
        child: const Icon(Icons.add),
      ),
    );
  }
}

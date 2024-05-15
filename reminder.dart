import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReminderPage(),
    );
  }
}

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  String selectedDay = 'Monday';
  TimeOfDay selectedTime = TimeOfDay(hour: 0, minute: 0);
  String selectedActivity = 'Wake up';
   // AudioCache player = AudioCache();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Reminder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedDay,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDay = newValue!;
                });
              },
              items: <String>['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            DropdownButton<TimeOfDay>(
              value: selectedTime,
              onChanged: (TimeOfDay? newValue) {
                setState(() {
                  selectedTime = newValue!;
                });
              },
              items: List<DropdownMenuItem<TimeOfDay>>.generate(
                24 * 4, // assuming a dropdown for every 15 minutes
                    (int index) {
                  int hour = index ~/ 4;
                  int minute = (index % 4) * 15;
                  return DropdownMenuItem<TimeOfDay>(
                    value: TimeOfDay(hour: hour, minute: minute),
                    child: Text('${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}'),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedActivity,
              onChanged: (String? newValue) {
                setState(() {
                  selectedActivity = newValue!;
                });
              },
              items: <String>['Wake up', 'Go to gym', 'Breakfast', 'Meetings', 'Lunch', 'Quick nap', 'Go to library', 'Dinner', 'Go to sleep']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                scheduleReminder();
              },
              child: Text('Set Reminder'),
            ),
          ],
        ),
      ),
    );
  }

  void scheduleReminder() {
    TimeOfDay now = TimeOfDay.now();
    TimeOfDay selected = selectedTime;
    DateTime scheduledDateTime = DateTime.now().add(Duration(
      days: ((DateTime.parse('2024-05-14').weekday - DateTime.now().weekday + 7) % 7), // Calculate the difference between today and selected day
      hours: selected.hour - now.hour,
      minutes: selected.minute - now.minute,
    ));

    final int scheduledTimeInMilliseconds = scheduledDateTime.millisecondsSinceEpoch;

    const alarmAudioPath = "assets/sounds/alarm.mp3";

     // player.play(alarmAudioPath);

    print('Reminder scheduled for: ${selectedDay}, ${selectedTime.format(context)}, ${selectedActivity}');
    print('Scheduled Time: ${scheduledDateTime.toString()}');
    print('Scheduled Time in milliseconds: ${scheduledTimeInMilliseconds}');
  }
}

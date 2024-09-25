import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/notification_helper.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isReminderEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadReminderSetting();
  }

  _loadReminderSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isReminderEnabled = prefs.getBool('reminder') ?? false;
    });
  }

  _toggleReminder(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isReminderEnabled = value;
      prefs.setBool('reminder', value);
      if (value) {
        // Schedule notification
        NotificationService.showDailyNotification(
            0, 'Daily Reminder', 'Check out a random restaurant!');
      } else {
        // Cancel notification if needed
        NotificationService.cancelNotification(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: SwitchListTile(
        title: Text('Enable Daily Reminder'),
        value: _isReminderEnabled,
        onChanged: _toggleReminder,
      ),
    );
  }
}

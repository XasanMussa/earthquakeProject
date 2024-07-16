import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'blue_card_widget.dart';
import 'databaseHelper.dart';

class NotificationListPage extends StatefulWidget {
  @override
  _NotificationListPageState createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  List<Map<String, String>> notifications = [];
  DatabaseReference alertRef = FirebaseDatabase.instance.ref().child("/alert");
  bool _isWaiting = false;
  String? _lastAlertMessage;
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  void _clearNotifications() async {
    setState(() {
      notifications.clear();
    });
    await _databaseHelper.clearNotifications();
  }

  @override
  void initState() {
    super.initState();
    _loadNotifications();
    _setupListener();
  }

  void _loadNotifications() async {
    final savedNotifications = await _databaseHelper.getNotifications();
    setState(() {
      notifications = savedNotifications.map((notification) {
        return {
          'title': notification['title'] as String,
          'subtitle': notification['subtitle'] as String,
          'details': notification['details'] as String,
          'date': notification['date'] as String,
        };
      }).toList();
    });
  }

  void _setupListener() {
    alertRef.onValue.listen((event) async {
      String alertMessage = event.snapshot.value.toString();
      if (alertMessage == "no significant movement")
        return; // Skip this message

      if (alertMessage == "EARTHQUAKE HAPPENING!") {
        if (!_isWaiting) {
          final notification = {
            'title': 'Alert',
            'subtitle': alertMessage,
            'details': alertMessage,
            'date': DateTime.now().toString(),
          };

          setState(() {
            notifications.add(notification);
            _lastAlertMessage = alertMessage;
            _isWaiting = true;
          });

          await _databaseHelper.insertNotification(notification);

          await Future.delayed(Duration(seconds: 10));
          setState(() {
            _isWaiting = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 56, 70, 230),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Notification List',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: _clearNotifications,
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: BlueCardWidget(
                text: notifications[index]['details']!,
                date: notifications[index]['date']!,
              ),
            );
          },
        ),
      ),
    );
  }

  void _showNotificationDetails(BuildContext context, String details) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification Details'),
          content: Text(details),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

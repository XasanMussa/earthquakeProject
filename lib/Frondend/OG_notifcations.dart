import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'blue_card_widget.dart';

class NotificationListPage extends StatefulWidget {
  @override
  _NotificationListPageState createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  List<Map<String, String>> notifications = [];
  DatabaseReference alertRef = FirebaseDatabase.instance.ref().child("/alert");
  bool _isWaiting = false;
  String? _lastAlertMessage;

  void _clearNotifications() {
    setState(() {
      notifications.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _setupListener();
  }

  void _setupListener() {
    alertRef.onValue.listen((event) async {
      String alertMessage = event.snapshot.value.toString();
      if (alertMessage == "no significant movement")
        return; // Skip this message

      if (alertMessage == "EARTHQUAKE HAPPENING!") {
        if (!_isWaiting) {
          setState(() {
            notifications.add({
              'title': 'Alert',
              'subtitle': alertMessage,
              'details': alertMessage,
              'date': DateTime.now().toString(),
            });
            _lastAlertMessage = alertMessage;
            _isWaiting = true;
          });

          await Future.delayed(Duration(seconds: 10));
          setState(() {
            _isWaiting = false;
          });
        }
      } else if (alertMessage == "EARTHQUAKE HAPPENING!" &&
          (_lastAlertMessage != alertMessage)) {
        setState(() {
          notifications.add({
            'title': 'Alert',
            'subtitle': alertMessage,
            'details': alertMessage,
            'date': DateTime.now().toString(),
          });
          _lastAlertMessage = alertMessage;
        });
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
      body: StreamBuilder(
        stream: alertRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            String alertMessage = snapshot.data!.snapshot.value.toString();
            if (alertMessage == "no significant movement")
              return Container(); // Skip this message

            if (!_isWaiting || _lastAlertMessage != alertMessage) {
              if (alertMessage == "EARTHQUAKE HAPPENING!") {
                if (!_isWaiting) {
                  notifications.add({
                    'title': 'Alert',
                    'subtitle': alertMessage,
                    'details': alertMessage,
                    'date': DateTime.now().toString(),
                  });
                  _lastAlertMessage = alertMessage;
                  _isWaiting = true;
                  Future.delayed(Duration(seconds: 10)).then((_) {
                    setState(() {
                      _isWaiting = false;
                    });
                  });
                }
              }
            }
          }

          return Container(
            color: Colors
                .white, // Set the background color of the ListView to white
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
          );
        },
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

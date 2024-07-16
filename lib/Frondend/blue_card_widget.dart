import 'package:flutter/material.dart';

class BlueCardWidget extends StatelessWidget {
  final String text;
  final String date;

  BlueCardWidget({required this.text, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              date,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

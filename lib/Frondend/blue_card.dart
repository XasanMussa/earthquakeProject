import 'package:flutter/material.dart';

class BlueCardWidget extends StatelessWidget {
  final String text;

  BlueCardWidget({required this.text});

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
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

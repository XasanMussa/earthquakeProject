import 'package:flutter/material.dart';

class EarthquakeReportPage extends StatelessWidget {
  final List<Map<String, String>> earthquakeReports = [
    {
      'location': 'California, USA',
      'magnitude': '4.5',
      'details': 'An earthquake of magnitude 4.5 occurred in California, USA.',
      'date': '2024-06-12'
    },
    {
      'location': 'Tokyo, Japan',
      'magnitude': '5.0',
      'details': 'An earthquake of magnitude 5.0 occurred in Tokyo, Japan.',
      'date': '2024-06-11'
    },
    {
      'location': 'Jakarta, Indonesia',
      'magnitude': '6.0',
      'details': 'An earthquake of magnitude 6.0 occurred in Jakarta, Indonesia.',
      'date': '2024-06-10'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: ListView.builder(
          itemCount: earthquakeReports.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(10.0),
              child: ListTile(
                leading: Icon(Icons.public),
                title: Text(earthquakeReports[index]['location']!),
                subtitle: Text('Magnitude: ${earthquakeReports[index]['magnitude']}'),
                trailing: Text(earthquakeReports[index]['date']!),
                onTap: () {
                  _showEarthquakeDetails(
                    context,
                    earthquakeReports[index]['location']!,
                    earthquakeReports[index]['details']!,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _showEarthquakeDetails(BuildContext context, String location, String details) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Details for $location'),
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

import 'package:earthquake_app/Frondend/Dashboard.dart';
import 'package:earthquake_app/Frondend/MapPage.dart';
// import 'package:earthquake_app/Frondend/Report.dart';
import 'package:earthquake_app/Frondend/Settings/Profile.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final items = [
    SalomonBottomBarItem(
        icon: Icon(
          Icons.home,
          size: 35,
          color: Colors.indigo.shade900,
        ),
        title: Text(
          'Home',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900),
        )),
    SalomonBottomBarItem(
        icon: Icon(
          Icons.location_on,
          size: 35,
          color: Colors.indigo.shade900,
        ),
        title: Text(
          'Map',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900),
        )),
    SalomonBottomBarItem(
        icon: Icon(
          Icons.report,
          size: 35,
          color: Colors.indigo.shade900,
        ),
        title: Text(
          'Report',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900),
        )),
    SalomonBottomBarItem(
      icon: Icon(
        Icons.person_pin,
        size: 35,
        color: Colors.indigo.shade900,
      ),
      title: Text(
        'Profile',
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900),
      ),
    ),
  ];

  final _screen = [Dashboard(), MapPage(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: _screen[_currentIndex],
      bottomNavigationBar: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 8,
        margin: EdgeInsets.all(16.0),
        child: SalomonBottomBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.white10,
          items: items,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
        ),
      ),
    );
  }
}

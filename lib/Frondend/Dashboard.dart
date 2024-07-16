import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:earthquake_app/Frondend/Notification.dart';
import 'package:flutter/material.dart';
import "blue_card.dart";
import 'package:firebase_database/firebase_database.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String alertMessage = "";
  String x = "";
  double xvalue = 0;
  String y = "";
  double yvalue = 0;
  double zvalue = 0;
  String z = "";
  DatabaseReference alertRef = FirebaseDatabase.instance.ref().child("/alert");
  DatabaseReference xvalueRef =
      FirebaseDatabase.instance.ref().child("/sensorrs/xvalue");
  DatabaseReference zvalueRef =
      FirebaseDatabase.instance.ref().child("/sensorrs/zvalue");
  DatabaseReference yvalueRef =
      FirebaseDatabase.instance.ref().child("/sensorrs/yvalue");

  @override
  Widget build(BuildContext context) {
    alertRef.onValue.listen((Event) {
      setState(() {
        alertMessage = Event.snapshot.value.toString();
      });
    });
    xvalueRef.onValue.listen((Event) {
      setState(() {
        x = Event.snapshot.value.toString();
        xvalue = double.parse(x);
        // xvalue = (xvalue / 2000) * 100;
      });
    });
    yvalueRef.onValue.listen((Event) {
      setState(() {
        y = Event.snapshot.value.toString();
        yvalue = double.parse(y);
        // yvalue = (yvalue / 2000) * 100;
      });
    });
    zvalueRef.onValue.listen((Event) {
      setState(() {
        z = Event.snapshot.value.toString();
        zvalue = double.parse(z);
        // yvalue = (yvalue / 2000) * 100;
      });
    });
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Earthquake app',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => NotificationListPage()));
                  },
                  child: Icon(
                    Icons.notification_add_rounded,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 3,
                ),

                //present the x-value from the firebase in this progreess bar
                Column(
                  children: [
                    Text(
                      "VIBRATION DETECTOR",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Padding(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: DashedCircularProgressBar.aspectRatio(
                              aspectRatio: 2, // width ÷ height
                              // progress: 100,  //100 ayee ahayd marki koowaad
                              progress:
                                  alertMessage == "No significant movement"
                                      ? 0
                                      : 100, //test wye tan
                              startAngle: 270,
                              sweepAngle: 180,
                              circleCenterAlignment: Alignment.bottomCenter,
                              foregroundColor: Color.fromARGB(255, 97, 235, 6),
                              backgroundColor: const Color(0xffeeeeee),
                              foregroundStrokeWidth: 24,
                              backgroundStrokeWidth: 2,
                              backgroundGapSize: 2,
                              backgroundDashSize: 1,
                              seekColor: Color.fromARGB(255, 165, 44, 44),
                              seekSize: 25,
                              animation: true,
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),

                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "X-VALUE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Padding(
                              padding: const EdgeInsets.only(left: 3, right: 3),
                              child: DashedCircularProgressBar.aspectRatio(
                                aspectRatio: 2, // width ÷ height
                                progress: xvalue,

                                startAngle: 270,
                                sweepAngle: 180,
                                circleCenterAlignment: Alignment.bottomCenter,
                                foregroundColor: Colors.indigo.shade900,
                                backgroundColor: const Color(0xffeeeeee),
                                foregroundStrokeWidth: 24,
                                backgroundStrokeWidth: 2,
                                backgroundGapSize: 2,
                                backgroundDashSize: 1,
                                seekColor: Colors.white,
                                seekSize: 25,
                                animation: true,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 3,
                ),

                //present the x-value from the firebase in this progreess bar
                Column(
                  children: [
                    Text(
                      "Y-VALUE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Padding(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: DashedCircularProgressBar.aspectRatio(
                              aspectRatio: 2, // width ÷ height
                              // progress: 100,  //100 ayee ahayd marki koowaad
                              progress: yvalue,
                              //test wye tan
                              startAngle: 270,
                              sweepAngle: 180,
                              circleCenterAlignment: Alignment.bottomCenter,
                              foregroundColor: Colors.indigo.shade900,
                              backgroundColor: const Color(0xffeeeeee),
                              foregroundStrokeWidth: 24,
                              backgroundStrokeWidth: 2,
                              backgroundGapSize: 2,
                              backgroundDashSize: 1,
                              seekColor: Colors.white,
                              seekSize: 25,
                              animation: true,
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),

                //present the y-value from the firebase in this progress bar
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Z-VALUE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Padding(
                              padding: const EdgeInsets.only(left: 3, right: 3),
                              child: DashedCircularProgressBar.aspectRatio(
                                aspectRatio: 2, // width ÷ height
                                progress: zvalue,

                                startAngle: 270,
                                sweepAngle: 180,
                                circleCenterAlignment: Alignment.bottomCenter,
                                foregroundColor: Colors.indigo.shade900,
                                backgroundColor: const Color(0xffeeeeee),
                                foregroundStrokeWidth: 24,
                                backgroundStrokeWidth: 2,
                                backgroundGapSize: 2,
                                backgroundDashSize: 1,
                                seekColor: Colors.white,
                                seekSize: 25,
                                animation: true,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

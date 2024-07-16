import 'package:earthquake_app/Frondend/Notification.dart';
import 'package:earthquake_app/Frondend/Users/LoadingScreen.dart';
import 'package:earthquake_app/Frondend/Users/SignIn.dart';
import 'package:earthquake_app/Frondend/Users/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:earthquake_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyC2RUNbbFXtPf9HKekkynaX8o-yResMuZ0",
          appId: "1:934000879271:android:d5eb288f8e1d9677771d82",
          messagingSenderId: "earth-36cd1",
          projectId: "earth-36cd1",
          storageBucket: "gs://earth-36cd1.appspot.com/images"));

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.indigo.shade900));
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loading(),
    );
  }
}

import 'package:earthquake_app/Frondend/Users/SignIn.dart';
import 'package:earthquake_app/Frondend/Users/SignUp.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: ListView(
        children: [
          SizedBox(height: 250,),
          Center(
            child: Text('Earthquake',style: TextStyle(fontSize: 35,color: Colors.white70,
                fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 200,),
          Column(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
               GestureDetector(
                 onTap: ()  {
                   Navigator.push(context, MaterialPageRoute(builder: (_) =>
                       SignIn()));
                 },
                 child: Container(
                   width: double.infinity,
                   decoration:  BoxDecoration(
                       color: Colors.indigo.shade100,
                       borderRadius: BorderRadius.all(Radius.circular(15))),
                   margin:  EdgeInsets.symmetric(horizontal: 20),
                   padding:  EdgeInsets.symmetric(vertical: 15),
                   child:  Center(
                       child: Text(
                         "Sign In",
                         style: TextStyle(fontSize: 21, color: Colors.indigo.shade900,
                             fontWeight: FontWeight.bold),
                       )),
                 ),
               ),
               SizedBox(
                 height: 25,
               ),
               GestureDetector(
                 onTap: ()  {
                   Navigator.push(context, MaterialPageRoute(builder: (_) =>
                       SignUp()));
                 },
                 child: Container(
                   width: double.infinity,
                   decoration:  BoxDecoration(
                       color: Colors.indigo.shade100,
                       borderRadius: BorderRadius.all(Radius.circular(15))),
                   margin:  EdgeInsets.symmetric(horizontal: 20),
                   padding:  EdgeInsets.symmetric(vertical: 15),
                   child:  Center(
                       child: Text(
                         "Sign Up",
                         style: TextStyle(fontSize: 21, color: Colors.indigo.shade900,
                             fontWeight: FontWeight.bold),
                       )),
                 ),
               ),
             ],
           )
        ],
      ),
    );
  }
}

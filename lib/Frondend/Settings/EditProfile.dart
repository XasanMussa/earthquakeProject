import 'package:earthquake_app/Frondend/Settings/Profile.dart';
import 'package:earthquake_app/Frondend/Users/LoadingScreen.dart';
import 'package:earthquake_app/Frondend/Users/SignIn.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isHidden = true;


  clearFields(){
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade900,
                    borderRadius: BorderRadius.only(
                      // topRight: Radius.circular(10),
                        bottomRight: Radius.circular(200)
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_circle_left_outlined,
                      color: Colors.indigo.shade900, size: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade900),
                  ),
                ),
                Container(
                  width: 50,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade900,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200),
                      bottomLeft: Radius.circular(200),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('images/profile.jpeg'),
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                  Positioned(
                    top: 70,
                    left: 60,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.indigo.shade900,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.camera_alt_outlined,color: Colors.white,size: 25,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Name",
                    prefixIcon: Icon(
                      Icons.drive_file_rename_outline_rounded,
                      color: Colors.indigo,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.indigo, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Phone No",
                    prefixIcon: Icon(
                      Icons.phone_callback,
                      color: Colors.indigo,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.indigo, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "E-mail",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.indigo,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.indigo, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _passwordController,
                obscureText: isHidden,
                decoration: InputDecoration(
                  hintText: "********",
                  prefixIcon:  Icon(
                    Icons.fingerprint_rounded,
                    color: Colors.indigo.shade900,
                    size: 30,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                    icon: Icon(
                      isHidden ? Icons.visibility_off : Icons.visibility,
                      color: Colors.indigo,
                    ),
                  ),
                  border:  OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  focusedBorder:  OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo, width: 2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: ()  {
                Navigator.push(context, MaterialPageRoute(builder: (_) =>
                    EditProfile()));
              },
              child: Container(
                width: double.infinity,
                decoration:  BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                margin:  EdgeInsets.symmetric(horizontal: 20),
                padding:  EdgeInsets.symmetric(vertical: 15),
                child:  Center(
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding:  EdgeInsets.only(right: 20,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text("Joined 26 April 2024",style: TextStyle(fontSize: 19,
                        color: Colors.indigo.shade900),),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>  SignUp()));
                    },
                    child:  Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.indigo.shade900
                      ),
                      child: Padding(
                        padding:  EdgeInsets.only(left: 33.0,top: 7),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    child: AlertDialog(
                                      title: Text('Do you want to Delete Account?', style: TextStyle(color: Colors.grey,
                                          fontSize: 20),),
                                      actions: [
                                        TextButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          child: Text('No', style: TextStyle(color: Colors.black,
                                              fontSize: 20),),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                                Loading()));
                                          },
                                          child: Text('Yes', style: TextStyle(color: Colors.indigo.shade900,
                                              fontSize: 20),),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            );
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

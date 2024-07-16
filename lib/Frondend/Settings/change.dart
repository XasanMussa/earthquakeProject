import 'package:earthquake_app/Frondend/Settings/Profile.dart';
import 'package:flutter/material.dart';

class Changing extends StatefulWidget {
  const Changing({super.key});

  @override
  State<Changing> createState() => _ChangingState();
}

class _ChangingState extends State<Changing> {
  TextEditingController _oldController = TextEditingController();
  TextEditingController _newController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();
  bool isHidden = true;

  clearFields() {
    _oldController.clear();
    _newController.clear();
    _confirmController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade900,
                    borderRadius: BorderRadius.only(
                        // topRight: Radius.circular(10),
                        bottomRight: Radius.circular(200)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 80.0),
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade900),
                  ),
                ),
                Container(
                  width: 50,
                  height: 90,
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
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _newController,
                obscureText: isHidden,
                decoration: InputDecoration(
                  hintText: "Old Password",
                  prefixIcon: Icon(
                    Icons.vpn_key,
                    color: Colors.indigo,
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
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo, width: 2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _newController,
                obscureText: isHidden,
                decoration: InputDecoration(
                  hintText: "New Password",
                  prefixIcon: Icon(
                    Icons.vpn_key,
                    color: Colors.indigo,
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
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo, width: 2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _newController,
                obscureText: isHidden,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  prefixIcon: Icon(
                    Icons.vpn_key,
                    color: Colors.indigo,
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
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo, width: 2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Profile()));
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Center(
                    child: Text(
                  "Changed",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_circle_left_outlined,
                    size: 35,
                    color: Colors.indigo.shade900,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

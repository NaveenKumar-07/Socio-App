import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sociologin/AuthService.dart';
import 'Login_Screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.purple,
          title: Padding(
            padding: EdgeInsets.only(left: 30.0, top: 5),
            child: Text('Welcome ' + _auth.currentUser.displayName,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0)),
          ),
          titleSpacing: 2.0,
          shadowColor: Colors.pink,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg5.jpg'),
                  fit: BoxFit.fill)),
          child: SafeArea(
            child: Center(
              child: Container(
                padding: EdgeInsets.only(top: 90, bottom: 90),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    CircleAvatar(
                      radius: 70.0,
                      backgroundColor: Colors.blue,
                      backgroundImage: NetworkImage(_auth.currentUser.photoURL),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                        child: Column(
                      children: [
                        Text(
                          _auth.currentUser.displayName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          _auth.currentUser.email,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    )),
                    SizedBox(height: 40),
                    SizedBox(
                      height: 50,
                      width: 120,
                      child: RaisedButton(
                          color: Colors.red,
                          splashColor: Colors.blueGrey,
                          textColor: Colors.black,
                          shape: StadiumBorder(),
                          focusElevation: 20,
                          child: Text(
                            'Sign Out',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          onPressed: () async {
                            await AuthService().logout();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

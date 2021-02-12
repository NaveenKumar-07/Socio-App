import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sociologin/Login_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigateToLogin();
    super.initState();
  }

  _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 4), () {}).whenComplete(() =>
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg4.jpg'), fit: BoxFit.fill)),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Shimmer.fromColors(
            period: Duration(seconds: 4),
            baseColor: Color(0xff1E90FF),
            highlightColor: Color(0xffD2691E),
            child: Container(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "SOCIO APP",
                    style: TextStyle(
                        fontFamily: 'Caveat',
                        fontSize: 75.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.0,
                        shadows: <Shadow>[
                          Shadow(
                              blurRadius: 13.0,
                              color: Colors.white70,
                              offset: Offset.fromDirection(120, 12))
                        ]),
                  ),
                )),
          ),
          Container(
              padding: EdgeInsets.only(left: 200, top: 250),
              child: Text('By Naveen Kumar',
                  style: TextStyle(
                      fontFamily: 'Sansita',
                      color: Colors.white60,
                      fontSize: 22)))
        ],
      ),
    ));
  }
}

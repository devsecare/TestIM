import 'package:chrisandsons/constants/constants.dart';
import 'package:chrisandsons/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    
    super.initState();
    Future.delayed(Duration(seconds: 8), () {
      Get.offAll(() => Home());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Center(child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Image.asset(splashScreen, fit: BoxFit.fitWidth,
            width: 250,),
          )),
        ),
      ),
    );
  }
}

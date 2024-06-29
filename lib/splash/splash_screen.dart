import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:slrapp/custom/themes.dart';
import 'package:slrapp/extention/string_extention.dart';
import 'package:slrapp/prefs/store.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
   @override
void initState() {
  super.initState();
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..contentPadding = EdgeInsets.all(0)
    ..indicatorWidget = Container()
    ..indicatorColor = themeColor // Set loading indicator color
    ..backgroundColor = Colors.transparent // Set background color to transparent
    ..textColor = themeColor // Set text color if needed
    ..maskColor = Colors.transparent; // Set mask color to transparent
}
// Set mask color to transparent
// Set mask color to transparent
    Timer(Duration(milliseconds: 1800), () { 
      navigation(context: context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:themeColor ,
      body: Center(
        child: SizedBox(
          width: 130,
          child: FadeIn(
            duration: Duration(milliseconds: 1200),
            child: Image.asset('logo.png'.imagePath))),
      ),
    );
  }
}
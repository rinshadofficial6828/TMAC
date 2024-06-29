import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slrapp/features/auth/view/login_screen.dart';
import 'package:slrapp/features/main/view/user_screen.dart';

storeUsername({required String username}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user', username);
}

storeuserId({required int id}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('userId', id);
}

StoreMessage({required String message}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('message', message);
}

navigation({required BuildContext context}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? name = prefs.getString('user');
  String? message = prefs.getString('message');

  if (name != null || message != null) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => UserScreen()));
  } else {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}

removeToken({required BuildContext context}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? name = prefs.getString('user');
  String? message = prefs.getString('message');
  int? id = prefs.getInt('userId');
if(name!=null || message != null || id !=null){
  prefs.remove('userId');
  prefs.remove('message');
  prefs.remove('user');
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
builder: (context) => LoginScreen()), (Route route)=>false);
}

}

import 'package:flutter/material.dart';
import 'package:slrapp/prefs/store.dart';

showLogout({required BuildContext context}){
  return  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout ?'),
          content: Text(" Are you sure to logout ?"),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                removeToken(context: context);
              },
            ),
          ],
        );
      },
    );
}
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:slrapp/custom/fonts.dart';
import 'package:slrapp/custom/themes.dart';

loadingPopUp(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    barrierColor: Colors.transparent, // Set the barrierColor to transparent
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        content: spinKits(colors: themeColor),
      );
    },
  );
}

  void closeLoadingPopUp(BuildContext context) {
  Navigator.of(context).pop();
}

Widget spinKits({required Color colors}) {
  return SpinKitCircle(
  color: colors,
  size: 60.0,
);
}

PendingPopUP(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40,bottom: 10),
            child: Column(
              children: [
                SpinKitPouringHourGlassRefined(
                  size: 80,
                  color: Colors.red),
                SizedBox(height: 20,),
                Text("Waiting for Admin Approvel",style: normalFonts(13, themeColor, FontWeight.bold),),
                SizedBox(height: 16,),
                MaterialButton(
                  color: themeColor,
                  child: Text("OK",style: normalFonts(12, Colors.white, FontWeight.w500),),
                  onPressed: (){
                  Navigator.pop(context);
                })
              ],
            ),
          ),
        ),
      );
    },
  );
}
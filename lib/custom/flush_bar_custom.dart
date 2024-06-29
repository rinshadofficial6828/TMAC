import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

customFlushBar ({required BuildContext context,required String message,required Color color}){
  return  Flushbar(
                        backgroundColor: color,
                        borderRadius: BorderRadius.circular(6),
                        margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                  message:  message,
                  duration:  Duration(seconds: 2),
                )..show(context);
}
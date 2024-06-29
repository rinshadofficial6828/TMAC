import 'package:flutter/material.dart';
import 'package:slrapp/custom/fonts.dart';
import 'package:slrapp/custom/themes.dart';

customButton({required String text,required VoidCallback onTap}){
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: themeColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16,bottom: 16),
        child: Center(child: Text(text,style: normalFonts(16, Colors.white,FontWeight.bold),)),
      ),
    ),
  );
}
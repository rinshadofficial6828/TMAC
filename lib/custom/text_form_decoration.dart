import 'package:flutter/material.dart';

InputDecoration emailField ({required String hintText,required String labelText,required IconData? data}){
  return InputDecoration(
                      suffixIcon: Icon(data),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      hintText: hintText,
                      labelText: labelText
                    );
}

InputDecoration Phonenumberfield ({
  required String hintText,
  required String labelText,
  required IconData? data,
}) {
  return InputDecoration(
    // prefixText: countryCode, // Set the prefix text to the country code
    suffixIcon: Icon(data),
    prefix: Text("+91 "),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    hintText: hintText,
    labelText: labelText,
  ); 
}

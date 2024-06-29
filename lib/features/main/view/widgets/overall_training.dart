import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slrapp/custom/fonts.dart';
import 'package:slrapp/custom/themes.dart';
import 'package:slrapp/features/main/viewmodel/user_view_model.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

overAlltraining({required BuildContext context}){
  final allTrainingViewModel = Provider.of<UserViewModel>(context,listen: false);
  return Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: themeGreen
        ),
        child: Column(children: [
          Text("Overall Training Coefficient (OTC)",style: normalFonts(15, Colors.black, FontWeight.bold),),
          SizedBox(height: 20,),
          Container(
            alignment: Alignment.topRight,
            child: Text(allTrainingViewModel.mainPercentage,style: normalFonts(12, Colors.black, FontWeight.w900),)),
          StepProgressIndicator(
    totalSteps: 100,
    currentStep: allTrainingViewModel.percentageValue,
    size: 8,
    padding: 0,
    selectedColor: allTrainingViewModel.percentageValue > 95 ?Colors.green :Colors.red,
    unselectedColor: Colors.grey,
    roundedEdges: Radius.circular(10),
),
        ],),
      );
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slrapp/custom/fonts.dart';
import 'package:slrapp/custom/themes.dart';
import 'package:slrapp/features/auth/model/get_crews_model.dart';
import 'package:slrapp/features/auth/model/project_model.dart';
import 'package:slrapp/features/auth/viewmodel/auth_view_model.dart';

Future<void> showPopUpCustom({required BuildContext context, required List<GetCrewsModel> crew}) async {
  final addInformationViewmodel = Provider.of<Authviewmodel>(context,listen: false);
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title:  Text('Select Company',style: normalFonts(25, themeColor, FontWeight.bold,), textAlign: TextAlign.center,),
        content: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  separatorBuilder: (context, index){
                    return SizedBox(height: 12,);
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: crew.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Text(crew[index].name ?? "",style: normalFonts(15, Colors.black, FontWeight.w600),textAlign: TextAlign.center,),
                      onTap: () {
                        addInformationViewmodel.designationController.text = "";
                        addInformationViewmodel.selectedCrew = crew[index].name ?? "";
                        addInformationViewmodel.companyId = crew[index].id ?? 0;
                        addInformationViewmodel.crewController.text = crew[index].name ?? "";
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                SizedBox(height: 12,),
                TextButton(
            child:  Text('Close',style:normalFonts(15, themeColor, FontWeight.bold) ,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


//select rig 

Future<void> showPopUpRig({required BuildContext context, required List<String> rig}) async {
  final addInformationViewmodel = Provider.of<Authviewmodel>(context,listen: false);
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title:  Text('Select Rig',style: normalFonts(25, themeColor, FontWeight.bold,), textAlign: TextAlign.center,),
        content: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  separatorBuilder: (context, index){
                    return SizedBox(height: 12,);
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: rig.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Text(rig[index] ?? "",style: normalFonts(15, Colors.black, FontWeight.w600),textAlign: TextAlign.center,),
                      onTap: () {
                       addInformationViewmodel.rigController.text = rig[index] ?? ""; 
                        Navigator.pop(context);
                        
                      },
                    );
                  },
                ),
                SizedBox(height: 12,),
                TextButton(
            child:  Text('Close',style:normalFonts(15, themeColor, FontWeight.bold) ,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

//============select project========/
Future<void> selectProject({required BuildContext context, required List<ProjectModelResponse> projects}) async {
  final addInformationViewmodel = Provider.of<Authviewmodel>(context,listen: false);
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title:  Text('Select Projects',style: normalFonts(25, themeColor, FontWeight.bold,), textAlign: TextAlign.center,),
        content: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  separatorBuilder: (context, index){
                    return SizedBox(height: 12,);
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Text(projects[index].name ?? "",style: normalFonts(15, Colors.black, FontWeight.w600),textAlign: TextAlign.center,),
                      onTap: () {
                        addInformationViewmodel.ProjectId = projects[index].id ?? 0;
                       addInformationViewmodel.projectController.text = projects[index].name ?? ""; 
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                SizedBox(height: 12,),
                TextButton(
            child:  Text('Close',style:normalFonts(15, themeColor, FontWeight.bold) ,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
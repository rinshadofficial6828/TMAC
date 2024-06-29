import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slrapp/custom/fonts.dart';
import 'package:slrapp/custom/pop_up_spinkits.dart';
import 'package:slrapp/custom/themes.dart';
import 'package:slrapp/features/main/view/widgets/bottom_sheet.dart';
import 'package:slrapp/features/main/view/widgets/overall_training.dart';
import 'package:slrapp/features/main/view/widgets/profile.dart';
import 'package:slrapp/features/main/viewmodel/user_view_model.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    initilizeAll();
  }

  initilizeAll() {
    final userViewmodel = Provider.of<UserViewModel>(context,listen: false);
    userViewmodel.getuserInfo();
    userViewmodel.getMaintrainings();
    userViewmodel.forPercentage();
  }
  @override
  Widget build(BuildContext context) {
  final userViewmodel = Provider.of<UserViewModel>(context);
    return Scaffold(
      backgroundColor: themelite,
      body: RefreshIndicator(
        backgroundColor: themeColor,
        color: Colors.white,
        onRefresh: () async{

        await Future.delayed(Duration(seconds: 3));
        initilizeAll();
         
        },
        child:
        userViewmodel.isLoading ? Center(child: spinKits(colors: themeColor),):
         ListView(children: [
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: UserProfileDetails()
        ),
        SizedBox(height: 20,),
        overAlltraining(context: context),
        SizedBox(height: 20,),
        Container(
          height: MediaQuery.of(context).size.width * 1.22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(12)),
            color: Colors.white,
          ),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(height: 20,);
            },
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: userViewmodel.mainTrainings.length,
            itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
              child: InkWell(
                onTap: (){
                  userViewmodel.subTrainings.clear();
                  userViewmodel.submainperscentage = 0;
                  userViewmodel.SubdataPercentage = "";
                  setState(() {
                    userViewmodel.percentageId  = userViewmodel.mainTrainings[index].id ?? 0;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SubTrainingDetails( maintext: userViewmodel.mainTrainings[index].name ?? "",)));
                  });
                  
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Text(userViewmodel.mainTrainings[index].name ??"" ,style: normalFonts(14, Colors.black, FontWeight.bold),),
                Icon(Icons.arrow_forward_ios_rounded)
                ],),
              ),
            );
          }) ,
          )
        ],),
      ),
    );
  }
}
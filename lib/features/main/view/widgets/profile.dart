import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:slrapp/custom/fonts.dart';
import 'package:slrapp/custom/pop_up_spinkits.dart';
import 'package:slrapp/custom/themes.dart';
import 'package:slrapp/extention/string_extention.dart';
import 'package:slrapp/features/main/view/user_profile_details.dart';
import 'package:slrapp/features/main/viewmodel/user_view_model.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class UserProfileDetails extends StatefulWidget {
  const UserProfileDetails({super.key});

  @override
  State<UserProfileDetails> createState() => _UserProfileDetailsState();
}

class _UserProfileDetailsState extends State<UserProfileDetails> {
  File? _image;
   @override
  void initState() {
    super.initState();
    final userViewmodel = Provider.of<UserViewModel>(context,listen: false);
    userViewmodel.getuserInfo();
  }
  Future<void> _pickImage() async {
    final userViewmodel = Provider.of<UserViewModel>(context,listen: false);
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        userViewmodel.userProfileupdate(img: pickedImage.path, context: context);
      } else {
        print('No image selected.');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final userViewmodel = Provider.of<UserViewModel>(context);
    return Row(
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                maxRadius: 45,
                backgroundColor: Colors.white,
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          _image!,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      )
                    :ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    userViewmodel.userInfo?.profilePhoto ?? "",
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return Image.asset(
                        'profile.png'.imagePath, // Path to your placeholder image
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                )
                
                          ),
                        ),
                        CircularStepProgressIndicator(
                          totalSteps: 100,
                          currentStep: userViewmodel.userInfo?.isAccepted == true ? 100 : 50,
                          stepSize: 1,
                          selectedColor: Colors.green,
                          unselectedColor: Colors.transparent,
                          padding: 0,
                          width: 100,
                          height: 100,
                          selectedStepSize: 6,
                          roundedCap: (_, __) => true,
                ),
                Positioned(
                      bottom: 2,
                      right: 1,
                      child: InkWell(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          minRadius: 12,
                          backgroundColor: themeColor,
                          child: Icon(Icons.edit,size:  15,color: Colors.white,)),
                      )),
                  ],
                ),
                SizedBox(height: 12,),
                InkWell(
                  onTap: (){
                    setState(() {
                      if (userViewmodel.userInfo != null) {
        userViewmodel.userInfo?.onDuty = !(userViewmodel.userInfo!.onDuty ?? false);
      }
      if(userViewmodel.userInfo?.onDuty == true){
        userViewmodel.toggleDuty(status: 'true', context: context);
      }else{
        userViewmodel.toggleDuty(status: 'false', context: context);
      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: userViewmodel.userInfo?.onDuty == true? Colors.green : Colors.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                      child: Text(userViewmodel.userInfo?.onDuty == true ?"On Duty" : "Off Duty",style: normalFonts(12, Colors.white, FontWeight.w600),),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 30,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                children: [
                  Text(userViewmodel.userInfo ?.fullname ?? "Name",style: normalFonts(15, Colors.black, FontWeight.bold),),
                  SizedBox(width: 12,),
                  InkWell(
                    onTap: (){
                      userViewmodel.userInfo?.isAccepted == false ? PendingPopUP(context):null;
                    },
                    child: CircleAvatar(
                      minRadius: 15,
                      backgroundColor: userViewmodel.userInfo?.isAccepted == true? Colors.green : Colors.red,
                      child: userViewmodel.userInfo?.isAccepted == true? Icon(Icons.check,color: Colors.white,size: 20,): Icon(Icons.timer_sharp,color: Colors.white,size: 20,),
                    ),
                  )
                ],
              ),
              SizedBox(height: 8,),
              Text(userViewmodel.userInfo?.designation ?? "Designation",style: normalFonts(10, Colors.black, FontWeight.w500),),
              SizedBox(height: 8,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> UserProfileDetailsScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: themeColor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                    child: Text("My Profile",style: normalFonts(12, Colors.white, FontWeight.w600),),
                  ),
                ),
              ),
              
              SizedBox(height: 30,)
            ],)          ],
        );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slrapp/custom/custom_login_button.dart';
import 'package:slrapp/custom/fonts.dart';
import 'package:slrapp/custom/pop_up_logut.dart';
import 'package:slrapp/features/main/viewmodel/user_view_model.dart';

class UserProfileDetailsScreen extends StatefulWidget {
  const UserProfileDetailsScreen({super.key});

  @override
  State<UserProfileDetailsScreen> createState() => _UserProfileDetailsScreenState();
}

class _UserProfileDetailsScreenState extends State<UserProfileDetailsScreen> {
  @override
  void initState() {
    final userViewModel = Provider.of<UserViewModel>(context,listen: false);
    userViewModel.getuserInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context,);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(),SizedBox(width: MediaQuery.of(context).size.width *.2,),
            Text("Training Records",style: normalFonts(16, Colors.black, FontWeight.w500,),),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 60,left: 20,right: 20),
        child: ListView(
          children: [ 
            customRow(keyText: "Gatepass No", valueText: userViewModel.userInfo?.gatePassNo ?? ""),
            customDivider(),
             customRow(keyText: "Company", valueText: userViewModel.userInfo?.company?.name ?? ""),
            customDivider(),
             customRow(keyText: "Project", valueText: userViewModel.userInfo?.project?.name ?? ""),
            customDivider(),
             customRow(keyText: "Rig Type", valueText: userViewModel.userInfo?.rigOrRigless ?? ""),
            customDivider(),
             customRow(keyText: "Designation", valueText: userViewModel.userInfo?.designation ?? ""),
             customDivider(),
             SizedBox(height: 30,),
             Padding(padding: EdgeInsets.symmetric(horizontal: 40),
             child: customButton(text: "Logout", onTap: (){
             showLogout(context: context);
             }),
             ),
             
          ],
        ),
      ),
    );
  }
}

customRow({required String keyText,required String valueText}){
 return Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
  Text(keyText,style: normalFonts(12, Colors.black, FontWeight.normal),),
  Text(valueText,style: normalFonts(12, Colors.black, FontWeight.normal),),
  ],
 );
}

customDivider(){
  return Padding(padding: EdgeInsets.only(top: 3,bottom: 2),
  child: Divider(
    thickness: .5,
    color: Colors.black,
    indent: 0,
    endIndent: 0,
  ),
  );
}
import 'package:flutter/material.dart';
import 'package:slrapp/custom/flush_bar_custom.dart';
import 'package:slrapp/custom/pop_up_spinkits.dart';
import 'package:slrapp/custom/themes.dart';
import 'package:slrapp/features/auth/model/get_crews_model.dart';
import 'package:slrapp/features/auth/model/get_desigation_by_crew.dart';
import 'package:slrapp/features/auth/model/project_model.dart';
import 'package:slrapp/features/auth/model/register_response_model.dart';
import 'package:slrapp/features/auth/repository/register_repository.dart';
import 'package:slrapp/features/main/view/user_screen.dart';
import 'package:slrapp/prefs/store.dart';

class Authviewmodel extends ChangeNotifier {
  AuthRepository authrepo = AuthRepository();
  List<GetCrewsModel> crewlist = [];
  List <String> rig = ["Rig","Rigless"];
 List <ProjectModelResponse> getAllProjects = [];
  List <GetDesignationsByCrewIdmodel> desiganations = [];
 int ProjectId = 0;
 int companyId = 0;
 String selectedCrew = "";
 TextEditingController crewController = TextEditingController();
 TextEditingController designationController = TextEditingController();
 TextEditingController rigController = TextEditingController();
 TextEditingController projectController = TextEditingController();
 bool isLoading = false;

  registerUser ({required RegisterresponseModel registerresponseModel,required BuildContext context}) async{
    loadingPopUp(context);
    await authrepo.registerUser(registerResponse: registerresponseModel).then((value) {
      if(value?.id !=null){
        closeLoadingPopUp(context);
        storeUsername(username: value?.fullname ?? "");
        storeuserId(id: value?.id ?? 0);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
builder: (context) => UserScreen()), (Route route)=>false);
       customFlushBar(context: context, message: "Register Success", color: themeColor);
      }else{
      closeLoadingPopUp(context);
      customFlushBar(context: context, message: "User with this phone number already exist", color: Colors.red);
      }
    });
    notifyListeners();
  }
  //take crews

  getAllcrews ()async{
    isLoading = true;
    await authrepo.getAllCrews().then((value) {
      if(value.isNotEmpty){
      crewlist = value;
      }else{
        isLoading = false;
      }
    });
    notifyListeners();
  }


  //login
  loginUser ({required String mobile,required String name,required BuildContext context}) async{
    loadingPopUp(context);
    await authrepo.userlogin(mobileNumber: mobile, fullName: name).then((value) {
      print(value);
      if(value?.status == true){
        closeLoadingPopUp(context);
        StoreMessage(message: value?.message ?? "");
        storeuserId(id: value?.data?.id ?? 0);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
builder: (context) => UserScreen()), (Route route)=>false);
       customFlushBar(context: context, message: "Login Success", color: themeColor);
      }else{
      closeLoadingPopUp(context);
      customFlushBar(context: context, message: "name or phone is inncorrect", color: Colors.red);
      }
    });
    notifyListeners();
  }
  //======================get all project==============
  Future<void> getProject() async {
    isLoading = true;
  List<ProjectModelResponse>? projects = await authrepo.getAllProject();
  if (projects != null) {
     isLoading = false;
    getAllProjects = projects;
  } else {
    isLoading = false;
    getAllProjects = [];
  }
  notifyListeners();
}
}
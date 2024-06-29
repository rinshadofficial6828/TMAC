import 'package:flutter/material.dart';
import 'package:slrapp/custom/flush_bar_custom.dart';
import 'package:slrapp/custom/pop_up_spinkits.dart';
import 'package:slrapp/custom/themes.dart';
import 'package:slrapp/features/main/model/main_trainings_response.dart';
import 'package:slrapp/features/main/model/sub_training_model.dart';
import 'package:slrapp/features/main/model/user_info.dart';
import 'package:slrapp/features/main/repository/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  bool isLoading = false;
  UserRepository userRepo = UserRepository();
  UserInfoModel? userInfo;
  List<MainTrainingsResponse> mainTrainings = [];
  List<SubTrainingresponseModel> subTrainings = [];
  List<SubTrainingresponseModel> percentages = [];
  String mainPercentage = '0';
  int? percentageId;
  int percentageValue = 0;
  String? SubdataPercentage;
  int submainperscentage = 0;

   getuserInfo() async {
    isLoading = true;
   await userRepo.getUserProfile().then((value) {
      print(value?.fullname);
      if(value?.fullname!=null){
        userInfo = value;
        print(userInfo?.toJson());
        isLoading = false;
      }else{
      isLoading = false;
      }
    });
    notifyListeners();
  }

  Future<void> userProfileupdate({required String img, required BuildContext context}) async {
    loadingPopUp(context);
    var value = await userRepo.UpdateProfilePhoto(imgPath: img);
    if (value?.profilePhoto != null) {
      closeLoadingPopUp(context);
      customFlushBar(context:context , message: "Profile Update Success", color: themeColor);
    }else{
      closeLoadingPopUp(context);
      customFlushBar(context:context , message: "Profile Update Failed", color: Colors.red);
    }
    notifyListeners();
  }

  Future<void> toggleDuty({required String status, required BuildContext context}) async {
    loadingPopUp(context);
    var value = await userRepo.toggleDuty(status: status);
    if (value?.onDuty != null) {
      closeLoadingPopUp(context);
      customFlushBar(context: context, message: "Updated Success", color: themeColor);
    } else {
      closeLoadingPopUp(context);
      customFlushBar(context: context, message: "Something Went Wrong", color: Colors.red);
    }
  }

  // Main Trainings
  Future<void> getMaintrainings() async {
    isLoading = true;
  await userRepo.getMaintrainings().then((value) {
    if(value !=null){
      isLoading = false;
    mainTrainings = value;
    }else{
   isLoading = false;
    }
  
  });
    notifyListeners();
  }

  // Sub Trainings
  Future<void> getSubTraining({required int itemId}) async {
    isLoading = true;
    subTrainings = await userRepo.subTrainings(itemId: itemId) ?? [];
    if(subTrainings.isNotEmpty){
      isLoading = false;
    dynamic totalSum = subTrainings
        .map((t) => t.completionPercentage)
        .fold(0.0, (a, b) => a + (b ?? 0));

    dynamic averagePercentage = subTrainings.isNotEmpty ? totalSum / subTrainings.length : 0.0;
    SubdataPercentage = averagePercentage.toStringAsFixed(2) + '%';
    submainperscentage = averagePercentage.isFinite ? averagePercentage.toInt() : 0;
    }else{
    isLoading = false;
    }
    notifyListeners();
  }

  // Percentage
  Future<void> forPercentage() async {
    isLoading = true;
    percentages = await userRepo.loadAllPercentage() ?? [];
    if(percentages.isNotEmpty){
      isLoading = false;
    dynamic totalSum = percentages
        .map((t) => t.completionPercentage)
        .fold(0.0, (a, b) => a + (b ?? 0));
    dynamic avg = percentages.isNotEmpty ? totalSum / percentages.length : 0.0;
    mainPercentage = avg.toStringAsFixed(2) + '%';
    percentageValue = avg.isFinite ? avg.toInt() : 0;
    }else{
    isLoading = false;
    }
    notifyListeners();
  }
}

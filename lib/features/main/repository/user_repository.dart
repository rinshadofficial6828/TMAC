import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slrapp/custom/urls.dart';
import 'package:slrapp/features/main/model/main_trainings_response.dart';
import 'package:slrapp/features/main/model/profile_pic_model.dart';
import 'package:slrapp/features/main/model/sub_training_model.dart';
import 'package:slrapp/features/main/model/toggle_model.dart';
import 'package:slrapp/features/main/model/user_info.dart';

class UserRepository {
  Future<UserInfoModel?> getUserProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? id = prefs.getInt('userId');
      var dio = Dio();
      var response = await dio.request(
        '${baseUrl}employees/$id',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        return UserInfoModel.fromJson(response.data);
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e);
    }
  }

  //==============================updatee profile photo

  Future<ProfilePicUpdate?> UpdateProfilePhoto(
      {required String imgPath}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('userId');
    var request = http.MultipartRequest(
        'PUT', Uri.parse('${baseUrl}employees/$id/update-photo/'));

    try {
      request.files
          .add(await http.MultipartFile.fromPath('profile_photo', imgPath));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

        EasyLoading.showSuccess("Photo Upload Success",
            duration: Duration(seconds: 1));
        return ProfilePicUpdate.fromJson(jsonResponse);
      } else {
        EasyLoading.showError("Something went wrong",
            duration: Duration(seconds: 1));
        print('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      if (e is SocketException) {
        print('Network error: $e');
      } else {
        EasyLoading.showError("Error", duration: Duration(seconds: 1));
        print('Error: $e');
      }
      return null;
    }
  }

//==========================toggle duty =====================
  Future<DutyModel?> toggleDuty({required String status}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('userId');
    try {
      var data = FormData.fromMap({'on_duty': status});

      var dio = Dio();
      var response = await dio.request(
        '${baseUrl}employees/$id/toggle-duty/',
        options: Options(
          method: 'PUT',
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        return DutyModel.fromJson(response.data);
      } else {
        print(response.statusMessage);
      }
    } catch (e) {}
  }

  //==================== main trainings =============

  Future<List<MainTrainingsResponse>?> getMaintrainings() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '${baseUrl}main-trainings',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        List<dynamic> responseData = response.data;
        List<MainTrainingsResponse> crewsList = responseData
            .map((json) => MainTrainingsResponse.fromJson(json))
            .toList();
        return crewsList;
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e);
    }
  }

  //=============usertrainings===========

 Future<List<SubTrainingresponseModel>> subTrainings({required int itemId}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('userId');
    
    if (id == null) {
      throw Exception('User ID not found in shared preferences.');
    }

    var dio = Dio();
    var response = await dio.request(
      '${baseUrl}employee/$id/main-training/$itemId/',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = response.data;
      List<SubTrainingresponseModel> crewsList = responseData
          .map((json) => SubTrainingresponseModel.fromJson(json))
          .toList();
      return crewsList;
    } else {
      throw Exception('Failed to load sub-trainings: ${response.statusMessage}');
    }
  } catch (e) {
    print('Error occurred: $e');
    // Optionally, rethrow or handle the error accordingly.
    return [];
  }
}


  //====================================All training percentage ========================//
  Future<List<SubTrainingresponseModel>?> loadAllPercentage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? id = prefs.getInt('userId');
      var dio = Dio();
      var response = await dio.request(
        '${baseUrl}employeetrainingpercentage/$id/',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        List<SubTrainingresponseModel> crewsList = responseData
            .map((json) => SubTrainingresponseModel.fromJson(json))
            .toList();
        return crewsList;
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e);
    }
  }
}

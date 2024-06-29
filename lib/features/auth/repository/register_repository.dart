import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:slrapp/custom/urls.dart';
import 'package:slrapp/features/auth/model/get_crews_model.dart';
import 'package:slrapp/features/auth/model/get_desigation_by_crew.dart';
import 'package:slrapp/features/auth/model/login_response.dart';
import 'package:slrapp/features/auth/model/project_model.dart';
import 'package:slrapp/features/auth/model/register_model.dart';
import 'package:slrapp/features/auth/model/register_response_model.dart';

class AuthRepository {
  Future <RegisterModel?> registerUser ({required RegisterresponseModel registerResponse })async{
  try{
    var headers = {
  'Content-Type': 'application/x-www-form-urlencoded'
};
var data = registerResponse.toJson();
var dio = Dio();
var response = await dio.request(
  '${baseUrl}register-employees/',
  options: Options(
    method: 'POST',
    headers: headers,
  ),
  data: data,
);

if (response.statusCode == 201) {
  print(json.encode(response.data));
  return RegisterModel.fromJson(response.data);
}
else {
  print(response.statusMessage);
}

  }catch(e){

  print(e);
  }
  return null;
  } 

  //get crews

  Future<List<GetCrewsModel>> getAllCrews() async {

  try {
    var dio = Dio();
    var response = await dio.request(
      '${baseUrl}viewcompanies/',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {

      List<dynamic> responseData = response.data;
      List<GetCrewsModel> crewsList =
          responseData.map((json) => GetCrewsModel.fromJson(json)).toList();
      return crewsList;
    } else {

      print(response.statusMessage);
      return []; // Return an empty list or throw an exception based on your requirement
    }
  } catch (e) {
    print(e.toString());
    return []; // Return an empty list or throw an exception based on your requirement
  }
}

//get desigation by crew
Future<List<GetDesignationsByCrewIdmodel>> getDesigationByCrew({required int id}) async {
  EasyLoading.show(status: "Fetching");
  try {
    var dio = Dio();
    var response = await dio.request(
      '${baseUrl}companies/$id/',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      EasyLoading.dismiss(animation: true);
      EasyLoading.showSuccess("data fetched Success",duration: Duration(seconds: 1));
      List<dynamic> responseData = response.data;
      List<GetDesignationsByCrewIdmodel> crewsList =
          responseData.map((json) => GetDesignationsByCrewIdmodel.fromJson(json)).toList();
      return crewsList;
    } else {
      EasyLoading.dismiss(animation: true);
      print(response.statusMessage);
      return []; // Return an empty list or throw an exception based on your requirement
    }
  } catch (e) {
    EasyLoading.dismiss(animation: true);
    print(e.toString());
    return []; // Return an empty list or throw an exception based on your requirement
  }
}

//login

Future <LoginResponse?> userlogin ({required String mobileNumber,required String fullName})async{
  try{
    var headers = {
  'Content-Type': 'application/x-www-form-urlencoded'
};
var data = {
  'fullname': fullName,
  'mobile_number': mobileNumber
};
var dio = Dio();
var response = await dio.request(
  '${baseUrl}employees-login/',
  options: Options(
    method: 'POST',
    headers: headers,
  ),
  data: data,
);

if (response.statusCode == 200) {
  print(response.data);
  print(json.encode(response.data));
  return LoginResponse.fromJson(response.data);
}
else {
  print(response.statusMessage);
}

  }catch(e){

  print(e);
  }
  return null;
  }

  //=======================================================Get All project===============================//
  Future<List<ProjectModelResponse>?> getAllProject() async {
  try {
    var dio = Dio();
    var response = await dio.request(
      '${baseUrl}viewprojects/',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));

      // Check if the response data is a List
      if (response.data is List) {
        List<dynamic> responseData = response.data;
        List<ProjectModelResponse> projectList = responseData
            .map((json) => ProjectModelResponse.fromJson(json))
            .toList();
        return projectList;
      } else {
        print('Unexpected response format: ${response.data}');
      }
    } else {
      print(response.statusMessage);
    }
  } catch (e) {
    print('Error: $e');
  }
  return null;
}


}


import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ui_design_with_api/UI/controller/auth_controller.dart';
import 'package:ui_design_with_api/UI/screens/sign_in_screen.dart';
import 'package:ui_design_with_api/data/models/network_response.dart';
import '../../app.dart';

class NetworkCaller{


  static Future<NetworkResponse> getRequest({required String url}) async{
    try{
      Uri uri = Uri.parse(url);
      final Response response  = await get(uri);

      debugPrinter(uri, response.statusCode, response.body);

      if(response.statusCode == 200){
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedData
        );
      }
      else if(response.statusCode == 401){
        moveToLogin();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: jsonDecode(response.body)["status"]
        );
      }
      else{
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    }
    catch(e){
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString()
      );
    }
  }


  static Future<NetworkResponse> postRequest({required String url, Map<String, dynamic>? body}) async{
    try{
      Uri uri = Uri.parse(url);
      final Response response  = await post(
        uri,
        body: jsonEncode(body),
        headers: {
          "Content-Type" : "application/json",
          'token' : AuthController.accessToken.toString(),
        }
      );

      debugPrinter(uri, response.statusCode, response.body);

      if(response.statusCode == 200){
        final decodedData = jsonDecode(response.body);

        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedData
        );
      }
      else if(response.statusCode == 401){
        moveToLogin();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: jsonDecode(response.body)["status"]
        );
      }
      else{
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: jsonDecode(response.body)["data"]
        );
      }
    }
    catch(e){
      return NetworkResponse(
          isSuccess: false,
          statusCode: -1,
          errorMessage: e.toString()
      );
    }
  }

  static void debugPrinter(Uri uri, int statusCode, dynamic body) {
    debugPrint("url: $uri");
    debugPrint("Response code:$statusCode");
    debugPrint(body);
  }

  static void moveToLogin() async{
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
        (_)=> false
    );
  }

}
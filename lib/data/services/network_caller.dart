import 'dart:convert';

import 'package:http/http.dart';
import 'package:ui_design_with_api/data/models/network_response.dart';

class NetworkCaller{


  static Future<NetworkResponse> getRequest({required String url}) async{
    try{
      Uri uri = Uri.parse(url);
      final Response response  = await get(uri);

      if(response.statusCode == 200){
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedData
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
        }
      );

      if(response.statusCode == 200){
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedData
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

}
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart'as apiClient;
import 'package:news_app/api/apiException.dart';

class ApiHelper{



  // Future<dynamic> getAPI({required String url})async{
  //   var uri = Uri.parse(url);
  //   var response = await apiClient.get(uri);
  //
  //   if(response.statusCode == 200){
  //     var mData = jsonDecode(response.body);
  //     return mData;
  //   }else{
  //     return null;
  //   }
  // }

  Future<dynamic>getApi({required String url})async{
    var uri = Uri.parse(url);
    try{
      var response = await apiClient.get(uri);
      return returnJsonResponse(response);
    } on SocketException catch(e){
      throw FetchDataException(errorMsg: "No InterNet");
    }
  }



  dynamic returnJsonResponse(apiClient.Response response){
    switch(response.statusCode){
      case 200:{
        var mData = jsonDecode(response.body);
        return mData;
      }
      case 400:
        throw BadRequestException(errorMsg: response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(errorMsg: response.body.toString());
      case 500:
      default:
        throw FetchDataException(errorMsg:  "Error occurred while Communication with Server With StatusCode: ${response.statusCode}");
    }
  }

}
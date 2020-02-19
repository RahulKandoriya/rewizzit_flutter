import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rewizzit/data/models/models/user.dart';
import 'dart:convert';
import 'package:rewizzit/data/services/app-exceptions.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiBaseHelper {
  final String _baseUrl = "https://rewizzit.api.cofeelia.com/";
  SharedPreferences prefs;

  Future<Map<String, String>> fetchAuthToken() async {
    prefs = await SharedPreferences.getInstance();

    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': User.fromJson(json.decode(prefs.getString("user"))).authorizeToken
    };
  }

  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url, headers: await fetchAuthToken());

      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    print('Api Post, url $url body $body');
    var responseJson;
    try {

      final response = await http.post(_baseUrl + url ,headers: await fetchAuthToken(), body: json.encode(body));
      responseJson = _returnResponse(response);


    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  postData(Map<String, dynamic> body)async{
    prefs = await SharedPreferences.getInstance();
    var dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options) async {
          // Do something before request is sent
          options.headers['Authorization'] = User.fromJson(json.decode(prefs.getString("user"))).authorizeToken;
          return options; //continue
          // If you want to resolve the request with some custom data，
          // you can return a `Response` object or return `dio.resolve(data)`.
          // If you want to reject the request with a error message,
          // you can return a `DioError` object or return `dio.reject(errMsg)`
        },
        onResponse:(Response response) async {
          // Do something with response data
          return response; // continue
        },
        onError: (DioError e) async {
          // Do something with response error
          return  e; //continue
        }
    ));
    try {
      FormData formData = new FormData.fromMap(body);
      var response = await dio.post( _baseUrl + "new-card", data: formData);
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      print(e);
    }
  }

  editCardData(Map<String, dynamic> body)async{
    prefs = await SharedPreferences.getInstance();
    var dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options) async {
          // Do something before request is sent
          options.headers['Authorization'] = User.fromJson(json.decode(prefs.getString("user"))).authorizeToken;
          return options; //continue
          // If you want to resolve the request with some custom data，
          // you can return a `Response` object or return `dio.resolve(data)`.
          // If you want to reject the request with a error message,
          // you can return a `DioError` object or return `dio.reject(errMsg)`
        },
        onResponse:(Response response) async {
          // Do something with response data
          return response; // continue
        },
        onError: (DioError e) async {
          // Do something with response error
          return  e;//continue
        }
    ));
    try {
      FormData formData = new FormData.fromMap(body);
      var response = await dio.post( _baseUrl + "card-edit", data: formData);
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      print(e);
    }
  }

}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {

    case 200:
      var responseJson = json.decode(response.body.toString());
      print(response.toString());
      print(responseJson);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
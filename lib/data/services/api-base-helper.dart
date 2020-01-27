import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rewizzit/data/models/models/user.dart';
import 'dart:convert';
import 'package:rewizzit/data/services/app-exceptions.dart';
import 'dart:async';

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
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
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
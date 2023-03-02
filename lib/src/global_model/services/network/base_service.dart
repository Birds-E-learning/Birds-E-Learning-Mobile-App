import 'dart:convert';
import 'dart:io';

import 'package:birds_learning_network/src/global_model/apis/app_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  Future getRequest(String url, Map<String, String> header) async {
    dynamic responseJson;
    try {
      http.Response response = await http.get(Uri.parse(url), headers: header);
      responseJson = returnResponse(response);
    } on SocketException catch (_) {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  Future postRequest(
      String url, Map<String, String> header, Object body) async {
    dynamic responseJson;
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: header, body: jsonEncode(body));
      print(response.body);
      responseJson = returnResponse(response);
    } on SocketException catch (_) {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communicating with server with status code : ${response.statusCode}');
    }
  }
}

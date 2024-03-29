import 'dart:convert';
import 'dart:io';

import 'package:birds_learning_network/src/global_model/apis/app_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  Future stripeRequest(String url, Map<String, String> header, context, body,
      {int time = 100}) async {
    dynamic responseJson;
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: header, body: body);
      responseJson = getReturnResponse(response, context);
    } on SocketException catch (_) {
      throw FetchDataException("No Internet Connection");
    } catch (e) {
      throw Exception(e);
    }
    return responseJson;
  }

  Future getRequest(String url, Map<String, String> header, context,
      {int time = 80}) async {
    dynamic responseJson;
    try {
      // debugPrint("url ===>>> $url");
      http.Response response = await http
          .get(Uri.parse(url), headers: header)
          .timeout(Duration(seconds: time));
      // print(response.body);
      responseJson = getReturnResponse(response, context);
    } on SocketException catch (_) {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  Future deleteRequest(String url, Map<String, String> header, context) async {
    dynamic responseJson;
    try {
      http.Response response = await http
          .delete(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 40));
      // print(response.body);
      responseJson = getReturnResponse(response, context);
      // debugPrint("response ===>> $responseJson");
    } on SocketException catch (_) {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  Future postRequest(
      String url, Map<String, String> header, Object body, context,
      {seconds = 60}) async {
    // debugPrint("url ===>>> $url");
    dynamic responseJson;
    try {
      http.Response response = await http
          .post(Uri.parse(url), headers: header, body: jsonEncode(body))
          .timeout(Duration(seconds: seconds));
      // debugPrint("response ===>> ${response.body}");
      responseJson = returnResponse(response, context);
    } on SocketException catch (_) {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  Future postCartRequest(String url, Map<String, String> header, context,
      {seconds = 60}) async {
    dynamic responseJson;
    try {
      http.Response response = await http
          .post(Uri.parse(url), headers: header)
          .timeout(Duration(seconds: seconds));
      responseJson = returnResponse(response, context);
    } on SocketException catch (_) {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @visibleForTesting
  dynamic getReturnResponse(http.Response response, context) {
    var responseData = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = responseData;
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
            'Error occurred while communicating with server with status code : ${response.statusCode}');
    }
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response, context) {
    var responseData = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = responseData;
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
            'Error occurred while communicating with server with status code : ${response.statusCode}');
    }
  }
}

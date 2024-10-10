import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:mg_dashboard/Data/responseModel.dart';
import 'package:mg_dashboard/Data/urls.dart';

// class Api {
Future<ResponseModel> getApiData(String url) async {
  http.Response? response;
  try {
    var headers = Urls.getHeaders();
    response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonObject = jsonDecode(response.body);
      bool error = jsonObject['error'];
      return ResponseModel(
          statusCode: response.statusCode,
          body: response.body,
          response: response,
          responseObject: jsonObject,
          errorMessage: error
              ? jsonObject.containsKey("message")
                  ? jsonObject['message']
                  : jsonObject['data']
              : "",
          isError: error);
    } else if (response.statusCode == 401) {
      return ResponseModel(
          statusCode: response.statusCode,
          body: response.body,
          response: response,
          errorMessage: "Session expired please login ",
          isError: true,
          responseObject: <String, dynamic>{});
    } else {
      return ResponseModel(
          statusCode: response.statusCode,
          body: response.body,
          response: response,
          errorMessage: "Internal error",
          isError: true,
          responseObject: <String, dynamic>{});
    }
  } catch (error) {
    return ResponseModel(
        statusCode: response!.statusCode,
        body: response.body,
        response: response,
        errorMessage: error.toString(),
        isError: true,
        responseObject: <String, dynamic>{});
  }
}

Future<ResponseModel> postApiData(String url, var body) async {
  http.Response response;
  try {
    response =
        await http.post(Uri.parse(url), body: body, headers: Urls.getHeaders());
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonObject = jsonDecode(response.body);

      bool error = jsonObject['error'];
      return ResponseModel(
          statusCode: response.statusCode,
          body: response.body,
          response: response,
          responseObject: jsonObject,
          isError: error,
          errorMessage: error
              ? jsonObject.containsKey("message")
                  ? jsonObject['message']
                  : jsonObject['data']
              : "");
    } else if (response.statusCode == 401) {
      return ResponseModel(
          statusCode: response.statusCode,
          body: response.body,
          response: response,
          errorMessage: "Session expired please login ",
          isError: true,
          responseObject: <String, dynamic>{});
    } else {
      return ResponseModel(
          statusCode: response.statusCode,
          body: response.body,
          response: response,
          errorMessage: "Internal error : ${response.body}",
          isError: true,
          responseObject: <String, dynamic>{});
    }
  } catch (error) {
    return ResponseModel(
        statusCode: 0,
        body: error.toString(),
        response: error.toString(),
        errorMessage: error.toString(),
        isError: true,
        responseObject: <String, dynamic>{});
  }
}

Future<ResponseModel> getFileApi(String url, var body) async {
  http.Response? response;
  try {
    response =
        await http.post(Uri.parse(url), headers: Urls.getHeaders(), body: body);
    if (response.statusCode == 200) {
      Uint8List bytes = response.bodyBytes;

      bool error = false;
      return ResponseModel(
          statusCode: response.statusCode,
          body: response.body,
          response: response,
          bodyBytes: bytes,
          responseObject: <String, dynamic>{},
          isError: error);
    } else if (response.statusCode == 401) {
      return ResponseModel(
          statusCode: response.statusCode,
          body: response.body,
          response: response,
          errorMessage: "Session expired please login ",
          isError: true,
          responseObject: <String, dynamic>{});
    } else {
      return ResponseModel(
          statusCode: response.statusCode,
          body: response.body,
          response: response,
          errorMessage: "Internal error:${response.body}",
          isError: true,
          responseObject: <String, dynamic>{});
    }
  } catch (error) {
    return ResponseModel(
        statusCode: response!.statusCode,
        body: response.body,
        response: response,
        errorMessage: error.toString(),
        isError: true,
        responseObject: <String, dynamic>{});
  }
}

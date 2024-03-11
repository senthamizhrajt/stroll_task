import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../common/config/app_config.dart';
import 'model/service_request.dart';
import 'model/upload_request.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._init();

  factory NetworkManager() => _instance;

  NetworkManager._init() {
    //_instance = new LocationHandler();// init things inside this
  }

  Future<Response> execute(ServiceRequest request) async {
    Response? response;

    if (request.isMockEnabled && request.mockFileName != null) {
      await Future.delayed(const Duration(seconds: 0));
      String result = await rootBundle.loadString('assets/response/${request.mockFileName!}');
      response = Response(result, 200);
      return response;
    }

    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: request.accessToken ?? '',
    };

    /*if (request.accessToken != null && request.accessToken!.isNotEmpty) {
      requestHeaders[HttpHeaders.authorizationHeader] = request.accessToken!;
    }*/
    //requestHeaders[HttpHeaders.userAgentHeader] = AppConfig.userAgent;

    print(request.url);
    //print(request.body);

    try {
      if (request.method == "GET") {
        response = await http.get(Uri.parse(request.url!), headers: requestHeaders);
      } else if (request.method == "POST") {
        response = await http.post(Uri.parse(request.url!), headers: requestHeaders, body: request.body);
      } else if (request.method == "PUT") {
        response = await http.put(Uri.parse(request.url!), headers: requestHeaders, body: request.body);
      } else if (request.method == "DELETE") {
        response = await http.delete(Uri.parse(request.url!), headers: requestHeaders);
      }
    } catch (e) {
      //print("Error while http request: $e");
    }

    if (response == null) {
      var errorResponse = {
        'error': {'code': 500, 'message': 'Unable to connect to server at the moment. Please try again later.'}
      };
      response = Response(jsonEncode(errorResponse), 500);
    }
    if (response.statusCode == 404) {
      var errorResponse = {
        'error': {'code': 404, 'message': 'The requested service is temporarily unavailable. Please try again later.'}
      };
      response = Response(jsonEncode(errorResponse), 404);
    }

    print(response.body);
    print(response.statusCode);

    return response;
  }

  Future<Response> uploadImage(UploadRequest request) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
      HttpHeaders.authorizationHeader: request.accessToken
    };

    Response? response;
    try {
      response =
          await http.post(Uri.parse(request.url!), headers: headers, encoding: Encoding.getByName("utf-8"), body: {
        'image': 'data:image/${request.fileName.split('.')[1]};base64,${base64Encode(request.fileBytes!)}',
        'filename': request.fileName.split('.')[0]
      });
    } catch (e) {
      //print("Error while uploading file: $e");
    }

    if (response == null) {
      var errorResponse = {
        'error': {'code': 500, 'message': 'Unable to connect to server at the moment. Please try again later.'}
      };
      response = Response(jsonEncode(errorResponse), 500);
    }

    return Future.value(response);
  }

  Future<Response> uploadMultiFile(UploadRequest imageRequest, UploadRequest fileRequest) async {
    Response? response;
    try {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
        HttpHeaders.authorizationHeader: imageRequest.accessToken
      };

      response =
          await http.post(Uri.parse(imageRequest.url!), headers: headers, encoding: Encoding.getByName("utf-8"), body: {
        'file': 'data:file/${fileRequest.fileName.split('.')[1]};base64,${base64Encode(fileRequest.fileBytes!)}',
        'filename': fileRequest.fileName.split('.')[0],
        'image': 'data:image/${imageRequest.fileName.split('.')[1]};base64,${base64Encode(imageRequest.fileBytes!)}',
        'imageFilename': imageRequest.fileName.split('.')[0]
      });
    } catch (e) {
      //print("Error while uploding file: $e");
    }

    response ??= Response('Server Error', 500);
    return response;
  }
}

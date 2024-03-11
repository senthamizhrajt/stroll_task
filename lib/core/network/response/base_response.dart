import '../model/network_error.dart';

class BaseResponse {
  NetworkError? error;

  BaseResponse();

  Map<String, dynamic> toJson() => {};

  BaseResponse.fromJson(Map<String, dynamic> json);

}

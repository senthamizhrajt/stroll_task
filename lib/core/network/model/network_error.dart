class NetworkError {
  int code = -1;
  String? title;
  String message;
  String key;

  NetworkError.fromJson(Map<String, dynamic> json)
      : code = json['code'] ?? -1,
        title = json['title'],
        message = json["message"] is List ? json['message'].cast<String>().toString() : json['message'],
        key = json["key"] ?? '';
}

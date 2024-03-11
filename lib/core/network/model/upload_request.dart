import 'dart:io';
import 'dart:typed_data';

class UploadRequest {
  String? url;
  String? body;
  String? method;
  File? file;
  String fileName = 'image.png';
  Uint8List? fileBytes;
  String accessToken = '';
  String? mockFileName;
  bool? isMockEnabled;
}

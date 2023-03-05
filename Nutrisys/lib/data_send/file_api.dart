import 'dart:typed_data';

import 'package:dio/dio.dart';

class FileApi {
  final _dio = Dio();

  // image 를 byte로 바꿔서 전송
  Future<Response> uploadImage(
      Uint8List image,
      ) async {
    // 보낼 파일을 비동기처리로 전송
    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(image, filename: 'sendImage'),
    });

    // 서버 ip를 적어줘야 함
    final response = await _dio.post(
      'http://1119-34-73-34-119.ngrok.io',
      data: formData,
    );
    return response;
  }
}
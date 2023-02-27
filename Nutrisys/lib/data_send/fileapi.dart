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
        'http://54c4-35-240-159-138.ngrok.io',
        data: formData,
    );
    return response;
  }
}
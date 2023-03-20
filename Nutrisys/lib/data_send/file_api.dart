// import 'dart:html';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrisys/nutritionInfo.dart';

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
      'http://c075-35-222-31-210.ngrok.io/',
      data: formData,
    );
    return response;
  }

}

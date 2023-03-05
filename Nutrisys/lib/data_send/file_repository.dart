import 'dart:typed_data';
import './file_api.dart';

class FileRepository {
  final _api = FileApi();

  Future<bool> uploadImage(Uint8List image) async {
    var response;
    try {
      response = await _api.uploadImage(image);
      print("반환된 api: ${response}");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}

import 'dart:typed_data';
import 'file_repository.dart';

class MainViewModel {
  final _repository = FileRepository();

  Future uploadImage(Uint8List image) async {
    // FileRepository 를 봐야되네
    await _repository.uploadImage(image);
  }
}
// import 'dart:html';
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
      'http://a7e4-35-204-167-156.ngrok.io',
      data: formData,
    );
    return response;
  }

  // 이 메소드로 response에 있는 식품명 가져와서,
  // data라는 map을 가져올 수 있어 ! print는 테스트용 출력문.
  NutritionInfo? getNutritionInfo(Map<String, dynamic>? response) {
    if (response == null) return null;

    final db = FirebaseFirestore.instance;

    final table = db
        .collection("nutri")
        .where("식품명", isEqualTo: "라면_신라면")
        .get()
        .then((querySnapshot) {
      var data = null;

      for (var docSnapshot in querySnapshot.docs) {
        data = docSnapshot.data() as Map<String, dynamic>;
        if (data != null && data["식품명"] == response["식품명"]) {
          break;
        }
      }

      Map<String, double> info = {
        "탄수화물": data["탄수화물(g)"],
        "단백질": data["단백질(g)"],
        "지방": data["지방(g)"],
      };

      NutritionInfo res = NutritionInfo(data["에너지(kcal)"], info);
      return res;
    });

    return null;
  }
}

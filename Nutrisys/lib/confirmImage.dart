import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstore/localstore.dart';
import 'package:nutrisys/nutritionInfo.dart';
import 'package:nutrisys/nutritions.dart';
import 'dart:io';
import './data_send/view_model.dart';
import 'data_send/file_api.dart';
import 'nutritions.dart';

class ConfirmImage extends StatefulWidget {
  const ConfirmImage(
      {Key? key,
      required XFile this.image,
      required Map<DateTime, NutritionInfo> this.history})
      : super(key: key);

  final XFile image;
  final Map<DateTime, NutritionInfo> history;

  @override
  State<ConfirmImage> createState() => _ConfirmImageState();
}

class _ConfirmImageState extends State<ConfirmImage> {
  FileApi api = FileApi();
  NutritionInfo? currentInfo = null;
  Map<String, dynamic>? response = null;

  void loadData(var data) {
    setState(() {
      response = jsonDecode(data.toString());
    });
  }

  void fetchData() async {
    final bytes = await widget.image.readAsBytes();
    loadData(await api.uploadImage(bytes.buffer.asUint8List()));
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // 이 메소드로 response에 있는 식품명 가져와서,
  // data라는 map을 가져올 수 있어 ! print는 테스트용 출력문.
  void setNutritionInfo(Map<String, dynamic>? response) {
    if (currentInfo != null) return;
    final db = FirebaseFirestore.instance;
    final table =
        db.collection("nutri").where("식품명", isEqualTo: response?["식품명"]).get();

    table.then((querySnapshot) {
      var data;

      for (var docSnapshot in querySnapshot.docs) {
        data = docSnapshot.data();
        if (data != null && data["식품명"] == response?["식품명"]) {
          break;
        }
      }

      Nutritions _nutritions = new Nutritions(
          food_name: data["식품명"],
          carbohydrate: data["탄수화물(g)"],
          protein: data["단백질(g)"],
          fat: data["지방(g)"],
          natrium: data["나트륨(mg)"],
          sugars: data["당류(g)"],
          cholesterol: data["콜레스테롤(mg)"]);

      var now = DateTime.now();
      var cur_date = now.day.toString();
      var cur_time =
          now.hour.toString() + now.minute.toString() + now.second.toString();

      _nutritions.save(cur_date, cur_time);

      Map<String, double> info = {
        "탄수화물": data["탄수화물(g)"],
        "단백질": data["단백질(g)"],
        "지방": data["지방(g)"],
      };

      // setState 신청
      setState(() {
        currentInfo = NutritionInfo(data["에너지(kcal)"].toDouble(), info);
        print("이거 설정 언제 되니?");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    setNutritionInfo(response);
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm"),
      ),
      body: Column(children: [
        Image.file(File(widget.image.path)),
        response == null ? CircularProgressIndicator() : Text(response?["식품명"])
      ]
          // child: Text("${response == null}")
          ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 이걸로 파일 전송
          ElevatedButton.icon(
            // confirm 버튼
            onPressed: response == null || currentInfo == null
                ? null
                : () {
                    setState(() {
                      widget.history[DateTime.now()] = currentInfo!;
                    });
                    Navigator.pop(context);
                  },
            icon: Icon(Icons.add),
            label: Text("Confirm"),
          ),

          ElevatedButton.icon(
            // 취소 버튼
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.cancel_outlined),
            label: Text("Cancel"),
          ),
        ],
      ),
    );
  }
}

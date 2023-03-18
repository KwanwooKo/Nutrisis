import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrisys/nutritionInfo.dart';
import 'dart:io';
import './data_send/view_model.dart';
import 'data_send/file_api.dart';

class ConfirmImage extends StatefulWidget {
  const ConfirmImage({Key? key, required XFile this.image, required Map<DateTime, NutritionInfo> this.history}) : super(key: key);

  final XFile image;
  final Map<DateTime, NutritionInfo> history;

  @override
  State<ConfirmImage> createState() => _ConfirmImageState();
}

class _ConfirmImageState extends State<ConfirmImage> {

  FileApi api = FileApi();
  Map<String, dynamic>? response = null;

  void loadData(var data)
  {
    setState(() {
      response = jsonDecode(data.toString());
    });
  }

  void fetchData() async
  {
    final bytes = await widget.image.readAsBytes();
    loadData(await api.uploadImage(bytes.buffer.asUint8List()));
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm"),
      ),
      body: Column(
        children:
        [
          Image.file(File(widget.image.path)),
          response == null ? CircularProgressIndicator() : Text(response?["식품명"])
        ]
        // child: Text("${response == null}")
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 이걸로 파일 전송
          ElevatedButton.icon( // confirm 버튼
            onPressed: response == null ? null : () {
              NutritionInfo? info = api.getNutritionInfo(response);
              if (info != null)
              {
                print("null은 아니고");
                widget.history[DateTime.now()] = info;
              }
              else {
               print("Gaeshibal nulllll");
              }
              Navigator.pop(context);
            },
            icon: Icon(Icons.add),
            label: Text("Confirm"),
          ),

          ElevatedButton.icon( // 취소 버튼
            onPressed: (){
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

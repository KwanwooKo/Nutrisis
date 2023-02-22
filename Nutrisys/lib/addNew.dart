import 'package:flutter/material.dart';
import 'package:nutrisys/bookmark.dart';
import 'package:nutrisys/manualForm.dart';
import 'package:nutrisys/nutritionInfo.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddNew extends StatefulWidget {
  const AddNew({Key? key, required this.nutritionHistory}) : super(key: key);
  final Map<DateTime, NutritionInfo> nutritionHistory;
  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          // padding: EdgeInsets.fromLTRB(50, 100, 50, 100),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      var picker = ImagePicker();
                      var image = await picker.pickImage(source: ImageSource.camera);
                    },
                    icon: Icon(Icons.camera_alt_rounded),
                    label: Text("Camera"),
                  )
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      var picker = ImagePicker();
                      var image = await picker.pickImage(source: ImageSource.gallery);

                      if (image != null) {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder:
                                    (context) => confirmNew(image, context)));
                      }
                    },
                    icon: Icon(Icons.image),
                    label: Text("Gallery"),
                  )
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ManualForm(history : widget.nutritionHistory)
                          )
                      );
                    },
                    icon: Icon(Icons.edit),
                    label: Text("Manual"),
                  )
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: BookMark(),
        )
    );
  }

  Widget confirmNew(XFile image, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm"),
      ),
      body: Image.file(File(image.path)),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 이걸로 파일 전송
          ElevatedButton.icon(
            onPressed: () {
              // 여기 채워주시면 됩니다

              Navigator.pop(context);
            },
            icon: Icon(Icons.add),
            label: Text("Confirm"),
          ),

          ElevatedButton.icon(
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


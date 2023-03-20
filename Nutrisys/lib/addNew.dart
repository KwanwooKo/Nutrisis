import 'package:flutter/material.dart';
import 'package:nutrisys/bookmark.dart';
import 'package:nutrisys/manualForm.dart';
import 'package:nutrisys/nutritionInfo.dart';
import 'package:image_picker/image_picker.dart';
import 'confirmImage.dart';

class AddNew extends StatefulWidget {
  const AddNew({Key? key, required this.nutritionHistory}) : super(key: key);
  final Map<DateTime, NutritionInfo> nutritionHistory;
  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  @override
  Widget build(BuildContext context) {

    double buttonWidth = MediaQuery.of(context).size.width;
    double buttonHeight = MediaQuery.of(context).size.height / 8;
    double bookMarkHeight = MediaQuery.of(context).size.height / 6;

    return Scaffold(
        body: Padding(
          // padding: EdgeInsets.fromLTRB(50, 100, 50, 100),
          padding: EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: buttonWidth,
                  height: buttonHeight,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      var picker = ImagePicker();
                      var image = await picker.pickImage(source: ImageSource.camera);
                      if (image != null) {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder:
                                    (context) => ConfirmImage(image: image, history: widget.nutritionHistory)));
                      }
                    },
                    icon: Icon(Icons.camera_alt_rounded),
                    label: Text("Camera"),
                  ),
                )
              ),
              SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.65,
                  child: SizedBox(
                    width: buttonWidth,
                    height: buttonHeight,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        var picker = ImagePicker();
                        var image = await picker.pickImage(source: ImageSource.gallery);

                        if (image != null) {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder:
                                      (context) => ConfirmImage(image: image, history: widget.nutritionHistory)));
                        }

                      },
                      icon: Icon(Icons.image),
                      label: Text("Gallery"),
                    ),
                  )
              ),
              SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.65,
                  child: SizedBox(
                    width: buttonWidth,
                    height: buttonHeight,
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
                    ),
                  )
              ),
              SizedBox(
                height: bookMarkHeight,
                child: BookMark(),
              )
            ],
          ),
        ),
    );
  }
}

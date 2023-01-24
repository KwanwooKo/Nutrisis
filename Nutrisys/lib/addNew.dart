import 'package:flutter/material.dart';

class AddNew extends StatelessWidget {
  const AddNew({Key? key, this.history}) : super(key: key);
  final history;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(30),
      child: Column(
        children: [
          ElevatedButton(
              onPressed: (){},
              child: Text("Add New")
          ),
        ],
      ),
    );
  }
}


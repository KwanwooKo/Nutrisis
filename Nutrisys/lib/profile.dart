import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends ChangeNotifier {

  var name = "";
  var age = "";
  var gender = "";
  var height = "";
  var weight = "";
  var goalCalorie = "";
  // 이거 input 을 어떻게 받지? => Json 으로? 아니면 Text 에 입력시켜서 그 내용을 받아와서?
  updateProfile({
      name, age, height, weight, gender, cal
  }) async {
    this.name = name;
    this.age = age;
    this.height = height;
    this.weight = weight;
    this.gender = gender;
    goalCalorie = cal;


    // shared preferences를 얻음
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //값 저장하기
    prefs.setString('name', name);
    prefs.setString('age', age);
    prefs.setString('height', height);
    prefs.setString('weight', weight);
    prefs.setString('gender', gender);
    prefs.setString('cal', cal);
  }
}

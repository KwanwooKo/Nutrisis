import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

class Nutritions {
  // 탄 단 지 나트륨 당류 콜레스테롤
  String food_name;
  double carbohydrate;
  double protein;
  double fat;
  double natrium;
  double sugars;
  double cholesterol;

  Nutritions({
    required this.food_name,
    required this.carbohydrate,
    required this.protein,
    required this.fat,
    required this.natrium,
    required this.sugars,
    required this.cholesterol,
  });

  Map<String, dynamic> toMap() {
    return {
      'food_name': food_name,
      'carbohydrate': carbohydrate,
      'protein': protein,
      'fat': fat,
      'natrium': natrium,
      'sugars': sugars,
      'cholesterol': cholesterol,
    };
  }

  factory Nutritions.fromMap(Map<String, dynamic> map) {
    return Nutritions(
        food_name: map['food_name'],
        carbohydrate: map['carbohydrate'],
        protein: map['protein'],
        fat: map['fat'],
        natrium: map['natrium'],
        sugars: map['sugars'],
        cholesterol: map['cholesterol']);
  }

  Future save(String cur_date, String cur_time) async {
    final db = Localstore.instance;
    print('local save success!!');
    // how to make a data_form?
    return db
        .collection(cur_date)
        .doc(cur_time)
        .set(toMap())
        .then((result) => print(result));
  }

  // temporary parameters. may need to modify.
  Future delete(String cur_date, String cur_time) async {
    final db = Localstore.instance;
    return db.collection(cur_date).doc(cur_time).delete();
  }
}

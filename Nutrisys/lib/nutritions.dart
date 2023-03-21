import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

class Nutritions {
  // 탄 단 지 나트륨 당류 콜레스테롤
  String food_name;
  // String? saved_date;
  // String? saved_time;
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

  Map<String, dynamic> toMap(String cur_date, String cur_time) {
    return {
      '식품명': food_name,
      '탄수화물(g)': carbohydrate,
      '단백질(g)': protein,
      '지방(g)': fat,
      '나트륨(mg)': natrium,
      '당류(g)': sugars,
      '콜레스테롤(mg)': cholesterol,
      '저장날짜': cur_date,
      '저장시간': cur_time
    };
  }

  factory Nutritions.fromMap(Map<String, dynamic> map) {
    return Nutritions(
        food_name: map['식품명'],
        carbohydrate: map['탄수화물(g)'],
        protein: map['단백질(g)'],
        fat: map['지방(g)'],
        natrium: map['나트륨(mg)'],
        sugars: map['당류(g)'],
        cholesterol: map['콜레스테롤(mg)']);
  }

  Future save(String cur_date, String cur_time) async {
    // 이거 날짜로 저장해야될듯
    final db = Localstore.instance;
    print('local save success!!');
    // how to make a data_form?
    // 3/20 : 나중에 delete를 위해 Map 자체에도 시간 표시.(Map이 갖고있는 시간 이용해서
    // delete 함수 파라미터로 집어넣기 위함.)
    return db.collection(cur_date).doc(cur_time).set(toMap(cur_date, cur_time));
  }

  // temporary parameters. may need to modify.
  Future delete(String cur_date, String cur_time) async {
    final db = Localstore.instance;
    return db.collection(cur_date).doc(cur_time).delete();
  }
}

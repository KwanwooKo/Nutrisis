class NutritionInfo {

  double _calorie = 0.0;
  Map<String, double> _nutritionMap = {"none": 0};

  NutritionInfo(double carbohydrate, double protein, double fat, double etc, double calorie) {
    _calorie = calorie;
    _nutritionMap = {
      "탄수화물": carbohydrate,
      "단백질": protein,
      "지방": fat,
      "기타": etc,
    };
  }

  Map<String, double> get nutritionMap => _nutritionMap;

  set nutritionMap(Map<String, double> value) {
    _nutritionMap = value;
  }

  double get calorie => _calorie;

  set calorie(double value) {
    _calorie = value;
  }
}
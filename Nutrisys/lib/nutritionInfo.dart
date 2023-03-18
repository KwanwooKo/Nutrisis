class NutritionInfo {

  double _calorie = 0.0;
  Map<String, double> _nutritionMap = {"none": 0};

  NutritionInfo(double calorie, Map<String, double> info)
  {
    _calorie = calorie;
    _nutritionMap = info;
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
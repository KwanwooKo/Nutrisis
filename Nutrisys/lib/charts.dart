import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
// import './main.dart';

class CaloriePieChart extends StatefulWidget {
  CaloriePieChart({Key? key, required this.calorieDataMap}) : super(key: key);
  Map<String, double> calorieDataMap;

  @override
  State<CaloriePieChart> createState() => _CaloriePieChart();
}

class _CaloriePieChart extends State<CaloriePieChart> {

  List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
  ];

  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return PieChart(
          dataMap: widget.calorieDataMap,
          colorList: colorList,
          chartRadius: MediaQuery.of(context).size.width / 2,
          centerText: "Calorie",
          ringStrokeWidth: 24,
          animationDuration: const Duration(seconds: 2),
          chartValuesOptions: const ChartValuesOptions(
              showChartValues: true,
              showChartValuesOutside: true,
              showChartValuesInPercentage: true,
              showChartValueBackground: false),
          legendOptions: const LegendOptions(
              showLegends: true,
              legendShape: BoxShape.rectangle,
              legendTextStyle: TextStyle(fontSize: 15),
              legendPosition: LegendPosition.bottom,
              showLegendsInRow: true),
          gradientList: gradientList,
    );
  }
}
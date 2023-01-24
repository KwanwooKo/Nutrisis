import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import './charts.dart';
import './profile.dart';


class Home extends StatelessWidget {
  Home({Key? key, required this.history, required this.selectedDate, this.changeSelectedDate}) : super(key: key);
  // 상속 하는 코드
  final Map<DateTime, Map<String, double>> history;
  final DateTime selectedDate;
  final changeSelectedDate;
  // Home class 에서 사용하는 변수
  /* 현재 열량을 어떻게 기록할건지? => history 에다가 저장? */
  var currentCalorie;
  String formatDate = DateFormat('yy/MM/dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // main table
        Container(
          padding: const EdgeInsets.all(10),
          child: Center(child: Text('${context.read<Profile>().name}님의 오늘의 섭취량'),),
        ),
        // 날짜 표시
        Container(
          padding: const EdgeInsets.all(10),
          child: Center(child: Text('Date: ${formatDate}'),),
        ),
        // 열량 표시
        Container(
          padding: const EdgeInsets.all(10),
          child: Center(child: Text('열량: ${currentCalorie}cal / ${context.read<Profile>().goalCalorie}'),),
        ),
        // 차트 그리기
        Container(
          padding: const EdgeInsets.all(10),
          child: Center(child: CaloriePieChart(calorieDataMap: history[selectedDate] ?? {"null": 0})),
        ),
        // 자세히 보기 버튼
        Container(
          alignment: Alignment.bottomRight,
          child: TextButton(
              onPressed: () {  },
              child: const Text('자세히 보기')
          ),
        )
      ],
    );
  }
}

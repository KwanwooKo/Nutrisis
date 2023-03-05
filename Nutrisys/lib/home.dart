import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutrisys/nutritionInfo.dart';
import 'package:provider/provider.dart';
import './charts.dart';
import './profile.dart';

class Home extends StatefulWidget {
  Home({Key? key,
    required this.nutritionHistory,
    required this.selectedDate,
    this.changeSelectedDate})
      : super(key: key);
  // 상속 하는 코드
  final Map<DateTime, NutritionInfo> nutritionHistory;
  final DateTime selectedDate;
  final changeSelectedDate;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // 정보가 없는 날에 대해서 빈 동그라미로 나타나는게 싫어서
  // 정보가 있으면 차트를 반환하고, 없으면 없다는 Text를 반환하는 함수 만들었음.
  Widget getChart() {
    if (widget.nutritionHistory.containsKey(widget.selectedDate)) {
      return CaloriePieChart( // 위에서 containsKey 체크했으니 SHiT은 안 뜰거임
          calorieDataMap: widget.nutritionHistory[widget.selectedDate]?.nutritionMap??{"SHiT" : 1}
      );
    }
    return Text("${widget.selectedDate.toString().split(' ')[0]}에 저장된 정보가 없습니다 :(");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white54,
        border: Border.all(
            color: Colors.cyanAccent
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 날짜랑 화살표
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton( // 왼쪽 화살표
                  onPressed: (){
                    widget.changeSelectedDate(
                        widget.selectedDate.subtract(Duration(days: 1))
                    );
                  },
                  icon: Icon(Icons.keyboard_arrow_left),
                  iconSize: 50,
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Center(child: Text(widget.selectedDate.toString().split(' ')[0]),),
                    ),
                    // 열량 표시
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text('열량: ${widget.nutritionHistory[widget.selectedDate]?.calorie} cal / ${context.read<Profile>().goalCalorie}'),
                      ),
                    ),
                  ],
                ),
                IconButton( // 오른쪽 화살표
                  // 현재 보고 있는 날이 오늘이면 다음날로 못 넘어감
                  onPressed: widget.selectedDate == DateTime(
                      DateTime.now().year, DateTime.now().month, DateTime.now().day
                  ) ? null : (){
                    widget.changeSelectedDate(
                        widget.selectedDate.add(Duration(days: 1))
                    );
                  },
                  icon: Icon(Icons.keyboard_arrow_right),
                  iconSize: 50,
                ),
              ],
            ),
            // 차트 그리기
            Container(
              padding: const EdgeInsets.all(10),
              child: Center(child: getChart()),
            ),
            // 자세히 보기 버튼
            Container(
              alignment: Alignment.topRight,
              child: TextButton(
                  onPressed: () {  },
                  child: const Text('자세히 보기'),
              ),
            )
          ],
      ),
    );
  }
}
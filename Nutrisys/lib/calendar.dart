import 'package:flutter/material.dart';

import 'nutritionInfo.dart';

class Calendar extends StatefulWidget {
  const Calendar(
      {Key? key,
      required this.nutritionHistory,
      required this.changeTabTo,
      required this.changeSelectedDate})
      : super(key: key);
  final Map<DateTime, NutritionInfo> nutritionHistory;
  final changeTabTo;
  final changeSelectedDate;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime datePicked = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  Widget getSummary() {
    if (widget.nutritionHistory.containsKey(datePicked)) {
      Map<String, double> mapData =
          widget.nutritionHistory[datePicked]?.nutritionMap ?? {"error": 0};
      return Container(
        width: double.infinity,
        // height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white54,
            border: Border.all(color: Colors.cyanAccent),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Summary of ${datePicked.toString().split(' ')[0]}:\n",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Text("탄수화물: ${mapData!["탄수화물"]}"),
              Text("지방: ${mapData["지방"]}"),
              Text("단백질: ${mapData["단백질"]}"),
              Text("기타: ${mapData["기타"]}"),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  // style: ButtonStyle(
                  //   fixedSize: MaterialStatePropertyAll(Size(100, 64)),
                  // ),
                  onPressed: () {
                    widget.changeSelectedDate(datePicked);
                    widget.changeTabTo(0);
                  },
                  child: const Text("Details"),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Text("No summary on ${datePicked.toString().split(' ')[0]} :(");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.cyanAccent,
      padding: EdgeInsets.all(30),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // color: Colors.cyan,
            decoration: BoxDecoration(
                color: Colors.white54,
                border: Border.all(color: Colors.cyanAccent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            // color: Colors.white,
            child: CalendarDatePicker(
              initialDate: datePicked,
              firstDate: DateTime(2023, 01, 01),
              lastDate: DateTime.now(),
              onDateChanged: (date) {
                setState(() {
                  datePicked = date;
                });
              },
            ),
          ),
          // Spacer(),
          SizedBox(
            height: MediaQuery.of(context).size.height / 32,
          ),
          getSummary(),
        ],
      ),
    );
  }
}

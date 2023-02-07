import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  const Calendar(
      {Key? key,
      required this.history,
      required this.changeTabTo,
      required this.changeSelectedDate})
      : super(key: key);
  final Map<DateTime, Map<String, double>> history;
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
    if (widget.history.containsKey(datePicked)) {
      Map<String, double>? mapData = widget.history[datePicked];
      return Column(
        children: [
          Text("Summary of ${datePicked.toString().split(' ')[0]}:\n"),
          Text("탄수화물: ${mapData!["탄수화물"]}"),
          Text("지방: ${mapData["지방"]}"),
          Text("단백질: ${mapData["단백질"]}"),
          Text("기타: ${mapData["기타"]}"),
          ElevatedButton(
            onPressed: () {
              widget.changeSelectedDate(datePicked);
              widget.changeTabTo(0);
            },
            child: const Text("Details"),
          ),
        ],
      );
    } else {
      return Text("No summary on ${datePicked.toString().split(' ')[0]} :(");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarDatePicker(
          initialDate: datePicked,
          firstDate: DateTime(2023, 01, 01),
          lastDate: DateTime(2023, 12, 31),
          onDateChanged: (date) {
            setState(() {
              datePicked = date;
            });
          },
        ),
        getSummary(),
      ],
    );
  }
}

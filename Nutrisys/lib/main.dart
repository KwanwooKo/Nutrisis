import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './charts.dart';
import './profile.dart';
import './home.dart';
import './calendar.dart';
import './addNew.dart';
import './settings.dart';
import './nutritionInfo.dart';

void main() {
  runApp(
    ChangeNotifierProvider (
      create: (context) => Profile(),
      child: MaterialApp(
        initialRoute: '/',
        home: MyApp(),
      )
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tap = 0;


  Map<DateTime, Map<String, double>> history = {
    DateTime(2023, 1, 23) : {
      "탄수화물": 12,
      "단백질": 5,
      "지방": 6,
      "기타": 3,
    },
    DateTime(2023, 1, 24) : {
      "탄수화물": 13,
      "단백질": 8,
      "지방": 7,
      "기타": 4,
    },
  };

  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  void changeSelectedDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  // 고관우: setState 를 이용해서 tap 변경
  clickTap(var index) {
    setState(() {
      tap = index;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var pages = [
      Home(history: history, selectedDate: selectedDate, changeSelectedDate: changeSelectedDate,),
      Calendar(history : history, changeTabTo : clickTap, changeSelectedDate : changeSelectedDate),
      AddNew(history: history)
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('NutriSys',), centerTitle: false,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings()));
            },
            icon: const Icon(Icons.settings)
          ),
        ],
      ),
      body: pages[tap],
      bottomNavigationBar: BottomNavigationBar(
        // 고관우: currentIndex 이용해주니까 이거 focus 가 바뀌네
        currentIndex: tap,
        // 고관우: index 를 이용해서 tap 을 띄워 => setState 필요
        onTap: (index) { clickTap(index); },
        items: const [
          // 고관우: 이거 focus 계속 home 에 가있는데 focus 이동 안되나?
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈',),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: '캘린더',),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: '추가',),
        ],
      ),
    );
  }
}


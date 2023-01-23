import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import './charts.dart';

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
  Map<String, double> calorieDataMap = {
    "탄수화물": 120.7,
    "단백질": 35.6,
    "지방": 12.4,
    "기타": 3.7,
  };

  // 고관우: setState 를 이용해서 tap 변경
  clickTap(var index) {
    setState(() {
      tap = index;
    });
  }

  setCalorieDataMap(var carbohydrate, var protein, var fat, var etc) {
    calorieDataMap["탄수화물"] = carbohydrate;
    calorieDataMap["단백질"] = protein;
    calorieDataMap["지방"] = fat;
    calorieDataMap["기타"] = etc;
  }
  setCarbohydrate(var carbohydrate) {
    calorieDataMap["탄수화물"] = carbohydrate;
  }
  setProtein(var protein) {
    calorieDataMap["단백질"] = protein;
  }
  setFat(var fat) {
    calorieDataMap["지방"] = fat;
  }
  setEtc(var etc) {
    calorieDataMap["기타"] = etc;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var pages = [Home(calorieDataMap: calorieDataMap,), Calendar(), Adder()];
    return Scaffold(
      appBar: AppBar(
        title: const Text('NutriSys',), centerTitle: false,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
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

class Home extends StatelessWidget {
  Home({Key? key, this.calorieDataMap}) : super(key: key);
  var currentCalorie;
  var calorieDataMap;
  String formatDate = DateFormat('yy/MM/dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Text('${context.read<Profile>().name}님의 오늘의 섭취량'),),
        Center(child: Text('Date: ${formatDate}'),),
        Center(child: Text('열량: ${currentCalorie}cal / ${context.read<Profile>().goalCalorie}'),),
        // 차트 그리기
        Center(child: CaloriePieChart(calorieDataMap: calorieDataMap)),
      ],
    );
  }
}

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('달력');
  }
}

class Adder extends StatelessWidget {
  const Adder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('추가');
  }
}

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 이거 좀 더 자세히 그려야 할듯
          SizedBox(
            child: Text('이름    ${context.read<Profile>().name}'),
          ),
          SizedBox(child: Text('나이    ${context.read<Profile>().age}세'),),
          SizedBox(child: Text('성별    ${context.read<Profile>().gender}'),),
          SizedBox(child: Text('키    ${context.read<Profile>().height}cm'),),
          SizedBox(child: Text('몸무게    ${context.read<Profile>().weight}kg'),),
          SizedBox(child: Text('목표    열량    탄수화물    단백질    지방'),)

        ],
      ),
    );
  }
}



class Profile extends ChangeNotifier {
  var name = '고관우';
  var age = '27';
  var gender = '남자';
  var height = '176';
  var weight = '85';
  var goalCalorie = '3000';

  // 이거 input 을 어떻게 받지? => Json 으로? 아니면 Text 에 입력시켜서 그 내용을 받아와서?
  setProfile() {

  }
}

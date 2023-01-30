import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './profile.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 이거 좀 더 자세히 그려야 할듯
          SizedBox(
            child: Text('이름    ${context.read<Profile>().name}'),
          ),
          SizedBox(
            child: Text('나이    ${context.read<Profile>().age}세'),
          ),
          SizedBox(
            child: Text('성별    ${context.read<Profile>().gender}'),
          ),
          SizedBox(
            child: Text('키    ${context.read<Profile>().height}cm'),
          ),
          SizedBox(
            child: Text('몸무게    ${context.read<Profile>().weight}kg'),
          ),
          SizedBox(
            child: Text('목표    열량    탄수화물    단백질    지방'),
          )
        ],
      ),
    );
  }
}

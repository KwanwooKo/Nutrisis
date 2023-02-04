import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './profile.dart';

Profile userProfile = Profile();

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  ProfileFormState createState() {
    return ProfileFormState();
  }
}

class ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //주석추가
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 8),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            //여기에 폼을 작성
            renderTextFormField(
              label: '이름',
              onSaved: (val) {},
              validator: (val) {
                if (val.isEmpty) {
                  return '입력해주세요';
                }
                user.name = val;
                return null;
              },
            ),

            renderTextFormField(
              label: '나이',
              onSaved: (val) {},
              validator: (val) {
                if (val.isEmpty || isInt(val) == false) {
                  return '숫자를 입력해주세요';
                }
                user.age = int.tryParse(val)!;
                return null;
              },
            ),

            renderDropdownBox(),

            renderTextFormField(
              label: '키',
              onSaved: (val) {},
              validator: (val) {
                if (val.isEmpty || isInt(val) == false) {
                  return '숫자를 입력해주세요';
                }

                user.height = int.tryParse(val)!;
                return null;
              },
            ),

            renderTextFormField(
              label: '몸무게',
              onSaved: (val) {},
              validator: (val) {
                if (val.isEmpty || isInt(val) == false) {
                  return '숫자를 입력해주세요';
                }

                user.weight = int.tryParse(val)!;
                return null;
              },
            ),

            renderTextFormField(
              label: '하루 목표 칼로리 (kcal)',
              onSaved: (val) {},
              validator: (val) {
                if (val.isEmpty || isInt(val) == false) {
                  return '숫자를 입력해주세요';
                }

                user.cal = int.tryParse(val)!;
                return null;
              },
            ),
            renderSubmitBtn(),
          ],
        ),
      ),
    );
  }

  renderTextFormField({
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
  }) {
    // assert(onSaved != null);
    // assert(validator != null);

    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 10, right: 10, left: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          TextFormField(
            onSaved: onSaved,
            validator: validator,
          ),
        ],
      ),
    );
  }

  renderSubmitBtn() {
    return ElevatedButton(
      //raisedButton이 사장됐나보다...
      // color: Colors.blue,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          //! 추가하니까 에러 잡혔다.
          //validation이 성공하면 true가 리턴된다.

          //일단 저장
          userProfile.updateProfile(
              name: user.name,
              age: user.age,
              height: user.height,
              weight: user.weight,
              gender: user.gender,
              cal: user.cal);

          const snackBar = SnackBar(
            content: Text('저장 완료!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          const snackBar = SnackBar(
            content: Text('잘못 입력된 항목이 있습니다.'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Text(
        '저장',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  renderDropdownBox() {
    const List<String> list = <String>['선택해주세요', 'Male', 'Female'];
    String dropdownValue = list[0];

    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 10, right: 10, left: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "성별",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                onChanged: (String? value) {
                  print(value);
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                    user.gender = value;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

UserProfile user = UserProfile(); //일단 객체 만들어 놓고

class UserProfile {
  String name = "";
  int age = 0;
  int height = 0;
  int weight = 0;
  String gender = "none";
  int cal = 0;
}

bool isInt(String? str) {
  if (str == null) {
    return false;
  }
  return int.tryParse(str) != null;
}

void testFunction() async {}

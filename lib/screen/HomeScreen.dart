import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lotto_number_generator/component/number_row.dart';
import 'package:lotto_number_generator/constant/color.dart';
import 'package:lotto_number_generator/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int maxNumber = 45 ;

  List<int> randomNumbers = [
    123, 234, 345, 456, 567, 678
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PRIMARY_COLOR,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(onPressed: onSettingsPop),
                _Body(randomNumbers: randomNumbers,),
                _Footer(onPressed: onLottoNumberGenerate)
              ],
            ),
          ),
        ));
  }

  void onLottoNumberGenerate() {
    final rand = Random();
    final Set<int> newNumbers = {};

    while (newNumbers.length != 6) {
      final number = rand.nextInt(maxNumber) + 1;
      newNumbers.add(number);
    }
    setState(() {
      randomNumbers = newNumbers.toList();
    });
  }

  void onSettingsPop() async {
    final result = await Navigator.of(context).push<int>(
        MaterialPageRoute(builder: (BuildContext context) {
          return SettingsScreen(
            maxNumber: maxNumber,
          );
        }
        )
    );
    if(result!=null){
      setState(() {
        maxNumber = result;
      });
    }
  }

}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;

  const _Header({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '로또번호 생성기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.settings,
              color: RED_COLOR,
            ))
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumbers;

  const _Body({required this.randomNumbers, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: randomNumbers
              .asMap()
              .entries
              .map((x) =>
              Padding(
                padding: EdgeInsets.only(bottom: x.key == 5 ? 0 : 16.0),
                child: NumberRow(number: x.value),
              ))
              .toList(),
        ));
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: RED_COLOR,
          ),
          onPressed: onPressed,
          child: Text('생성하기!'),
        )
    );
  }
}

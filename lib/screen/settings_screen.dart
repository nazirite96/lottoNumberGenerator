import 'package:flutter/material.dart';
import 'package:lotto_number_generator/component/number_row.dart';
import 'package:lotto_number_generator/constant/color.dart';

class SettingsScreen extends StatefulWidget {
  final int maxNumber;
  const SettingsScreen({
    required this.maxNumber,Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double maxNumber = 45;

  @override
  void initState(){
    super.initState();

    maxNumber = widget.maxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Body(maxNumber: maxNumber),
              _Foot(maxNumber: maxNumber, onPressed: onButtonPressed, onChanged: onSliderChanged)
            ],
          ),
        ),
      ),
    );
  }

  void onButtonPressed(){
      Navigator.of(context).pop(maxNumber.toInt());
  }

  void onSliderChanged(double val) {
    setState(() {
      maxNumber = val;
    });
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;

  const _Body({required this.maxNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(number: maxNumber.toInt()),
    );
  }
}

class _Foot extends StatelessWidget {
  final double maxNumber;
  final ValueChanged<double>? onChanged;
  final VoidCallback onPressed;


  const _Foot({required this.maxNumber, required this.onPressed,required this.onChanged, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
            value: maxNumber,
            min: 45,
            max: 100000,
            onChanged: onChanged,
            ),
        ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: RED_COLOR,
            ),
            child: const Text('저장!'))
      ],
    );

  }
}

import 'package:flutter/material.dart';
import 'package:flutter_chip_choice/flutter_chip_choice.dart';

class SingleChoice extends StatefulWidget {
  const SingleChoice({required this.options, Key? key}) : super(key: key);
  final List<Enum> options;

  @override
  _SingleChoiceState createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  int tag = 0;
  late void Function(int)? selected;

  @override
  Widget build(BuildContext context) {
    return ChipsChoice<int>.single(
      value: tag,
      onChanged: (val) => setState(() {
        tag = val;
      }),
      choiceItems: C2Choice.listFrom<int, Enum>(
        source: widget.options,
        style: (i, v) {
          return const C2ChoiceStyle(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            showCheckmark: false,
          );
        },
        activeStyle: (i, v) {
          return const C2ChoiceStyle(
            brightness: Brightness.dark,
          );
        },
        value: (i, v) => i,
        label: (i, v) =>
            v.toString().split(".").last.replaceAll("_", " ").toUpperCase(),
      ),
      choiceStyle: const C2ChoiceStyle(
        color: Colors.blueGrey,
        avatarBorderColor: Colors.white,
      ),
      choiceActiveStyle: const C2ChoiceStyle(
        color: Color(0xFFff004d),
      ),
    );
  }
}

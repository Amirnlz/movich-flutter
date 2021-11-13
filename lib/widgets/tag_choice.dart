import 'package:flutter/material.dart';
import 'package:flutter_chip_choice/flutter_chip_choice.dart';

class TagChoices extends StatefulWidget {
  const TagChoices(
      {required this.options,
      required this.itemCallBack,
      this.tag = 0,
      Key? key})
      : super(key: key);
  final List<Enum> options;
  final Function(int?) itemCallBack;
  final int tag;

  @override
  _TagChoicesState createState() => _TagChoicesState();
}

class _TagChoicesState extends State<TagChoices> {
  int tag = 0;

  @override
  Widget build(BuildContext context) {
    return ChipsChoice<int>.single(
      value: widget.tag,
      onChanged: widget.itemCallBack,
      choiceItems: C2Choice.listFrom<int, Enum>(
        source: widget.options,
        style: (i, v) {
          return const C2ChoiceStyle(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            showCheckmark: false,
            labelStyle: TextStyle(
              fontFamily: 'OpenSans',
              letterSpacing: 1.1,
            ),
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
        color: Color(0xFFA81A1B),
        labelStyle: TextStyle(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:movich/helpers/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.widthSize,
    required TextEditingController controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.iconData,
    Key? key,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final TextInputType keyboardType;
  final double widthSize;
  final String hintText;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthSize,
      child: Neumorphic(
        style: kSearchNeumorphicStyle,
        child: TextField(
          controller: _controller,
          keyboardType: keyboardType,
          autofocus: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 13,
              fontFamily: 'Oxygen',
            ),
            suffixIcon: Icon(iconData),
            contentPadding: const EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:movich/helpers/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.width,
    required this.title,
    required TextEditingController controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.iconData,
    Key? key,
  })  : _controller = controller,
        super(key: key);

  final String title;
  final TextEditingController _controller;
  final TextInputType keyboardType;
  final double width;
  final String hintText;
  final IconData? iconData;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey.shade300,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: size.height * 0.013),
        SizedBox(
          width: width,
          child: Neumorphic(
            style: kSearchNeumorphicStyle,
            child: TextField(
              controller: _controller,
              keyboardType: keyboardType,
              autofocus: false,
              obscureText: obscureText,
              style: TextStyle(
                color: Colors.grey.shade200,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 13,
                ),
                suffixIcon: Icon(iconData),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

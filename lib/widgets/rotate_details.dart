import 'package:flutter/material.dart';

class RotateDetails extends StatelessWidget {
  final String text;
  final IconData icon;

  const RotateDetails(this.text, this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 30),
      child: RotatedBox(
        quarterTurns: 3,
        child: Row(
          children: [
            Icon(
              icon,
              size: 25,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

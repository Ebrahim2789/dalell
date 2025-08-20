import 'package:flutter/material.dart';

class LabeledContainer extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;

  const LabeledContainer(
      {super.key,
      required this.text,
      this.width,
      this.height,
      this.color,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}



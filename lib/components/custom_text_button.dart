import 'package:flutter/material.dart';
import 'package:golf_social/components/constants.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final TextStyle style;
  final Color color;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.style = const TextStyle(),
    this.color = primaryLimeGreen,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: style.copyWith(color: color),
      ),
    );
  }
}

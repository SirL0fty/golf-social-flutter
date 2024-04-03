import 'package:flutter/material.dart';
import 'package:golf_social/components/constants.dart';

class SocialMediaButton extends StatelessWidget {
  final String imagePath;
  final Function() onTap;

  const SocialMediaButton(
      {super.key, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
            bottom: 10), // Add some space between the buttons
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: primaryLimeGreen,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

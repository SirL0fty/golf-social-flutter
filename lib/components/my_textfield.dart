import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: widget.controller,
          obscureText: widget.obscureText && !showPassword,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey[300]),
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

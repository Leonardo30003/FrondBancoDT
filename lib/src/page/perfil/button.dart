import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    this.color,
    this.onPressed, // Add this line
  }) : super(key: key);

  final String text;
  final Color? color;
  final VoidCallback? onPressed; // Add this line

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Use the onPressed callback here
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: color ?? const Color(0xff6200ee), // Use provided color or default
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Center(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.title, this.buttonColor, this.onTap});

  final String? title;
  final Color? buttonColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
      child: Text(
        title ?? '',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

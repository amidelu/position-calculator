import 'package:flutter/material.dart';

class CustomTextRow extends StatelessWidget {
  const CustomTextRow(
      {super.key,
      required this.title,
      required this.value,
      required this.isDollarShown});

  final String? title;
  final String? value;
  final bool isDollarShown;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          isDollarShown
              ? Text(
                  '\$$value',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                )
              : Text(
                  value ?? '',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
        ],
      ),
    );
  }
}

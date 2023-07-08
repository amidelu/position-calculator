import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.label,
      required this.isDone,
      this.myFocus,
      required this.onChanged});

  final String? label;
  final bool isDone;
  final FocusNode? myFocus;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: myFocus,
      keyboardType: TextInputType.number,
      textInputAction: isDone ? TextInputAction.done : TextInputAction.next,
      decoration: InputDecoration(
        prefixText: '\$',
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        label: Text(label ?? ''),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onChanged: onChanged,
    );
  }
}

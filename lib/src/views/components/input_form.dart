import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  const InputForm(
      {super.key,
      required this.newValue,
      required this.label,
      required this.hint,
      required this.maxLines,
      required this.maxLength,
      required this.keyboardType});
  final Function(String) newValue;
  final String label;
  final String hint;
  final int maxLines;
  final int maxLength;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      onChanged: (value) {
        newValue(value);
      },
      keyboardType: keyboardType,
      initialValue: '',
      maxLength: maxLength,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please input your $label";
        }
      },
      decoration: InputDecoration(
        label: Text(label),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}

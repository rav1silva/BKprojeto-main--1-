// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../theme/pallete.dart';

@immutable
class SelectField extends StatefulWidget {
  final double width;
  final String hintText;
  List<String> options;
  String? selectedValue;
  TextEditingController controller;

  SelectField(
      {super.key,
      required this.width,
      this.selectedValue,
      required this.options,
      required this.hintText,
      required this.controller});

  @override
  State<SelectField> createState() => _SelectFieldState();
}

class _SelectFieldState extends State<SelectField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: Pallete.secondaryColor,
            ),
          ),
        ),
        style: const TextStyle(
          color: Pallete.textPrimaryColor,
        ),
        value: widget.selectedValue,
        hint: Text(widget.hintText),
        items: widget.options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            widget.selectedValue = newValue;
            widget.controller.text = newValue ?? '';
          });
        },
      ),
    );
  }
}

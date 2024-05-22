// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ravi_desafio/theme/pallete.dart';

import '../theme/font.dart';

@immutable
class CustomTextField extends StatefulWidget {
  final String labelText;
  final double width;
  final bool obscureText;
  TextEditingController controller = TextEditingController();

  CustomTextField(
      {super.key,
      required this.labelText,
      required this.controller,
      this.width = 322,  this.obscureText = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 54,
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        style: const TextStyle(
          fontSize: Font.size14,
          fontFamily: Font.flame,
        ),
        focusNode: _focusNode,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            fontSize: Font.size14,
            color: _focusNode.hasFocus
                ? Pallete.secondaryColor
                : Pallete.textPrimaryColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: _focusNode.hasFocus
                  ? Pallete.secondaryColor
                  : Pallete.textPrimaryColor,
            ),
          ),
          fillColor: Pallete.primaryColor,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../theme/font.dart';
import '../theme/pallete.dart';

class ButtonDefault extends StatefulWidget {
  final String text;
  final double width;
  final VoidCallback? onPressed;
  final bool isDanger;

  const ButtonDefault({super.key, required this.text, required this.width, this.onPressed, this.isDanger = false});

  @override
  State<ButtonDefault> createState() => _ButtonDefaultState();
}

class _ButtonDefaultState extends State<ButtonDefault> {
  bool _isPressed = false;
  Color _getColor() {
    if (widget.isDanger) {
      return Pallete.dangerColor;
    } else {
      return Pallete.secondaryColor;
    }
  }

  Color _getColorDark() {
    if (widget.isDanger) {
      return Pallete.darkDangerColor;
    } else {
      return Pallete.darkSecondaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          _isPressed = false;
        });
        widget.onPressed?.call();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Container(
        width: widget.width,
        height: 54,
        decoration: BoxDecoration(
          color: _isPressed ? _getColorDark() : _getColor(),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: Font.size18,
              color: Pallete.whiteColor,
              fontFamily: Font.flame,
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../theme/pallete.dart';

class StepByStep extends StatefulWidget {
  final int quantity_steps;
  final int current_step;

  const StepByStep(
      {super.key, required this.quantity_steps, required this.current_step});

  @override
  State<StepByStep> createState() => _StepByStepState();
}

class _StepByStepState extends State<StepByStep> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5,
      child: Row(
        children: [
          for (int i = 0; i < widget.quantity_steps; i++)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    right: i == widget.quantity_steps - 1 ? 0 : 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.current_step == i
                        ? Pallete.yellowColor
                        : Pallete.yellowColor.withOpacity(0.2),
                  ),
                  height: 5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ravi_desafio/theme/pallete.dart';

class CountPoints extends StatefulWidget {
  final String points;
  const CountPoints({super.key, this.points = '0'});

  @override
  State<CountPoints> createState() => _CountPointsState();
}

class _CountPointsState extends State<CountPoints> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 5),
            child: Container(
              width: 55,
              height: 34,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Pallete.beigeColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 7),
                child: Text(
                  widget.points,
                  style: const TextStyle(
                    color: Pallete.yellowColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Image.asset(
              'assets/images/count-point-star.png',
              width: 48,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ravi_desafio/theme/pallete.dart';

import '../theme/font.dart';

class CardStatistics extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final double width;

  const CardStatistics(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image, this.width = 172});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 68,
      decoration: BoxDecoration(
        color: Pallete.whiteColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18, top: 20),
            child: Image.asset(image, height: 28),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 58.0, top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Pallete.textPrimaryColor,
                    fontSize: Font.size14,
                    fontFamily: Font.flame,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Pallete.textPrimaryColor,
                    fontSize: Font.size14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

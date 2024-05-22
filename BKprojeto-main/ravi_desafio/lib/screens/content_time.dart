import 'package:flutter/material.dart';

import '../theme/font.dart';
import '../theme/pallete.dart';

class ContentTime extends StatefulWidget {
  const ContentTime({super.key});

  @override
  State<ContentTime> createState() => _ContentTimeState();
}

class _ContentTimeState extends State<ContentTime> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Pallete.blueSky,
      child: const SafeArea(
        child: Center(
          child: Text(
            'Time',
            style: TextStyle(
              color: Pallete.textPrimaryColor,
              fontSize: Font.size24,
              fontFamily: Font.flame,
            ),
          ),
        ),
      ),
    );
  }
}

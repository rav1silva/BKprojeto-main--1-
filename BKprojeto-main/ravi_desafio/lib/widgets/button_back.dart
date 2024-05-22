import 'package:flutter/material.dart';

import '../theme/font.dart';
import '../theme/pallete.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back, color: Pallete.textPrimaryColor,),
      label: const Text(
        'Voltar',
        style: TextStyle(fontSize: Font.size16,
        color: Pallete.textPrimaryColor),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        elevation: MaterialStateProperty.all(0),
      ),
    );
  }
}

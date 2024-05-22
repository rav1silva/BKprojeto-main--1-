import 'package:flutter/material.dart';
import 'package:ravi_desafio/theme/pallete.dart';

import '../theme/font.dart';

class ContentStore extends StatefulWidget {
  const ContentStore({super.key});

  @override
  State<ContentStore> createState() => _ContentStoreState();
}

class _ContentStoreState extends State<ContentStore> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Pallete.blueSky,
      child: const SafeArea(
        child: Center(
          child: Text(
            'Loja',
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

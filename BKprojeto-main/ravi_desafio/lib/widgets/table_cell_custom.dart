import 'package:flutter/material.dart';

import '../theme/font.dart';
import '../theme/pallete.dart';

class TableCellCustom extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool lastColumn;

  const TableCellCustom(
      {super.key, required this.title, required this.subtitle, this.lastColumn = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: lastColumn ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: Font.size18,
              color: Pallete.textPrimaryColor,
              fontFamily: Font.flame),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            color: Pallete.textSecondaryColor,
            fontSize: Font.size14,
          ),
        ),
      ],
    );
  }
}

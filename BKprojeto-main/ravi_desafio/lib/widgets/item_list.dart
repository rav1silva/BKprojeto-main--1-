import 'package:flutter/material.dart';
import 'package:ravi_desafio/widgets/fase_map.dart';

class ItemsList extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const ItemsList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.reversed.toList().map((item) {
        return FaseMap(
          completed: item['completed'],
          imageCompleted: item['imageCompleted'],
          imageNormal: item['imageNormal'],
          posicaoX: item['posicaoX'],
          showButton: item['currentLevel'],
        );
      }).toList(),
    );
  }
}
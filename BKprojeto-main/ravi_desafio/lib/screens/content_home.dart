import 'package:flutter/material.dart';
import 'package:ravi_desafio/widgets/item_list.dart';

class ContentHome extends StatefulWidget {
  const ContentHome({super.key});

  @override
  State<ContentHome> createState() => _ContentHomeState();
}

class _ContentHomeState extends State<ContentHome> {
  final List<List<Map<String, dynamic>>> sections = [
    [
      {
        'imageNormal': 'assets/images/section-1-completed.png',
        'imageCompleted': 'assets/images/section-1-completed.png',
        'completed': false,
        'posicaoX': 0.0,
        'currentLevel': true
      },
      {
        'imageNormal': 'assets/images/section-2.png',
        'imageCompleted': 'assets/images/section-2-completed.png',
        'completed': false,
        'posicaoX': 0.25,
        'currentLevel': false
      },
      {
        'imageNormal': 'assets/images/section-3.png',
        'imageCompleted': 'assets/images/section-3-completed.png',
        'completed': false,
        'posicaoX': 0.5,
        'currentLevel': false
      },
      {
        'imageNormal': 'assets/images/section-4.png',
        'imageCompleted': 'assets/images/section-4-completed.png',
        'completed': false,
        'posicaoX': 0.25,
        'currentLevel': false
      },
      {
        'imageNormal': 'assets/images/section-5.png',
        'imageCompleted': 'assets/images/section-5-completed.png',
        'completed': false,
        'posicaoX': 0.0,
        'currentLevel': false
      },
      {
        'imageNormal': 'assets/images/section-6.png',
        'imageCompleted': 'assets/images/section-6-completed.png',
        'completed': false,
        'posicaoX': 0.25,
        'currentLevel': false
      },
      {
        'imageNormal': 'assets/images/section-7.png',
        'imageCompleted': 'assets/images/section-7-completed.png',
        'completed': false,
        'posicaoX': 0.5,
        'currentLevel': false
      },
      {
        'imageNormal': 'assets/images/section-8.png',
        'imageCompleted': 'assets/images/section-8-completed.png',
        'completed': false,
        'posicaoX': 0.25,
        'currentLevel': false
      }
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 950,
          child: Image.asset(
            "assets/images/background-main.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 16, right: 16),
                child: Column(
                  children: sections.map((items) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ItemsList(items: items),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

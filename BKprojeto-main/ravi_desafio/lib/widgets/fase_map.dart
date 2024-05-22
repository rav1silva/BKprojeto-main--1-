import 'package:flutter/material.dart';
import 'package:ravi_desafio/theme/pallete.dart';
import 'package:ravi_desafio/widgets/dialog_message.dart';

class FaseMap extends StatelessWidget {
  final String imageCompleted;
  final String imageNormal;
  final double posicaoX;
  final bool completed;
  final bool showButton;

  const FaseMap(
      {super.key,
      required this.posicaoX,
      required this.completed,
      required this.imageCompleted,
      required this.imageNormal,
      this.showButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: MediaQuery.of(context).size.width * posicaoX),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Visibility(
              visible: showButton,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const DialogMessage();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8.0),
                  backgroundColor: Pallete.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                child: const Text(
                  'Começar',
                  style: TextStyle(
                    color: Pallete.whiteColor,
                  ),
                ),
              ),
            ),
            Image.asset(
              completed ? imageCompleted : imageNormal,
              width: 92,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:ravi_desafio/helpers/dio.dart';
import 'package:flutter/material.dart';
import 'package:ravi_desafio/screens/question_screen.dart';
import 'package:ravi_desafio/theme/pallete.dart';

import '../theme/font.dart';

class DialogMessage extends StatefulWidget {
  const DialogMessage({super.key});

  @override
  State<DialogMessage> createState() => _DialogMessageState();
}

class _DialogMessageState extends State<DialogMessage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListBody(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Image.asset(
                  'assets/images/burger.png',
                  width: 150,
                ),
              ),
              const Text(
                'Pronto para começar?',
                style: TextStyle(
                  fontSize: Font.size24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Você irá responder a um quiz relacionado ao conteúdo estudado.',
                style: TextStyle(
                  fontSize: Font.size14,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Pallete.secondaryColor,
            foregroundColor: Pallete.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          child: const SizedBox(
            width: double.maxFinite,
            child: Center(
              child: Text(
                'Estou pronto',
                style: TextStyle(fontSize: Font.size18),
              ),
            ),
          ),
          onPressed: () async {
            var dioClient = DioClient();

            dioClient.dio.get('/questions').then((response) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return QuestionScreen(arrayData: response.data,);
              }));
            }).catchError((error) {
              print("Erro: ${error}");
              const snackBar = SnackBar(
                content: Text(
                    'Ops! Error: não foi possível buscar as perguntas'),
                backgroundColor: Colors.redAccent,
                duration: Duration(seconds: 5),
              );

              ScaffoldMessenger.of(context)
                  .showSnackBar(snackBar);
            });
          },
        ),
      ],
    );
  }
}

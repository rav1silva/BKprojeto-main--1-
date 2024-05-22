import 'package:flutter/material.dart';
import 'package:ravi_desafio/screens/result_screen.dart';
import 'package:ravi_desafio/theme/pallete.dart';
import 'package:ravi_desafio/widgets/button_default.dart';
import 'package:ravi_desafio/widgets/step_by_step.dart';

import '../theme/font.dart';

class QuestionScreen extends StatefulWidget {
  var arrayData;

  QuestionScreen({super.key, required this.arrayData});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int pontuation = 0;
  int _step = 0;

  String questionCurrent = '';
  String _question1 = '';
  String _question2 = '';

  int _numberResponseCorrectQuestion1 = 2;
  int _numberResponseCorrectQuestion2 = 3;

  late List<String> responsesCurrent;
  List<String> _responses1 = [];

  List<String> _responses2 = [];

  int? responseCurrent;
  int? responseQuestion1;
  int? responseQuestion2;

  @override
  void initState() {
    super.initState();

    _question1 = widget.arrayData[0]["pergunta"];
    _question2 = widget.arrayData[1]["pergunta"];

    List respostas = widget.arrayData[0]["respostas"];
    for (int i = 0; i < respostas.length; i++) {
      _responses1.add(respostas[i]["resposta"]);
      if (respostas[i]["correta"] == true) {
        _numberResponseCorrectQuestion1 = i;
      }
    }
    respostas = widget.arrayData[1]["respostas"];
    for (int i = 0; i < respostas.length; i++) {
      _responses2.add(respostas[i]["resposta"]);
      if (respostas[i]["correta"] == true) {
        _numberResponseCorrectQuestion2 = i;
      }
    }

    questionCurrent = _question1;
    responsesCurrent = _responses1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/logo-bk-color.png',
                          width: 38,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                StepByStep(quantity_steps: 2, current_step: _step),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        children: [
                          Text(
                            questionCurrent,
                            style: const TextStyle(
                              fontFamily: Font.flame,
                              color: Pallete.textPrimaryColor,
                              fontSize: Font.size18,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                for (int i = 0; i < responsesCurrent.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: RadioListTile(
                      contentPadding: const EdgeInsets.all(2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: const BorderSide(
                          color: Pallete.textPrimaryColor,
                        ),
                      ),
                      title: Text(
                        responsesCurrent[i],
                        style: const TextStyle(
                          fontSize: Font.size16,
                          color: Pallete.textPrimaryColor,
                        ),
                      ),
                      value: i,
                      groupValue: responseCurrent,
                      onChanged: (value) {
                        setState(() {
                          responseCurrent = value as int;
                        });
                      },
                    ),
                  ),
                const SizedBox(height: 36),
                ButtonDefault(
                  text: 'Continuar',
                  width: double.infinity,
                  onPressed: () {
                    if (responseCurrent == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Selecione uma resposta'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (responseQuestion1 == null) {
                      setState(() {
                        responseQuestion1 = responseCurrent;
                        responseCurrent = null;
                        responsesCurrent = _responses2;
                        questionCurrent = _question2;
                        _step++;
                      });
                    } else if (responseQuestion2 == null) {
                      responseQuestion2 = responseCurrent;

                      if (responseQuestion1 ==
                          _numberResponseCorrectQuestion1) {
                        pontuation += 50;
                      }

                      if (responseQuestion2 ==
                          _numberResponseCorrectQuestion2) {
                        pontuation += 50;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            result: pontuation,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

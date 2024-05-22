import 'package:flutter/material.dart';
import 'package:ravi_desafio/Screens/login_screen.dart';
import 'package:ravi_desafio/theme/pallete.dart';
import 'package:ravi_desafio/widgets/button_back.dart';
import 'package:ravi_desafio/widgets/step_by_step.dart';

import '../helpers/dio.dart';
import '../helpers/helper_pref.dart';
import '../theme/font.dart';
import '../widgets/button_default.dart';
import '../widgets/text_field.dart';

class RegistrationScreenThird extends StatefulWidget {
  const RegistrationScreenThird({super.key});

  @override
  State<RegistrationScreenThird> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreenThird> {
  final _academicEducationController = TextEditingController();
  final _academicStatusController = TextEditingController();
  final _interestAreaController = TextEditingController();
  final _strongPointsController = TextEditingController();
  final _developSkillsController = TextEditingController();
  final _supportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Pallete.primaryColor,
          child: SafeArea(
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 350),
                child: Image.asset(
                  'assets/images/star.png',
                  width: 23,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, left: 16),
                child: ButtonBack(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/images/logo-bk-color.png',
                        width: 38,
                      ),
                    ),
                    const SizedBox(height: 36),
                    const StepByStep(quantity_steps: 3, current_step: 2),
                    const SizedBox(height: 24),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Queremos te ver brilhar!',
                        style: TextStyle(
                          fontSize: Font.size24,
                          fontFamily: Font.flame,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Vamos preparar um plano de carreira exclusivo para você alcançar seus objetivos',
                        style: TextStyle(
                          fontSize: Font.size18,
                          fontFamily: Font.flame,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    CustomTextField(
                      labelText: 'Qual área de atuação você se interessa?',
                      controller: _academicEducationController,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      labelText: 'Quais são seus objetivos na empresa?',
                      controller: _academicStatusController,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      labelText: 'Quais os seus pontos fortes?',
                      controller: _strongPointsController,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      labelText: 'Quais as habilidades você gostaria de desenvolver?',
                      controller: _developSkillsController,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      labelText: 'Quais suportes são necessários para seus objetivos?',
                      controller: _supportController,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 40),
                    ButtonDefault(
                      text: 'Continuar',
                      width: double.infinity,
                      onPressed: () async {
                        var dioClient = DioClient();
                        var idDto1 = await HelperPref.getIdDto1();
                        var token = await HelperPref.getToken();

                        dioClient.dio.options.headers = {
                          'Authorization': 'Bearer $token',
                        };

                        dioClient.dio.post('/infoUsers/$idDto1/part2', data: {
                          'academic_education': _academicEducationController.text,
                          'academic_status': _academicStatusController.text,
                          'interest_area': _interestAreaController.text,
                          'strong_points': _strongPointsController.text,
                          'develop_skills': _developSkillsController.text,
                          'support': _supportController.text
                        }).then((response) async {
                          if (response.statusCode == 201) {
                            const snackBar = SnackBar(
                              content: Text('Respostas cadastradas com sucesso!'),
                              backgroundColor: Colors.green,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          }
                        }).catchError((error) {
                          final snackBar = SnackBar(
                            content: Text('Ops! Error: ${error.response?.data['message']}'),
                            backgroundColor: Colors.redAccent,
                            duration: const Duration(seconds: 5),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Image.asset('assets/images/bottom-registration-2-3.png', width: 300),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

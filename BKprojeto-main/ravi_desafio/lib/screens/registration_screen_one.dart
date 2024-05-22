import 'package:flutter/material.dart';
import 'package:ravi_desafio/helpers/dio.dart';
import 'package:ravi_desafio/helpers/helper_pref.dart';
import 'package:ravi_desafio/theme/pallete.dart';
import 'package:ravi_desafio/widgets/button_back.dart';
import 'package:ravi_desafio/widgets/select_field.dart';
import 'package:ravi_desafio/widgets/step_by_step.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/font.dart';
import '../widgets/button_default.dart';
import '../widgets/text_field.dart';
import 'registration_screen_second.dart';

class RegistrationScreenOne extends StatefulWidget {
  const RegistrationScreenOne({super.key});

  @override
  State<RegistrationScreenOne> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreenOne> {
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _cpfController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Pallete.primaryColor,
          child: SafeArea(
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(top: 150, left: 350),
                child: Image.asset(
                  'assets/images/crown.png',
                  width: 44,
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
                    const StepByStep(quantity_steps: 3, current_step: 0),
                    const SizedBox(height: 24),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'E aí, Futurista!',
                        style: TextStyle(
                          fontSize: Font.size24,
                          fontFamily: Font.flame,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Estamos animados por ter você aqui!',
                        style: TextStyle(
                          fontSize: Font.size18,
                          fontFamily: Font.flame,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Para finalizarmos seu cadastro, por favor, preencha os dados abaixo:',
                        style: TextStyle(
                          fontSize: Font.size18,
                          fontFamily: Font.flame,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    CustomTextField(
                      labelText: 'Informe seu e-mail',
                      controller: _emailController,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      labelText: 'Informe seu CPF',
                      controller: _cpfController,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      labelText: 'E uma senha',
                      controller: _passwordController,
                      width: double.infinity,
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      labelText: 'Como gostaria de ser chamado',
                      controller: _nameController,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 24),
                    SelectField(
                        controller: _roleController,
                        width: double.infinity,
                        options: const [
                          'Administrador(a)',
                          'Funcionário(a)',
                          'Estagiário(a)'
                        ],
                        hintText: 'Selecione seu cargo'),
                    const SizedBox(height: 40),
                    ButtonDefault(
                      text: 'Continuar',
                      width: double.infinity,
                      onPressed: () {
                        var dioClient = DioClient();

                        dioClient.dio.post('/users', data: {
                          'name': _nameController.text,
                          'cpf': _cpfController.text,
                          'email': _emailController.text,
                          'password': _passwordController.text,
                          'role': _roleController.text,
                          'branch_company': 'BK'
                        }).then((response) async {
                          if (response.statusCode == 201) {
                            const snackBar = SnackBar(
                              content: Text('Cadastro feito com sucesso!'),
                              backgroundColor: Colors.green,
                            );

                            var result = await dioClient.login(response.data['email'], _passwordController.text);

                            HelperPref.saveToken(result.data['access_token']);
                            var idUser = HelperPref.getIdByToken(result.data['access_token']);
                            HelperPref.saveId(idUser as String);

                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegistrationScreenSecond()),
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 765, bottom: 20),
                child: Image.asset(
                    'assets/images/image-bottom-first-screen-reg.png'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

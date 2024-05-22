import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:ravi_desafio/helpers/helper_pref.dart';
import 'package:ravi_desafio/theme/font.dart';
import 'package:ravi_desafio/theme/pallete.dart';
import 'package:ravi_desafio/widgets/button_default.dart';
import 'package:ravi_desafio/widgets/text_field.dart';

import '../helpers/dio.dart';
import 'main_screen.dart';
import 'registration_screen_one.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCPFController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black87,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Image.asset(
                "assets/images/girl-background.png",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 46),
                child: Image.asset(
                  'assets/images/logo-bk-white.png',
                  width: 38,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 470,
                  decoration: const BoxDecoration(
                    color: Pallete.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 16, right: 16),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Faça seu Login',
                            style: TextStyle(
                              fontSize: Font.size24,
                              color: Pallete.textPrimaryColor,
                              fontFamily: Font.flame,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.account_circle_outlined,
                                color: Pallete.secondaryColor,
                                size: 24,
                              ),
                            ),
                            CustomTextField(
                              labelText: 'Informe seu e-mail ou CPF',
                              controller: _emailCPFController,
                              width: MediaQuery.of(context).size.width - 72,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.lock_outline,
                                size: 24,
                                color: Pallete.secondaryColor,
                              ),
                            ),
                            CustomTextField(
                              labelText: 'E sua senha',
                              controller: _passwordController,
                              width: MediaQuery.of(context).size.width - 72,
                              obscureText: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        ButtonDefault(
                          text: 'Entrar',
                          width: double.infinity,
                          onPressed: () {
                            if (_emailCPFController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Preencha todos os campos'),
                                  backgroundColor: Colors.red,
                                ),
                              );

                              return;
                            }

                            var dioClient = DioClient();

                            dioClient.dio.post('/auth/login', data: {
                              'email': _emailCPFController.text,
                              'password': _passwordController.text,
                            }).then((response) {
                              if (response.statusCode == 200) {
                                const snackBar = SnackBar(
                                  content: Text('Seja bem-vindo(a)!'),
                                  backgroundColor: Colors.green,
                                );

                                var token = response.data['access_token'];

                                HelperPref.saveToken(token);
                                Map<String, dynamic> tokenDecoded =
                                    JwtDecoder.decode(token);
                                HelperPref.saveId(tokenDecoded['sub']);

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainScreen()),
                                );
                              }
                            }).catchError((error) {
                              print("Erro: ${error}");
                              final snackBar = SnackBar(
                                content: Text(
                                    'Ops! Error: ${error.response?.data['message']}'),
                                backgroundColor: Colors.redAccent,
                                duration: const Duration(seconds: 5),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            });
                          },
                        ),
                        const SizedBox(height: 32),
                        Stack(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(top: 13),
                                child: Text('Ainda não tem um cadastro?'),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationScreenOne(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Cadastre-se agora',
                                  style: TextStyle(
                                      color: Pallete.textPrimaryColor),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

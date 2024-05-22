// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:ravi_desafio/helpers/dio.dart';
import 'package:ravi_desafio/helpers/helper_pref.dart';
import 'package:ravi_desafio/theme/font.dart';
import 'package:ravi_desafio/theme/pallete.dart';
import 'package:ravi_desafio/widgets/button_default.dart';
import 'package:ravi_desafio/widgets/card_statistics.dart';
import 'package:ravi_desafio/widgets/table_cell_custom.dart';

import 'login_screen.dart';

class ContentProfile extends StatefulWidget {
  const ContentProfile({super.key});

  @override
  State<ContentProfile> createState() => _ContentProfileState();
}

class _ContentProfileState extends State<ContentProfile> {
  late Future<dynamic> _profileData;
  bool _showAllInfo = false;

  @override
  void initState() {
    super.initState();
    _profileData = fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallete.primaryColor,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<dynamic>(
                future: _profileData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                          'Erro: Você respondeu as informações corretamente do cadastro?'),
                    );
                  } else if (snapshot.hasData) {
                    var userData = snapshot.data;

                    return SizedBox(
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Text(
                                'Perfil',
                                style: TextStyle(
                                    fontFamily: Font.flame,
                                    color: Pallete.textPrimaryColor,
                                    fontSize: Font.size24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 124,
                                    width: MediaQuery.of(context).size.width - 32,
                                    decoration: BoxDecoration(
                                      color: Pallete.whiteColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16, left: 8, right: 8),
                                    child: Image.asset(
                                      'assets/images/profile.png',
                                      width: 74,
                                      height: 92,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 90),
                                    child: Text(
                                      userData['user']['name'],
                                      style: const TextStyle(
                                          color: Pallete.textPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: Font.size18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 58, left: 90),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.watch_later_outlined,
                                          size: 16,
                                          color: Pallete.textSecondaryColor,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          userData['user']['branch_company'],
                                          style: const TextStyle(
                                            color: Pallete.textSecondaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 84, left: 90),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.shopping_bag,
                                          size: 16,
                                          color: Pallete.textSecondaryColor,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          userData['user']['role'],
                                          style: const TextStyle(
                                            color: Pallete.textSecondaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TableCellCustom(
                                  title: 'Sonho',
                                  subtitle: userData['userDTO']['dream']),
                              TableCellCustom(
                                  title: 'Hobby',
                                  subtitle: userData['userDTO']['hobby'],
                                  lastColumn: true),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TableCellCustom(
                                title: 'Motivação',
                                subtitle: userData['userDTO']['motivation'],
                              ),
                              TableCellCustom(
                                title: 'Referências pessoais',
                                subtitle: userData['userDTO']
                                    ['personal_reference'],
                                lastColumn: true,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Visibility(
                            visible: _showAllInfo,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TableCellCustom(
                                      title: 'Valores pessoais',
                                      subtitle: userData['userDTO']
                                          ['personal_valuer'],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TableCellCustom(
                                      title: 'Educação',
                                      subtitle: userData['userDTO2']['academic_education'],
                                    ),
                                    TableCellCustom(
                                      title: 'Status da formação',
                                      subtitle: userData['userDTO2']
                                      ['academic_status'],
                                      lastColumn: true,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TableCellCustom(
                                      title: 'Área de interesse',
                                      subtitle: userData['userDTO2']['interest_area'],
                                    ),
                                    TableCellCustom(
                                      title: 'Pontos fortes',
                                      subtitle: userData['userDTO2']
                                      ['strong_points'],
                                      lastColumn: true,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TableCellCustom(
                                      title: 'A desenvolver',
                                      subtitle: userData['userDTO2']['develop_skills'],
                                    ),
                                    TableCellCustom(
                                      title: 'Suporte necessário',
                                      subtitle: userData['userDTO2']
                                      ['support'],
                                      lastColumn: true,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                child: Text(
                                  _showAllInfo
                                      ? 'Mostrar menos'
                                      : 'Mostrar mais',
                                  style: const TextStyle(
                                      color: Pallete.textPrimaryColor,
                                      fontSize: Font.size16),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showAllInfo = !_showAllInfo;
                                  });
                                },
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 64,
                            child: Center(child: Divider(thickness: 0.5)),
                          ),
                          const Row(
                            children: [
                              Text(
                                'Estatísticas',
                                style: TextStyle(
                                    fontFamily: Font.flame,
                                    color: Pallete.textPrimaryColor,
                                    fontSize: Font.size24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CardStatistics(
                                title: '641',
                                subtitle: 'Dias seguidos',
                                image: 'assets/images/fire.png',
                                width:
                                    MediaQuery.of(context).size.width / 2 - 24,
                              ),
                              CardStatistics(
                                title: '24 Conquistas',
                                subtitle: 'Esta semana',
                                image: 'assets/images/medal.png',
                                width:
                                    MediaQuery.of(context).size.width / 2 - 24,
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          ButtonDefault(
                              text: 'Sair',
                              width: double.infinity,
                              isDanger: true,
                              onPressed: () {
                                HelperPref.removeId();
                                HelperPref.removeToken();

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                    (route) => false);
                              }),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('Erro ao buscar informações!'),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }

  Future<dynamic> fetchProfileData() async {
    var dioClient = DioClient();
    var token = await HelperPref.getToken();
    var idUser = await HelperPref.getId();

    dioClient.dio.options.headers['Authorization'] = 'Bearer $token';

    var response = await dioClient.dio.get("/infoUsers/$idUser");

    if (response.statusCode == 200) {
      return response.data;
    } else {
      const snackBar = SnackBar(
        content: Text('Ops! Error ao buscar informações!'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 5),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if (response.data['message'] != "") {
        return response.data['message'];
      } else {
        return null;
      }
    }
  }
}

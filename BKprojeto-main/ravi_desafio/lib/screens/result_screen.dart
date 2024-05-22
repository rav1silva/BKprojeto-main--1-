// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:ravi_desafio/Screens/main_screen.dart';
import 'package:ravi_desafio/widgets/button_default.dart';
import 'package:ravi_desafio/widgets/count_points.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/font.dart';
import '../theme/pallete.dart';

class ResultScreen extends StatefulWidget {
  /// Result
  ///
  /// 0=bad
  /// 50=good
  /// 100=perfect
  final int result;

  const ResultScreen({super.key, required this.result});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late String backgroundImage;
  late String burguerImage;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    backgroundImage = 'assets/images/background-${widget.result}.png';
    burguerImage = 'assets/images/burguer-${widget.result}.png';

    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            backgroundImage,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Center(
            child: Container(
              width: 358,
              height: 552,
              decoration: BoxDecoration(
                color: Pallete.whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        'Nova conquista',
                        style: TextStyle(
                          fontFamily: Font.flame,
                          color: Pallete.textPrimaryColor,
                          fontSize: Font.size24,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Image.asset(
                        burguerImage,
                        width: 222,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: CountPoints(
                          points: '+${widget.result}',
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: ButtonDefault(
                        text: 'Continuar',
                        width: double.infinity,
                        onPressed: () {
                          int pointsActual = _prefs.getInt('points') ?? 0;
                          _prefs.setInt('points', pointsActual + widget.result);

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const MainScreen()),
                                (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: GestureDetector(
                        onTap: () {
                          print('Compartilhar conquista');
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: 54,
                          decoration: BoxDecoration(
                            color: Pallete.beigeColor,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Compartilhar conquista',
                              style: TextStyle(
                                fontSize: Font.size18,
                                color: Pallete.textPrimaryColor,
                                fontFamily: Font.flame,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ravi_desafio/widgets/count_points.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/pallete.dart';
import 'content_home.dart';
import 'content_profile.dart';
import 'content_store.dart';
import 'content_time.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _points = 0;
  late SharedPreferences _prefs;
  int _indexActive = 0;
  final List<Widget> _screens = [
    const ContentHome(),
    const ContentTime(),
    const ContentStore(),
    const ContentProfile(),
  ];

  @override
  void initState() {
    super.initState();
    _loadPoints();
  }

  Future<void> _loadPoints() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _points = _prefs.getInt('points') ?? 0;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _indexActive = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: _screens[_indexActive],
          ),
          Visibility(
            visible: _indexActive != 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 16),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _indexActive = 3;
                  });
                },
                icon: const Icon(
                  Icons.account_circle,
                  size: 48,
                ),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Pallete.whiteColor),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _indexActive != 3,
            child: Positioned(
              top: 48,
              right: 16,
              child: CountPoints(points: _points.toString()),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset_rounded),
            label: 'Aprender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: 'Time',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Loja',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _indexActive,
        selectedItemColor: Pallete.secondaryColor,
        unselectedItemColor: Pallete.textSecondaryColor,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}

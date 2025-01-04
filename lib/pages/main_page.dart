// lib/pages/main_page.dart
import 'package:flutter/material.dart';
import 'package:food_finder/components/styles.dart';
import 'package:food_finder/helpers/token_storage.dart';
import 'package:food_finder/pages/profile_page.dart';

import '../components/dashboard_page.dart';
import 'login_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  TokenStorage tokenStorage = TokenStorage();

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                tokenStorage.deleteAllTokens();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(value: 'logout', child: Text('Logout')),
              ];
            },
          ),
        ],
        title: Text('Food Finder', style: whiteBoldText),
        backgroundColor: Colors.blue[900],
      ),
      body: _currentIndex == 0 ? DashboardPage() : ProfilePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        backgroundColor: Colors.blue[50],
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.blue[300],
      ),
    );
  }
}

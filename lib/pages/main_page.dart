import 'package:flutter/material.dart';
import 'package:medhealth/pages/history_page.dart';
import 'package:medhealth/pages/home_page.dart';
import 'package:medhealth/pages/profile_page.dart';
import 'package:medhealth/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectIndex = 0;
  final _pageList = [
    const HomePage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  onTappedItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: "History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded), label: "Profile")
        ],
        currentIndex: _selectIndex,
        onTap: onTappedItem,
        unselectedItemColor: grey35Color,
      ),
      body: _pageList.elementAt(_selectIndex),
    );
  }
}

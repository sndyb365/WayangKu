import 'package:flutter/material.dart';
import 'package:mbanking_app_flutter/components/card_screen.dart';
import 'package:mbanking_app_flutter/home_screen.dart';
import 'package:mbanking_app_flutter/components/profile_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mbanking_app_flutter/page/cerita.dart';
import 'package:mbanking_app_flutter/page/film.dart';
import 'package:mbanking_app_flutter/page/history_page.dart';

void main() {
  runApp(const MbakingApp());
}

class MbakingApp extends StatelessWidget {
  const MbakingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WayangKu',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'poppins'),
      home: const MainNavigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CeritaPage(),
    const FilmPage(),
    const SuaraPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
    bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.fixed, // Tambahkan ini
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() {
      _currentIndex = index;
    });
  },
  selectedItemColor: Colors.white,
  unselectedItemColor: Colors.white70,
  backgroundColor: Colors.amber,
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_filled), 
      label: 'Home'),
    BottomNavigationBarItem(
      icon: Icon(Icons.book), 
      label: 'Cerita'),
    BottomNavigationBarItem(
      icon: Icon(Icons.movie),
      label: 'Film',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.volume_up),
      label: 'Suara',
    ),
  ],
),

    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:mbanking_app_flutter/page/login_screen.dart';
import 'package:mbanking_app_flutter/page/register_screen.dart';
import 'package:mbanking_app_flutter/page/profile_screen.dart';

import 'package:mbanking_app_flutter/page/cerita.dart';
import 'package:mbanking_app_flutter/page/film.dart';
import 'package:mbanking_app_flutter/page/suara.dart';
import 'package:mbanking_app_flutter/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('id'), Locale('jv')],
      path: 'assets/lang/', // path to your localization JSON files
      fallbackLocale: const Locale('id'),
      child: const WayangkuApp(),
    ),
  );
}

class WayangkuApp extends StatelessWidget {
  const WayangkuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WayangKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'poppins',
      ),
      localizationsDelegates: <LocalizationsDelegate<Object>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ] + context.localizationDelegates.cast<LocalizationsDelegate<Object>>(),
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) return const Locale('id');
        if (locale.languageCode == 'jv') {
          // fallback to 'id' since MaterialLocalization doesn’t support 'jv'
          return const Locale('id');
        }
        if (supportedLocales.any((e) => e.languageCode == locale.languageCode)) {
          return locale;
        }
        return const Locale('id');
      },

      // Use named routes including your login flow and main app navigation
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/main': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
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
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.amber,
        items: [

        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mbanking_app_flutter/components/card_screen.dart';
import 'package:mbanking_app_flutter/home_screen.dart';
import 'package:mbanking_app_flutter/components/profile_screen.dart';
import 'package:mbanking_app_flutter/page/cerita.dart';
import 'package:mbanking_app_flutter/page/film.dart';
import 'package:mbanking_app_flutter/page/suara.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('id'), Locale('jv')],
      path: 'assets/lang/', // path ke file JSON bahasa
      fallbackLocale: const Locale('id'),
      child: const MbakingApp(),
    ),
  );
}

class MbakingApp extends StatelessWidget {
  const MbakingApp({super.key});

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
          // fallback ke 'id' karena MaterialLocalization belum support jv
          return const Locale('id');
        }
        if (supportedLocales.any((e) => e.languageCode == locale.languageCode)) {
          return locale;
        }
        return const Locale('id');
      },
      home: const MainNavigation(),
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
    SuaraPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WayangKu"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Locale>(
                value: context.locale,
                icon: const Icon(Icons.language, color: Colors.white),
                dropdownColor: Colors.amber,
                onChanged: (Locale? locale) {
                  if (locale != null) {
                    context.setLocale(locale);
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: Locale('id'),
                    child: Text('Indonesia'),
                  ),
                  DropdownMenuItem(
                    value: Locale('jv'),
                    child: Text('Jawa'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.amber,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_filled),
            label: 'home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.book),
            label: 'story'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.movie),
            label: 'film'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.volume_up),
            label: 'sound'.tr(),
          ),
        ],
      ),
    );
  }
}

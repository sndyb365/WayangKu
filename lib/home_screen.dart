import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mbanking_app_flutter/page/baratayudaaudio.dart';
import 'package:mbanking_app_flutter/page/ceritabaratayuda.dart';
import 'package:mbanking_app_flutter/page/film.dart';
import 'package:mbanking_app_flutter/page/kuispage.dart';
import 'package:mbanking_app_flutter/page/login_screen.dart';
import 'package:mbanking_app_flutter/page/profile_screen.dart';
import 'package:mbanking_app_flutter/page/register_screen.dart';
import 'package:mbanking_app_flutter/page/suara.dart';
import 'package:mbanking_app_flutter/page/cerita.dart';
import 'package:mbanking_app_flutter/page/baratayudavideo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, String> _localizedStrings = {};
  String _currentLangCode = 'id';

  final List<String> userData = ['Sandy Bimo Harjudanto', 'sandybimo@email.com'];

  final List<Transaction> transactions = [
    Transaction('Perang Baratayuda', 0, DateTime(2025, 5, 26)),
    Transaction('Ki Anom Suroto – Lakon Bimo Labuh', 0, DateTime(2025, 5, 26)),
    Transaction('Ratna Kumala Alengka', 0, DateTime(2025, 5, 26)),
  ];

  @override
  void initState() {
    super.initState();
    _loadLanguageFile(_currentLangCode);
  }

  Future<void> _loadLanguageFile(String langCode) async {
    try {
      final jsonString = await rootBundle.loadString('assets/lang/$langCode.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      setState(() {
        _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
        _currentLangCode = langCode;
      });
    } catch (e) {
      debugPrint('Error loading language file: $e');
    }
  }

  String tr(String key) {
    return _localizedStrings[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          tr('title'),
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: DropdownButton<String>(
              dropdownColor: Colors.amber[300],
              underline: const SizedBox(),
              icon: const Icon(Icons.language, color: Colors.white),
              value: _currentLangCode,
              items: const [
                DropdownMenuItem(value: 'id', child: Text('ID', style: TextStyle(color: Colors.white))),
                DropdownMenuItem(value: 'jv', child: Text('JV', style: TextStyle(color: Colors.white))),
              ],
              onChanged: (value) {
                if (value != null && value != _currentLangCode) {
                  _loadLanguageFile(value);
                }
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildUserProfile(userData[0], userData[1]),
            _buildBalanceCard(),
            _buildTransactionHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile(String name, String email) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/fotoku.jpg',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  email,
                  style: GoogleFonts.poppins(color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.amber[500]!, Colors.amber[500]!]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionButton(Icons.book, 'cerita', tr('balance_card_cerita')),
              _buildActionButton(Icons.movie, 'film', tr('balance_card_film')),
              _buildActionButton(Icons.volume_up, 'suara', tr('balance_card_suara')),
              _buildActionButton(Icons.quiz, 'kuis', tr('balance_card_kuis')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String labelId, String displayLabel) {
    return GestureDetector(
      onTap: () {
        switch (labelId) {
          case 'cerita':
            Navigator.push(context, MaterialPageRoute(builder: (_) => const CeritaPage()));
            break;
          case 'film':
            Navigator.push(context, MaterialPageRoute(builder: (_) => const FilmPage()));
            break;
          case 'suara':
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SuaraPage()));
            break;
          case 'kuis':
            Navigator.push(context, MaterialPageRoute(builder: (_) => const KuisPage()));
            break;
        }
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.amber),
          ),
          const SizedBox(height: 8),
          Text(displayLabel, style: GoogleFonts.poppins()),
        ],
      ),
    );
  }

  Widget _buildTransactionHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            tr('last_activity'),
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        CardPerang(
          transaction: transactions[0],
          imageAsset: 'assets/baratayuda.jpg',
          destination: const BaratayudaCeritaPage(),
          dateLabel: tr('date_label'),
        ),
        CardPerang(
          transaction: transactions[1],
          imageAsset: 'assets/lakonbimo.jpg',
          destination: const BaratayudaCeritaPage(),
          dateLabel: tr('date_label'),
        ),
        CardPerang(
          transaction: transactions[2],
          imageAsset: 'assets/ratna.jpg',
          destination: const BaratayudaVideoPage(),
          dateLabel: tr('date_label'),
        ),
      ],
    );
  }
}

class Transaction {
  final String description;
  final double amount;
  final DateTime date;
  Transaction(this.description, this.amount, this.date);
}

class CardPerang extends StatelessWidget {
  final Transaction transaction;
  final String imageAsset;
  final Widget destination;
  final String dateLabel;

  const CardPerang({
    super.key,
    required this.transaction,
    required this.imageAsset,
    required this.destination,
    required this.dateLabel,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM yyyy').format(transaction.date);

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => destination)),
      child: Container(
        margin: const EdgeInsets.all(16),
        height: 160,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
              child: Image.asset(
                imageAsset,
                height: double.infinity,
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.description,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '$dateLabel: $formattedDate',
                      style: GoogleFonts.poppins(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

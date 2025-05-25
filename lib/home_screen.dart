import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mbanking_app_flutter/page/baratayudaaudio.dart';
import 'package:mbanking_app_flutter/page/ceritabaratayuda.dart';
import 'package:mbanking_app_flutter/page/film.dart';
import 'package:mbanking_app_flutter/page/suara.dart';
import 'package:mbanking_app_flutter/page/cerita.dart';
import 'package:mbanking_app_flutter/page/baratayudavideo.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
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
      print('Loaded language $langCode with keys: ${_localizedStrings.keys}');
    } catch (e) {
      print('Error loading language file: $e');
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
          style: const TextStyle(
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
                DropdownMenuItem(
                  value: 'id',
                  child: Text('ID', style: TextStyle(color: Colors.white)),
                ),
                DropdownMenuItem(
                  value: 'jv',
                  child: Text('JV', style: TextStyle(color: Colors.white)),
                ),
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
            _buildUserProfile(),
            _buildBalanceCard(),
            _buildTransactionHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Container(
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
                tr('profile_name'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(tr('profile_role')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber[500]!, Colors.amber[500]!],
        ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButton(Icons.book, 'cerita', tr('balance_card_cerita')),
              _buildActionButton(Icons.movie, 'film', tr('balance_card_film')),
              _buildActionButton(Icons.volume_up, 'suara', tr('balance_card_suara')),
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
          Text(displayLabel),
        ],
      ),
    );
  }

  Widget _buildTransactionHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            tr('last_activity'),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
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
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
      },
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
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '$dateLabel: $formattedDate',
                      style: const TextStyle(color: Colors.white70),
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:mbanking_app_flutter/page/transfer_page.dart';
import 'package:mbanking_app_flutter/page/terima_page.dart';
import 'package:mbanking_app_flutter/page/history_page.dart';
import 'package:mbanking_app_flutter/page/qrpay_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double balance = 1575000000.0;
  final List<Transaction> transactions = [
    Transaction(
      "Transfer ke BCA",
      -500000,
      DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      "Gaji Bulanan",
      12000000,
      DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      "Belanja Online",
      -1200000,
      DateTime.now().subtract(const Duration(days: 5)),
    ),
    Transaction(
      "Topup E-Wallet",
      -300000,
      DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'WayangKu',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber[500],
        elevation: 0,
        shape: const RoundedRectangleBorder(
          // borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
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
    color: Colors.amber,
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
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sandy Bimo H.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Mahasiswa UNY'),
          ],
        )
      ],
    ),
  );
}

  Widget _buildBalanceCard() {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButton(Icons.book, 'Cerita', Colors.amber),
              _buildActionButton(Icons.movie, 'Film', Colors.amber),
              _buildActionButton(Icons.volume_up, 'Suara', Colors.amber),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        switch (label) {
          case 'Cerita':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BaratayudaVideoPage()),
            );
            break;
          case 'Film':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TerimaPage()),
            );
            break;
          case 'Suara':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QrpayPage()),
            );
            break;
          case 'History':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistoryPage()),
            );
            break;
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildTransactionHistory() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const CardPerangBaratayuda(), 
      const CardPerang2(),// Tampilkan kartu di bawah transaksi
    ],
  );
}
}

// Pindah ke luar _HomeScreenState
class CardPerangBaratayuda extends StatelessWidget {
  const CardPerangBaratayuda({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BaratayudaVideoPage()),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(24),
        ),
        height: 160,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
              child: Image.asset(
                'assets/baratayuda.jpg',
                height: double.infinity,
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Perang\nBaratayuda',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardPerang2 extends StatelessWidget {
  const CardPerang2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(24),
      ),
      height: 160,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
            child: Image.asset(
              'assets/puntadewa.jpg',
              height: double.infinity,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Perang\nBaratayuda',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Transaction {
  final String description;
  final double amount;
  final DateTime date;

  Transaction(this.description, this.amount, this.date);
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mbanking_app_flutter/home_screen.dart';
import 'package:mbanking_app_flutter/page/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _currentLang = 'jv'; // Default Jawa

  final Map<String, Map<String, String>> localizedTexts = {
    'id': {
      'welcome': 'Selamat Datang\ndi WayangKu',
      'buttonLogin': 'Masuk',
      'buttonRegister': 'Daftar',
      'switchLang': 'Jawa',
    },
    'jv': {
      'welcome': 'Sugeng Rawuh\ning WayangKu',
      'buttonLogin': 'Mlebet',
      'buttonRegister': 'Ndaftar',
      'switchLang': 'Indonesia',
    },
  };

  void _toggleLanguage() {
    setState(() {
      _currentLang = _currentLang == 'id' ? 'jv' : 'id';
    });
  }

  @override
  Widget build(BuildContext context) {
    final texts = localizedTexts[_currentLang]!;

    return Scaffold(
      backgroundColor: const Color(0xFFFFC107),
      body: Stack(
        children: [
          // Gambar di belakang kontainer putih
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/orang.png',
                height: 300,
              ),
            ),
          ),

          // Konten Putih Lengkung di Bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: const BoxDecoration(
                color: Color(0xFFF9F5EC),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    texts['welcome']!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFC107),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tombol Login
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 6,
                      shadowColor: Colors.orangeAccent,
                    ),
                    child: Text(
                      texts['buttonLogin']!,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Tombol Register
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>RegisterScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Color(0xFFFFC107), width: 2),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      texts['buttonRegister']!,
                      style: GoogleFonts.poppins(
                        color: Color(0xFFFFC107),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tombol Switch Bahasa di kanan atas
          Positioned(
            top: 32,
            right: 24,
            child: TextButton(
              onPressed: _toggleLanguage,
              style: TextButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                texts['switchLang']!,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

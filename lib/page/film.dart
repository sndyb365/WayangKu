import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbanking_app_flutter/page/baratayudavideo.dart';

class FilmPage extends StatefulWidget {
  const FilmPage({Key? key}) : super(key: key);

  @override
  State<FilmPage> createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
  String _currentLangCode = 'id';
  Map<String, dynamic>? _langData;

  @override
  void initState() {
    super.initState();
    _loadLanguageFile(_currentLangCode);
  }

  Future<void> _loadLanguageFile(String langCode) async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/lang/$langCode.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      setState(() {
        _currentLangCode = langCode;
        _langData = jsonMap;
      });
    } catch (e) {
      // Jika gagal load file JSON, tetap fallback ke bahasa default
      print('Failed to load language file: $e');
      setState(() {
        _langData = null;
      });
    }
  }

  // Fungsi helper untuk mengambil value dari JSON berdasarkan key
  String tr(String key) {
    if (_langData != null && _langData!.containsKey(key)) {
      return _langData![key].toString();
    }
    return ''; // fallback kosong kalau key tidak ditemukan
  }

  @override
  Widget build(BuildContext context) {
    final List<String> filmImages = [
      'assets/ratna.jpg',
      'assets/warangkaning.jpg',
      'assets/kijang.jpg',
      'assets/wayangberdarah.jpg',
    ];

    final List<Widget> filmPages = [
      const BaratayudaVideoPage(),
      const BaratayudaVideoPage(),
      const BaratayudaVideoPage(),
      const BaratayudaVideoPage(),
    ];

    List<String> filmTitles = _langData != null && _langData!['films'] != null
        ? List<String>.from(_langData!['films'])
        : [
            'Ratna Kumala Alengka',
            'Warangkaning Syukur Marang Sang Hyang',
            'Kijang Kencana',
            'Kisah Wayang Berdarah',
          ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        _langData != null
                            ? (_langData!['titlee'] ?? 'Film Wayang')
                            : 'Film Wayang',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tr('subtitle').isNotEmpty
                            ? tr('subtitle')
                            : 'Tonton film-film wayang pilihan yang menghibur dan sarat makna.',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _currentLangCode,
                      dropdownColor: Colors.yellow[800],
                      icon: const Icon(Icons.language, color: Colors.white),
                      style: const TextStyle(color: Colors.white),
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
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: filmTitles.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (context, index) {
                    final title = filmTitles[index];
                    final image = filmImages[index];
                    final page = filmPages[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => page),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                              child: Image.asset(
                                image,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => page),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                _langData != null
                                    ? (_langData!['lihat'] ?? 'Tonton')
                                    : 'Tonton',
                                style: TextStyle(color: Colors.yellow[700]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

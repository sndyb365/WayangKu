import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Contoh halaman detail cerita wayang (bisa kamu ganti sesuai kebutuhan)
class CeritaDetailPage extends StatelessWidget {
  final String title;
  final String description;

  const CeritaDetailPage({Key? key, required this.title, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.yellow[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(description, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}

class CeritaPage extends StatefulWidget {
  const CeritaPage({Key? key}) : super(key: key);

  @override
  State<CeritaPage> createState() => _CeritaPageState();
}

class _CeritaPageState extends State<CeritaPage> {
  String _currentLangCode = 'id';
  Map<String, dynamic>? _langData;

  @override
  void initState() {
    super.initState();
    _loadLanguageFile(_currentLangCode);
  }

  Future<void> _loadLanguageFile(String langCode) async {
    try {
      final String jsonString = await rootBundle.loadString('assets/lang/$langCode.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      setState(() {
        _currentLangCode = langCode;
        _langData = jsonMap;
      });
    } catch (e) {
      print('Failed to load language file: $e');
      setState(() {
        _langData = null;
      });
    }
  }

  String tr(String key) {
    if (_langData != null && _langData!.containsKey(key)) {
      return _langData![key].toString();
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    // Contoh data gambar cerita wayang, sesuaikan dengan asetmu
    final List<String> ceritaImages = [
      'assets/petruk.jpg',
      'assets/baratayuda.jpg',
      'assets/gatot.jpg',
      'assets/ramayana.jpg',
    ];

    // Judul cerita dari JSON, fallback ke list default
    List<String> ceritaTitles = _langData != null && _langData!['ceritas'] != null
        ? List<String>.from(_langData!['ceritas'])
        : [
            'Petruk',
            'Perang Bharatayuda',
            'Lahirnya Gatotkaca',
            'Ramayana'
        ];

    // Deskripsi singkat dari JSON (optional), fallback ke kosong
    List<String> ceritaDescriptions = _langData != null && _langData!['descriptions'] != null
        ? List<String>.from(_langData!['descriptions'])
        : [
            'Kisah tentang lima bersaudara Pandawa yang gagah berani.',
            'Epik Ramayana dengan Rama dan Shinta.',
            'Perang besar di Mahabharata penuh intrik dan heroisme.',
            'Legenda pahlawan Gatotkaca dengan kekuatan super.',
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
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
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
                            ? (_langData!['titlecerita'] ?? 'Cerita Wayang')
                            : 'Cerita Wayang',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tr('subtitle').isNotEmpty
                            ? tr('subtitlecerita')
                            : 'Nikmati kisah-kisah wayang yang sarat makna dan budaya.',
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
                  itemCount: ceritaTitles.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (context, index) {
                    final title = ceritaTitles[index];
                    final image = ceritaImages[index];
                    final description = ceritaDescriptions.length > index ? ceritaDescriptions[index] : '';

                    return GestureDetector(
                      onTap: () {
                        // Buka halaman detail cerita
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CeritaDetailPage(
                              title: title,
                              description: description,
                            ),
                          ),
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
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                                  MaterialPageRoute(
                                    builder: (context) => CeritaDetailPage(
                                      title: title,
                                      description: description,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                _langData != null ? (_langData!['baca'] ?? 'Baca') : 'Baca',
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

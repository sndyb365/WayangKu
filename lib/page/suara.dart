import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbanking_app_flutter/page/baratayudavideo.dart';
import 'package:mbanking_app_flutter/page/baratayudaaudio.dart';

class SuaraPage extends StatefulWidget {
  const SuaraPage({Key? key}) : super(key: key);

  @override
  State<SuaraPage> createState() => _SuaraPageState();
}

class _SuaraPageState extends State<SuaraPage> {
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
    // Ambil list suara dari JSON, fallback ke default hardcoded kalau JSON belum siap
    List<dynamic> suaraListJson = _langData != null && _langData!['sounds'] != null
        ? _langData!['sounds']
        : [
            {
              'title': 'Ki Wahyu Dunung Raharjo – Lakon Brotoyudo',
              'image': 'assets/lakonbrotoyudo.jpg',
            },
            {
              'title': 'Ki Anom Suroto – Lakon Kresna Duta',
              'image': 'assets/lakonkresno.jpg',
            },
            {
              'title': 'Ki Hadi Sugito – Lakon Begawan Sukma Lelana',
              'image': 'assets/lakonbegawan.jpg',
            },
            {
              'title': 'Ki Anom Suroto – Lakon Bimo Labuh',
              'image': 'assets/lakonbimo.jpg',
            },
          ];

    // Karena widget tidak bisa disimpan di JSON, pasang ulang page secara manual dengan title:
    List<Map<String, dynamic>> suaraList = suaraListJson.map((item) {
      String title = item['title'] ?? '';
      Widget page = const BaratayudaVideoPage(); // default fallback

      if (title == 'Ki Wahyu Dunung Raharjo – Lakon Brotoyudo') {
        page = const BaratayudaAudioPage();
      } else if (title == 'Ki Anom Suroto – Lakon Kresna Duta') {
        page = const BaratayudaVideoPage();
      } else if (title == 'Ki Hadi Sugito – Lakon Begawan Sukma Lelana') {
        page = const BaratayudaVideoPage();
      } else if (title == 'Ki Anom Suroto – Lakon Bimo Labuh') {
        page = const BaratayudaVideoPage();
      }

      return {
        'title': title,
        'image': item['image'] ?? '',
        'page': page,
      };
    }).toList();

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
                        tr('titlesuara').isNotEmpty
                            ? tr('titlesuara')
                            : 'Suara Wayang',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tr('subtitlesuara').isNotEmpty
                            ? tr('subtitlesuara')
                            : 'Dengarkan Suara - Suara wayang pilihan yang menghibur dan sarat makna.',
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
                    onPressed: () => Navigator.pop(context),
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
                  itemCount: suaraList.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (context, index) {
                    final suara = suaraList[index];

                    String imagePath = suara['image'] ?? '';
                    String titleText = suara['title'] ?? 'Judul kosong';

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => suara['page']),
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
                              child: imagePath.isNotEmpty
                                  ? Image.asset(
                                      imagePath,
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      height: 120,
                                      color: Colors.grey,
                                      child: const Center(
                                        child: Text('No Image'),
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              titleText,
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
                                    builder: (context) => suara['page'],
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
                                tr('dengarkan').isNotEmpty
                                    ? tr('dengarkan')
                                    : 'Dengarkan',
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

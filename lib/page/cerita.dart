import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbanking_app_flutter/page/ceritabaratayuda.dart';
import 'package:mbanking_app_flutter/page/ceritagatot.dart';
import 'package:mbanking_app_flutter/page/ceritapetruk.dart';
import 'package:mbanking_app_flutter/page/ceritaramayana.dart';
import 'package:mbanking_app_flutter/page/petrukvideo.dart';
import 'package:mbanking_app_flutter/page/semarvideo.dart';
import 'package:mbanking_app_flutter/page/werkudaravideo.dart';
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
    final List<String> ceritaImages = [
      'assets/petruk.jpg',
      'assets/baratayuda.jpg',
      'assets/gatot.jpg',
      'assets/ramayana.jpg',
    ];

    List<String> ceritaTitles = _langData != null && _langData!['ceritas'] != null
        ? List<String>.from(_langData!['ceritas'])
        : ['Petruk', 'Perang Bharatayuda', 'Lahirnya Gatotkaca', 'Ramayana'];

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
                        tr('titlecerita').isNotEmpty ? tr('titlecerita') : 'Cerita Wayang',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tr('subtitlecerita').isNotEmpty
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
                        DropdownMenuItem(value: 'id', child: Text('ID')),
                        DropdownMenuItem(value: 'jv', child: Text('JV')),
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

                    // Arahkan ke halaman berbeda
                    void openDetailPage() {
                      Widget page;
                      switch (index) {
                        case 0:
                          page = const PetrukCeritaPage();
                          break;
                        case 1:
                          page = const BaratayudaCeritaPage();
                          break;
                        case 2:
                          page = const GatotkacaCeritaPage();
                          break;
                        case 3:
                          page = const RamayanaCeritaPage();
                          break;
                        default:
                          page = const BaratayudaCeritaPage();
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => page),
                      );
                    }

                    return GestureDetector(
                      onTap: openDetailPage,
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
                              onPressed: openDetailPage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                tr('baca').isNotEmpty ? tr('baca') : 'Baca',
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

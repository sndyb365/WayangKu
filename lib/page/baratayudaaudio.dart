import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BaratayudaAudioPage extends StatefulWidget {
  const BaratayudaAudioPage({super.key});

  @override
  State<BaratayudaAudioPage> createState() => _BaratayudaAudioPageState();
}

class _BaratayudaAudioPageState extends State<BaratayudaAudioPage> {
  final AudioPlayer _player = AudioPlayer();
  bool _isMicOn = false;
  String _selectedLanguage = 'id';

  final Map<String, String> cerita = {
    'id': '''Perang Baratayuda adalah perang saudara besar-besaran antara keluarga Pandawa dan Kurawa, klimaks dari kisah Mahabharata, yang diadaptasi di Indonesia sebagai wayang dan kakawin. Perang ini merupakan perebutan kekuasaan antara kedua keluarga keturunan Barata, dengan Pandawa sebagai lambang kebaikan dan Kurawa sebagai lambang kejahatan.''',
    'jv': '''Perang Baratayuda iku perang saudara gedhe antarane kulawarga Pandawa lan Kurawa, dadi puncak saka crita Mahabharata, sing diadaptasi ing Indonesia dadi wayang lan kakawin. Perang iki dadi rebutan panguwasa antarane loro kulawarga keturunan Barata, kanthi Pandawa dadi lambang kabecikan lan Kurawa dadi lambang ala.''',
  };

  void _toggleMic() async {
    if (_isMicOn) {
      await _player.pause();
    } else {
      await _player.play(AssetSource('lakonbrotoyudo.mp3'));
    }

    setState(() {
      _isMicOn = !_isMicOn;
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 240,
                  width: double.infinity,
                  color: Colors.black12,
                ),
                IconButton(
                  iconSize: 96,
                  icon: Icon(
                    _isMicOn ? Icons.mic_off : Icons.mic,
                    color: Colors.orange,
                  ),
                  onPressed: _toggleMic,
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                    child: const Text(
                      'Kembali',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: PopupMenuButton<String>(
                    icon: Icon(Icons.language, color: Colors.yellow[700]),
                    onSelected: (value) {
                      setState(() {
                        _selectedLanguage = value;
                      });
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem<String>(
                        value: 'id',
                        child: Container(
                          color: Colors.orange[400],
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.center,
                          child: const Text(
                            'ID',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'jv',
                        child: Container(
                          color: Colors.orange[600],
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.center,
                          child: const Text(
                            'JV',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                    color: Colors.transparent,
                    elevation: 0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Perang Baratayuda',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    cerita[_selectedLanguage]!,
                    style: TextStyle(
                      color: Colors.orange[800],
                      fontSize: 14,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WerkudaraVideoPage extends StatefulWidget {
  const WerkudaraVideoPage({super.key});

  @override
  State<WerkudaraVideoPage> createState() => _WerkudaraVideoPageState();
}

class _WerkudaraVideoPageState extends State<WerkudaraVideoPage> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  String _currentLang = 'id';

  final Map<String, Map<String, String>> localizedTexts = {
    'id': {
      'title': 'Cerita Werkudara',
      'description':
          'Werkudara, atau Bima, adalah salah satu tokoh Pandawa dalam cerita wayang. Ia dikenal dengan kekuatan luar biasa, keberanian, dan kesetiaan yang tinggi. Werkudara sering menjadi pelindung dan pejuang utama dalam berbagai peperangan.',
      'back': 'Kembali',
      'langButton': 'Jawa',
    },
    'jv': {
      'title': 'Crita Werkudara',
      'description':
          'Werkudara, utawa Bima, iku salah siji tokoh Pandawa ing crita wayang. Dheweke dikenal kanthi kekuwatan gedhe, keberanian, lan kesetiaan sing dhuwur. Werkudara kerep dadi pelindung lan pejuang utama ing macem-macem peperangan.',
      'back': 'Bali',
      'langButton': 'Indonesia',
    },
  };

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/werkudoro.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
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
                _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Container(
                        height: 200,
                        color: Colors.black12,
                      ),
                IconButton(
                  iconSize: 64,
                  icon: Icon(
                    _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                    color: Colors.yellow[700],
                  ),
                  onPressed: _togglePlayPause,
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _currentLang = _currentLang == 'id' ? 'jv' : 'id';
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.yellow[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                    child: Text(
                      localizedTexts[_currentLang]!['langButton']!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
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
                    child: Text(
                      localizedTexts[_currentLang]!['back']!,
                      style: const TextStyle(color: Colors.white),
                    ),
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
                boxShadow: const [
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
                    child: Text(
                      localizedTexts[_currentLang]!['title']!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    localizedTexts[_currentLang]!['description']!,
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

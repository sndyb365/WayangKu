import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BaratayudaVideoPage extends StatefulWidget {
  const BaratayudaVideoPage({super.key});

  @override
  State<BaratayudaVideoPage> createState() => _BaratayudaVideoPageState();
}

class _BaratayudaVideoPageState extends State<BaratayudaVideoPage> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  String _selectedLanguage = 'id';

  final Map<String, String> descriptions = {
    'id': '''Perang Baratayuda adalah perang saudara besar-besaran antara keluarga Pandawa dan Kurawa, klimaks dari kisah Mahabharata, yang diadaptasi di Indonesia sebagai wayang dan kakawin. Perang ini merupakan perebutan kekuasaan antara kedua keluarga keturunan Barata, dengan Pandawa sebagai lambang kebaikan dan Kurawa sebagai lambang kejahatan.''',
    'jv': '''Perang Baratayuda yaiku perang gedhé antarane kulawarga Pandhawa lan Kurawa, pucuking konflik saka epos Mahabharata sing diadaptasi dadi wayang lan kakawin ing Indonesia. Perang iki dadi perebutan kuwasa antarane kulawarga keturunan Barata, kanthi Pandhawa minangka lambang becik lan Kurawa minangka lambang ala.''',
  };

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/vodb.mp4')
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
                    descriptions[_selectedLanguage] ?? descriptions['id']!,
                    style: TextStyle(
                      color: Colors.amber[400],
                      fontSize: 14,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

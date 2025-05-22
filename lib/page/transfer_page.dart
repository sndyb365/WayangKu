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
                    'Perang Baratayuda adalah perang saudara besar-besaran antara keluarga Pandawa dan Kurawa, klimaks dari kisah Mahabharata, yang diadaptasi di Indonesia sebagai wayang dan kakawin. Perang ini merupakan perebutan kekuasaan antara kedua keluarga keturunan Barata, dengan Pandawa sebagai lambang kebaikan dan Kurawa sebagai lambang kejahatan.',
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
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.palette),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: '',
          ),
        ],
      ),
    );
  }
}
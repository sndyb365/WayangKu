import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbanking_app_flutter/page/baratayudavideo.dart';
import 'package:mbanking_app_flutter/page/petrukvideo.dart';
import 'package:mbanking_app_flutter/page/werkudaravideo.dart';
import 'package:mbanking_app_flutter/page/semarvideo.dart';
import 'package:video_player/video_player.dart';

// Halaman detail film dengan video player
class FilmDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final String videoUrl;

  const FilmDetailPage({
    Key? key,
    required this.title,
    required this.description,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<FilmDetailPage> createState() => _FilmDetailPageState();
}

class _FilmDetailPageState extends State<FilmDetailPage> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.yellow[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(widget.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            _isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : const CircularProgressIndicator(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman film utama
class FilmPage extends StatefulWidget {
  const FilmPage({Key? key}) : super(key: key);

  @override
  State<FilmPage> createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
  Map<String, dynamic>? _langData;
  String _currentLangCode = 'id';

  @override
  void initState() {
    super.initState();
    _loadLanguageFile(_currentLangCode);
  }

  Future<void> _loadLanguageFile(String langCode) async {
    try {
      final jsonString = await rootBundle.loadString('assets/lang/$langCode.json');
      final jsonMap = json.decode(jsonString);
      setState(() {
        _langData = jsonMap;
        _currentLangCode = langCode;
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
    List<dynamic> films = _langData != null && _langData!['films'] != null
        ? _langData!['films']
        : [
            {
              "title": "Petruk",
              "description": "Petruk adalah salah satu tokoh punakawan dalam cerita wayang, dikenal lucu dan jenaka.",
              "image": "assets/petruk.jpg",
              "video_url": "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4"
            },
            {
              "title": "Baratayuda",
              "description": "Cerita perang besar Baratayuda antara keluarga Pandawa dan Kurawa dalam Mahabharata.",
              "image": "assets/baratayuda.jpg",
              "video_url": "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4"
            },
            {
              "title": "Werkudara",
              "description": "Werkudara atau Bima adalah salah satu tokoh Pandawa dengan kekuatan luar biasa.",
              "image": "assets/werkudoro.jpg",
              "video_url": "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4"
            },
          ];

    // Fungsi menentukan halaman tujuan berdasarkan indeks film
    Widget getPageForFilm(int idx) {
      switch (idx) {
        case 0:
          return PetrukVideoPage();
        case 1:
          return BaratayudaVideoPage();
        case 2:
          return WerkudaraVideoPage();
        default:
          final film = films[idx];
          return FilmDetailPage(
            title: film['title'],
            description: film['description'],
            videoUrl: film['video_url'],
          );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    _langData != null ? (_langData!['titlefilm'] ?? 'Film Wayang') : 'Film Wayang',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _currentLangCode,
                      dropdownColor: Colors.yellow[800],
                      icon: const Icon(Icons.language, color: Colors.white),
                      style: const TextStyle(color: Colors.white),
                      items: const [
                        DropdownMenuItem(value: 'id', child: Text('ID', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 'jv', child: Text('JV', style: TextStyle(color: Colors.white))),
                      ],
                      onChanged: (value) {
                        if (value != null && value != _currentLangCode) {
                          _loadLanguageFile(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: films.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (context, index) {
                    final film = films[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => getPageForFilm(index)),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 4)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: Image.asset(
                                film['image'],
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              film['title'],
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
                                  MaterialPageRoute(builder: (context) => getPageForFilm(index)),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                _langData != null ? (_langData!['tonton'] ?? 'Tonton') : 'Tonton',
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

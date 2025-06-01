import 'package:flutter/material.dart';

class RamayanaCeritaPage extends StatefulWidget {
  const RamayanaCeritaPage({super.key});

  @override
  State<RamayanaCeritaPage> createState() => _RamayanaCeritaPageState();
}

class _RamayanaCeritaPageState extends State<RamayanaCeritaPage> {
  String _selectedLanguage = 'id';

  final Map<String, String> cerita = {
    'id': '''Ramayana adalah epik kuno yang berasal dari India dan sangat populer di Indonesia, terutama dalam budaya Jawa dan Bali. Cerita ini mengisahkan petualangan Rama, seorang pangeran yang berani dan berbakti, dalam menyelamatkan istrinya, Sinta, dari cengkeraman Rahwana, raja raksasa.

Ramayana mengandung nilai-nilai moral dan spiritual yang mendalam, seperti kesetiaan, keberanian, dan pengorbanan. Cerita ini juga menampilkan berbagai tokoh penting seperti Hanuman, si kera sakti yang setia membantu Rama, serta Laksmana, saudara Rama yang selalu mendampingi.

Melalui perjalanan panjang dan penuh rintangan, Ramayana mengajarkan tentang pentingnya kebenaran dan keadilan dalam kehidupan, serta kekuatan cinta dan pengabdian.

Cerita Ramayana tidak hanya menjadi karya sastra, tapi juga menjadi bagian penting dari pertunjukan wayang dan seni tradisional di Nusantara.''',

    'jv': '''Ramayana iku sawijining epik kuna saka India sing banget misuwur ing Indonesia, utamane ing budaya Jawa lan Bali. Crita iki nyritakake petualangan Rama, sawijining pangeran sing wani lan setya, kanggo nylametake bojone, Sinta, saka tangan Rahwana, raja raksasa.

Ramayana ngemot nilai-nilai moral lan spiritual sing jero, kaya kesetiaan, keberanian, lan pengorbanan. Crita iki uga nampilake tokoh-tokoh penting kaya Hanuman, kera sakti sing setya nulungi Rama, lan Laksmana, sedulur Rama sing tansah ngetutake.

Liwat perjalanan sing dawa lan kebak tantangan, Ramayana mulangake babagan pentinge bebener lan keadilan ing urip, uga kekuwatan katresnan lan pengabdian.

Crita Ramayana ora mung dadi karya sastra, nanging uga dadi bagean penting saka pagelaran wayang lan seni tradisional ing Nusantara.''',
  };

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
                  width: double.infinity,
                  height: 200,
                  color: Colors.yellow[100],  // warna asli tetap kuning muda
                  child: Center(
                    child: Icon(
                      Icons.book,  // icon cerita klasik
                      size: 72,
                      color: Colors.yellow[700],  // kuning tua seperti aslinya
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[700],  // kuning tua
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
                    icon: Icon(Icons.language, color: Colors.yellow[700]),  // warna asli
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
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
                          color: Colors.yellow[700],  // kuning tua
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'Cerita Ramayana',
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
                          color: Colors.amber[400],  // kuning keemasan
                          fontSize: 14,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

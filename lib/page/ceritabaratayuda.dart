import 'package:flutter/material.dart';

class BaratayudaCeritaPage extends StatefulWidget {
  const BaratayudaCeritaPage({super.key});

  @override
  State<BaratayudaCeritaPage> createState() => _BaratayudaCeritaPageState();
}

class _BaratayudaCeritaPageState extends State<BaratayudaCeritaPage> {
  String _selectedLanguage = 'id';

  final Map<String, String> cerita = {
    'id': '''Perang Baratayuda adalah perang besar antara dua kelompok keluarga keturunan Raja Bharata, yaitu Pandawa dan Kurawa. Peristiwa ini merupakan puncak konflik dalam epos Mahabharata yang telah menjadi warisan budaya besar di Asia, termasuk diadaptasi dalam bentuk wayang di Indonesia.

Cerita dimulai dari sengketa takhta Hastinapura antara Pandawa dan Kurawa. Kurawa, dipimpin oleh Duryodana, tidak ingin berbagi kekuasaan dengan Pandawa, meskipun Pandawa memiliki hak yang sah. Ketegangan terus meningkat, hingga akhirnya Pandawa diasingkan selama 13 tahun, dan setelah kembali mereka ditolak untuk mendapatkan bagian kerajaan yang dijanjikan.

Dalam Baratayuda, setiap tokoh memainkan peran penting. Arjuna, pendekar Pandawa, harus berhadapan dengan guru dan kerabatnya sendiri. Bhisma, panglima Kurawa, tidak bisa melawan Pandawa sepenuh hati. Drona, guru besar Pandawa dan Kurawa, berada dalam dilema moral. Karna, saudara tertua Pandawa yang berpihak pada Kurawa, menunjukkan kesetiaannya meskipun harus menentang darahnya sendiri.

Perang berlangsung selama 18 hari dan memakan banyak korban jiwa dari kedua belah pihak. Banyak ksatria besar gugur, termasuk Abimanyu (putra Arjuna), Bhisma, Drona, Karna, dan bahkan Duryodana sendiri. Di hari terakhir, Bima berhasil mengalahkan Duryodana dalam pertempuran satu lawan satu, menandai akhir perang dan kemenangan Pandawa.

Namun kemenangan ini bukan tanpa duka. Hampir semua generasi tua dan penerus kerajaan tewas. Pandawa memerintah dengan hati yang pilu, sadar bahwa perang ini meninggalkan luka mendalam.

Cerita Baratayuda mengajarkan nilai tentang kebenaran, keadilan, pengorbanan, dan harga dari ambisi dan permusuhan. Di dalam dunia pewayangan Indonesia, kisah ini menjadi refleksi moral dan spiritual yang dituturkan secara turun-temurun, membentuk jati diri budaya dan etika masyarakat nusantara.''',
    'jv': '''Perang Baratayuda yaiku perang gedhé antara kulawarga Pandhawa lan Kurawa, keturunan Raja Bharata. Cerita iki dadi pucuking konflik saka epos Mahabharata lan wis dadi warisan budaya ing Asia, kalebu Indonesia kanthi wujud pewayangan.

Cerita diwiwiti saka rebutan tahta Hastinapura antarane Pandhawa lan Kurawa. Kurawa, dipimpin Duryodana, ora gelem nuduhake kuwasa karo Pandhawa sanadyan Pandhawa nduweni hak. Ketegangan mundhak terus, nganti Pandhawa diusir nganti 13 taun lan nalika bali, ditolak haké.

Saben tokoh nduweni peran penting. Arjuna kudu ngadhepi guru lan seduluré. Bhisma ora bisa perang kanthi sepenuh ati. Drona kebingungan moral. Karna, sedulur tuwa Pandhawa, tetep setya marang Kurawa sanadyan nglawan getihé dhewe.

Perang nganti 18 dina lan nyebabake akeh korban. Ksatria kayata Abimanyu, Bhisma, Drona, Karna, lan Duryodana mati. Ing akhiré, Bima ngalahaké Duryodana.

Senadyan menang, Pandhawa tetep sedhih amarga akeh korban. Cerita iki ngajari nilai kejujuran, adil, pengorbanan, lan akibat saka ambisi. Ing pewayangan Jawa, Baratayuda dadi piwulang moral lan spiritual turun-temurun.''',
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
                  color: Colors.yellow[100],
                  child: Center(
                    child: Icon(
                      Icons.menu_book,
                      size: 72,
                      color: Colors.yellow[700],
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
  color: Colors.transparent, // agar warna Container terlihat
  elevation: 0, // hilangkan bayangan jika ingin flat
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
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'Cerita Baratayuda',
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
                          color: Colors.amber[400],
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

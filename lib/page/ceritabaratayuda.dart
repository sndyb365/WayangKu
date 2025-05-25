import 'package:flutter/material.dart';

class BaratayudaCeritaPage extends StatelessWidget {
  const BaratayudaCeritaPage({super.key});

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
                        '''Perang Baratayuda adalah perang besar antara dua kelompok keluarga keturunan Raja Bharata, yaitu Pandawa dan Kurawa. Peristiwa ini merupakan puncak konflik dalam epos Mahabharata yang telah menjadi warisan budaya besar di Asia, termasuk diadaptasi dalam bentuk wayang di Indonesia.

Cerita dimulai dari sengketa takhta Hastinapura antara Pandawa dan Kurawa. Kurawa, dipimpin oleh Duryodana, tidak ingin berbagi kekuasaan dengan Pandawa, meskipun Pandawa memiliki hak yang sah. Ketegangan terus meningkat, hingga akhirnya Pandawa diasingkan selama 13 tahun, dan setelah kembali mereka ditolak untuk mendapatkan bagian kerajaan yang dijanjikan.

Dalam Baratayuda, setiap tokoh memainkan peran penting. Arjuna, pendekar Pandawa, harus berhadapan dengan guru dan kerabatnya sendiri. Bhisma, panglima Kurawa, tidak bisa melawan Pandawa sepenuh hati. Drona, guru besar Pandawa dan Kurawa, berada dalam dilema moral. Karna, saudara tertua Pandawa yang berpihak pada Kurawa, menunjukkan kesetiaannya meskipun harus menentang darahnya sendiri.

Perang berlangsung selama 18 hari dan memakan banyak korban jiwa dari kedua belah pihak. Banyak ksatria besar gugur, termasuk Abimanyu (putra Arjuna), Bhisma, Drona, Karna, dan bahkan Duryodana sendiri. Di hari terakhir, Bima berhasil mengalahkan Duryodana dalam pertempuran satu lawan satu, menandai akhir perang dan kemenangan Pandawa.

Namun kemenangan ini bukan tanpa duka. Hampir semua generasi tua dan penerus kerajaan tewas. Pandawa memerintah dengan hati yang pilu, sadar bahwa perang ini meninggalkan luka mendalam.

Cerita Baratayuda mengajarkan nilai tentang kebenaran, keadilan, pengorbanan, dan harga dari ambisi dan permusuhan. Di dalam dunia pewayangan Indonesia, kisah ini menjadi refleksi moral dan spiritual yang dituturkan secara turun-temurun, membentuk jati diri budaya dan etika masyarakat nusantara.''',
                        style: TextStyle(
                          color: Colors.amber[700],
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

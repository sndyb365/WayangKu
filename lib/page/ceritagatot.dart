import 'package:flutter/material.dart';

class GatotkacaCeritaPage extends StatefulWidget {
  const GatotkacaCeritaPage({super.key});

  @override
  State<GatotkacaCeritaPage> createState() => _GatotkacaCeritaPageState();
}

class _GatotkacaCeritaPageState extends State<GatotkacaCeritaPage> {
  String _selectedLanguage = 'id';

  final Map<String, String> cerita = {
    'id': '''Gatotkaca adalah salah satu tokoh punakawan dalam dunia pewayangan Jawa yang dikenal memiliki kekuatan luar biasa dan kemampuan terbang. Ia adalah putra Bima dan Arimbi, yang memiliki sifat gagah berani dan setia.

Dalam kisah pewayangan, Gatotkaca sering menjadi pahlawan yang melindungi para ksatria dan rakyat dari bahaya. Kekuatannya yang dahsyat dan kemampuan terbangnya membuatnya menjadi sosok yang sangat dihormati.

Gatotkaca juga melambangkan keberanian, pengorbanan, dan kekuatan jiwa dalam menghadapi segala rintangan. Ia mengajarkan bahwa kekuatan sejati datang dari ketulusan hati dan keberanian untuk melawan kejahatan.

Cerita Gatotkaca sering dipentaskan dalam wayang kulit dan menjadi bagian penting dalam budaya Jawa sebagai simbol kepahlawanan dan nilai-nilai moral.''',

    'jv': '''Gatotkaca iku salah siji tokoh punakawan ing donya pewayangan Jawa sing dikenal nduweni kekuatan gedhe lan bisa mabur. Dheweke putrane Bima lan Arimbi, sing nduweni sifat gagah lan setya.

Ing crita pewayangan, Gatotkaca kerep dadi pahlawan sing nglindhungi para ksatria lan rakyat saka bebaya. Kekuatan lan kemampuan mabure nggawe dheweke dadi sosok sing banget dihormati.

Gatotkaca uga dadi lambang keberanian, pengorbanan, lan kekuwatan jiwa kanggo ngadhepi rintangan. Dheweke mulangake yen kekuatan sejati asalé saka tulus ati lan keberanian nglawan ala.

Crita Gatotkaca asring dipentasake ing wayang kulit lan dadi bagean penting ing budaya Jawa minangka simbol kepahlawanan lan nilai-nilai moral.''',
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
                      Icons.person,
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
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'Cerita Gatotkaca',
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

import 'package:flutter/material.dart';

class PetrukCeritaPage extends StatefulWidget {
  const PetrukCeritaPage({super.key});

  @override
  State<PetrukCeritaPage> createState() => _PetrukCeritaPageState();
}

class _PetrukCeritaPageState extends State<PetrukCeritaPage> {
  String _selectedLanguage = 'id';

  final Map<String, String> cerita = {
    'id': '''Petruk adalah salah satu punakawan dalam dunia pewayangan Jawa, dikenal sebagai sosok lucu, cerdas, dan penuh satire. Bersama Semar, Gareng, dan Bagong, Petruk tidak hanya berfungsi sebagai pelawak, tapi juga sebagai simbol rakyat kecil yang penuh kebijaksanaan.

Meski tampilannya lucu dan kadang konyol, Petruk sering menyuarakan kebenaran dengan cara yang sederhana namun tajam. Ia menjadi jembatan antara dunia para ksatria dan rakyat biasa, menyampaikan kritik sosial melalui humor.

Dalam beberapa versi cerita, Petruk pernah menjadi raja dalam kisah “Petruk Dadi Ratu”, yang menyindir kekuasaan dan keserakahan. Kisah ini menggambarkan bagaimana seorang punakawan bisa menjadi pemimpin, namun tetap menghadapi berbagai tantangan dan godaan.

Karakter Petruk mengajarkan bahwa kebijaksanaan tidak selalu datang dari para bangsawan atau tokoh besar, tetapi bisa lahir dari mereka yang sederhana, yang melihat dunia dengan hati dan nalar.''',

    'jv': '''Petruk iku salah siji punakawan ing pewayangan Jawa, misuwur amarga lucu, pinter, lan kerep nggunakake guyonan kanggo nyritakake kawicaksanan. Bareng Semar, Gareng, lan Bagong, Petruk dadi lambang rakyat cilik kang nduweni kawruh lan kritik sosial.

Sanadyan katon lucu lan asring guyon, Petruk kerep nyritakake kebenaran kanthi cara sing gampang dingerteni nanging ngena. Dheweke dadi jembatan antarane para ksatria lan rakyat biasa.

Ing salah siji cerita, Petruk tau dadi ratu ing cerita “Petruk Dadi Ratu”, kang nyindir prakara kekuwatan lan keserakahan. Cerita iki ngandharake kepiye punakawan bisa dadi pimpinan nanging tetep ketemu tantangan.

Petruk ngajari kita yen kawicaksanan bisa teka saka wong kang prasaja, ora kudu saka bangsawan utawa pahlawan, nanging saka ati lan pikiran sing bening.''',
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
                          'Cerita Petruk',
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

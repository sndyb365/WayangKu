import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mbanking_app_flutter/page/kuisresultpage.dart';

class KuisPage extends StatefulWidget {
  const KuisPage({Key? key}) : super(key: key);

  @override
  State<KuisPage> createState() => _KuisPageState();
}

class _KuisPageState extends State<KuisPage> {
  String? _language; // 'id' atau 'jv'
  int _currentIndex = 0;
  int _score = 0;
  List<int> _answers = [];
  late List<Map<String, dynamic>> _questions;

  @override
  void initState() {
    super.initState();
    _showLanguageDialog();
  }

  void _showLanguageDialog() async {
    await Future.delayed(Duration.zero);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        actionsPadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        actions: [
          // Bahasa Indonesia - di atas, teks kuning bg hitam
          GestureDetector(
            onTap: () {
              Navigator.pop(ctx);
              _setLanguage('id');
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: Colors.black,
              alignment: Alignment.center,
              child: Text(
                'Bahasa Indonesia',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.yellow[700],
                ),
              ),
            ),
          ),
          // Boso Jowo - di bawah, teks hitam bg kuning
          GestureDetector(
            onTap: () {
              Navigator.pop(ctx);
              _setLanguage('jv');
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: Colors.yellow[700],
              alignment: Alignment.center,
              child: Text(
                'Boso Jowo',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _setLanguage(String lang) {
    setState(() {
      _language = lang;

      final questionsId = [
        {
          'question':
              '1. Apa nama tokoh wayang yang terkenal memiliki kekuatan luar biasa dan merupakan anak dari Bima?',
          'options': ['Nakula', 'Abimanyu', 'Gatotkaca', 'Arjuna', 'Werkudara'],
          'answerIndex': 2,
        },
        {
          'question': '2. Wayang golek biasanya dipertunjukkan dalam budaya daerah...',
          'options': ['Jawa Timur', 'Madura', 'Bali', 'Jawa Barat', 'Kalimantan'],
          'answerIndex': 3,
        },
        {
          'question': '3. Siapakah yang menciptakan tokoh-tokoh Punakawan dalam pewayangan Jawa?',
          'options': ['Empu Tantular', 'Empu Kanwa', 'Sunan Kalijaga', 'Dalem Walisanga', 'Sultan Agung'],
          'answerIndex': 2,
        },
        {
          'question': '4. Dalam pertunjukan wayang, gamelan berfungsi sebagai...',
          'options': [
            'Penerjemah bahasa Jawa kuno',
            'Iringan musik untuk menghidupkan suasana',
            'Pencipta efek suara alam',
            'Penunjuk waktu pertunjukan',
            'Alat untuk mengontrol wayang'
          ],
          'answerIndex': 1,
        },
        {
          'question': '5. Cerita Ramayana dalam pewayangan menceritakan tentang...',
          'options': [
            'Perang antara Pandawa dan Kurawa',
            'Kisah Dewa Ruci',
            'Perjalanan Raden Rama menyelamatkan Dewi Shinta',
            'Kehidupan Raja Sulaiman',
            'Pendirian kerajaan Hastinapura'
          ],
          'answerIndex': 2,
        },
        {
          'question': '6. Dalang dalam pertunjukan wayang memiliki peran sebagai...',
          'options': [
            'Pemain gamelan',
            'Pengatur penonton',
            'Penyanyi tembang',
            'Pencerita dan penggerak tokoh wayang',
            'Penjual tiket pertunjukan'
          ],
          'answerIndex': 3,
        },
        {
          'question': '7. Berikut ini yang merupakan jenis wayang yang terbuat dari kulit kerbau adalah...',
          'options': ['Wayang golek', 'Wayang wong', 'Wayang topeng', 'Wayang klithik', 'Wayang kulit'],
          'answerIndex': 4,
        },
        {
          'question': '8. Tokoh Semar dalam wayang Jawa dikenal sebagai...',
          'options': [
            'Ksatria pemberani dari Kurawa',
            'Raja para dewa',
            'Punakawan yang bijaksana',
            'Anak dari Batara Guru',
            'Musuh utama para Pandawa'
          ],
          'answerIndex': 2,
        },
        {
          'question': '9. Berikut ini yang bukan termasuk tokoh Punakawan adalah...',
          'options': ['Semar', 'Gareng', 'Petruk', 'Bagong', 'Sengkuni'],
          'answerIndex': 4,
        },
        {
          'question': '10. Wayang kulit biasanya dipertunjukkan pada waktu...',
          'options': ['Pagi hari', 'Siang hari', 'Malam hingga dini hari', 'Sore hari', 'Waktu subuh'],
          'answerIndex': 2,
        },
      ];

      final questionsJv = [
        {
          'question':
              '1. Apa jeneng tokoh wayang sing kondhang nduwe kekuwatan gedhe lan anaké Bima?',
          'options': ['Nakula', 'Abimanyu', 'Gatotkaca', 'Arjuna', 'Werkudara'],
          'answerIndex': 2,
        },
        {
          'question': '2. Wayang golek biasane dipentaské nang budaya daerah...',
          'options': ['Jawa Timur', 'Madura', 'Bali', 'Jawa Barat', 'Kalimantan'],
          'answerIndex': 3,
        },
        {
          'question': '3. Sopo sing nggawe tokoh-tokoh Punakawan nang pewayangan Jawa?',
          'options': ['Empu Tantular', 'Empu Kanwa', 'Sunan Kalijaga', 'Dalem Walisanga', 'Sultan Agung'],
          'answerIndex': 2,
        },
        {
          'question': '4. Nang pagelaran wayang, gamelan gunane kanggo...',
          'options': [
            'Nerjemah basa Jawa kuna',
            'Iringan musik kanggo ngurip-urip suasana',
            'Nggawe efek swara alam',
            'Nandhani wektu pagelaran',
            'Piranti kanggo ngontrol wayang'
          ],
          'answerIndex': 1,
        },
        {
          'question': '5. Crita Ramayana nang pewayangan nyritakaké bab...',
          'options': [
            'Perang antara Pandawa lan Kurawa',
            'Crita Dewa Ruci',
            'Perjalanan Raden Rama nylametaké Dewi Shinta',
            'Kehidupan Raja Sulaiman',
            'Pendirian kraton Hastinapura'
          ],
          'answerIndex': 2,
        },
        {
          'question': '6. Dalang nang pagelaran wayang nduwé peran minangka...',
          'options': [
            'Pemain gamelan',
            'Pengatur penonton',
            'Panyanyi tembang',
            'Pencerita lan penggerak tokoh wayang',
            'Penjual tiket pagelaran'
          ],
          'answerIndex': 3,
        },
        {
          'question': '7. Iki sing kalebu jinis wayang saka kulit kerbau yaiku...',
          'options': ['Wayang golek', 'Wayang wong', 'Wayang topeng', 'Wayang klithik', 'Wayang kulit'],
          'answerIndex': 4,
        },
        {
          'question': '8. Tokoh Semar nang wayang Jawa dikenal minangka...',
          'options': [
            'Ksatria berani saka Kurawa',
            'Raja para dewa',
            'Punakawan sing bijaksana',
            'Anak saka Batara Guru',
            'Mungsuh utama para Pandawa'
          ],
          'answerIndex': 2,
        },
        {
          'question': '9. Iki sing ora klebu tokoh Punakawan yaiku...',
          'options': ['Semar', 'Gareng', 'Petruk', 'Bagong', 'Sengkuni'],
          'answerIndex': 4,
        },
        {
          'question': '10. Wayang kulit biasane dipentaské nang wektu...',
          'options': ['Esuk', 'Siang', 'Bengi nganti esuk', 'Sore', 'Wektu subuh'],
          'answerIndex': 2,
        },
      ];

      _questions = lang == 'jv' ? questionsJv : questionsId;

      _currentIndex = 0;
      _score = 0;
      _answers.clear();
    });
  }

  void _answerQuestion(int selectedIndex) async {
    _answers.add(selectedIndex);

    if (selectedIndex == _questions[_currentIndex]['answerIndex']) {
      _score++;
    }

    if (_currentIndex == _questions.length - 1) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('last_quiz_score', _score);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => KuisResultPage(
            score: _score,
            total: _questions.length,
            answers: _answers,
            questions: _questions,
          ),
        ),
      );
    } else {
      setState(() {
        _currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_language == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _language == 'jv' ? 'Kuis Wayang (Boso Jowo)' : 'Kuis Wayang',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.yellow[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _language == 'jv'
                  ? 'Pitakonan ${_currentIndex + 1} saka ${_questions.length}'
                  : 'Soal ${_currentIndex + 1} dari ${_questions.length}',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              question['question'],
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ...List.generate(question['options'].length, (index) {
              final option = question['options'][index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[700],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _answerQuestion(index),
                  child: Text(
                    option,
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

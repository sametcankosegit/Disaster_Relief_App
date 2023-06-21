import 'package:disaster_relief_v2/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/drawer_header_widget/contact_us_page/contact_us_page.dart';

class QuestionsPage extends StatefulWidget {
  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void saveAnswers(List<String> answers) async {
    try {
      await _firestore.collection('user_answers').add({
        'answers': answers,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Cevaplar kaydedildi.');
    } catch (e) {
      print('Hata: $e');
    }
  }

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Afetler hakkında ne kadar bir bilgiye sahipsin?',
      'options': ['Çok', 'Orta', 'Az', 'Hiç']
    },
    {
      'question':
          'Uygulamamızın afetler hakkında size ne kadar katkısı olduğunu düşünüyorsunuz?',
      'options': ['Çok', 'Orta', 'Az', 'Hiç']
    },
    {
      'question':
          'Uygulamamızı beğendiniz mi? Beğenmediğiz yerleri bize bildirin.',
      'options': [
        'Beğendim',
        'Emin Değilim',
        'Beğenmedim',
        'Geliştirilmesi Gerek'
      ]
    },
  ];

  String? _selectedOption1;
  String? _selectedOption2;
  String? _selectedOption3;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SORULAR'),
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 192, 129, 252),
                  Color.fromARGB(255, 216, 101, 130),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_morning.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 225, 245, 255),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      offset: const Offset(2, 2),
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < _questions.length; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _questions[i]['question'],
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 8.0),
                          for (var j = 0;
                              j < _questions[i]['options'].length;
                              j++)
                            RadioListTile(
                              title: Text(_questions[i]['options'][j]),
                              value: _questions[i]['options'][j],
                              groupValue: i == 0
                                  ? _selectedOption1
                                  : i == 1
                                      ? _selectedOption2
                                      : _selectedOption3,
                              onChanged: (value) {
                                setState(() {
                                  if (i == 0) {
                                    _selectedOption1 = value as String?;
                                  } else if (i == 1) {
                                    _selectedOption2 = value as String?;
                                  } else {
                                    _selectedOption3 = value as String?;
                                  }
                                });
                              },
                            ),
                          const Divider(
                            color: Colors.black54,
                            height: 50,
                          ),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          child: const Text('Gönder'),
                          onPressed: _selectedOption1 == null ||
                                  _selectedOption2 == null ||
                                  _selectedOption3 == null
                              ? null
                              : () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Doğrulama'),
                                        content: const Text(
                                            'Cevabınızı göndermek istediğinize emin misiniz?'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('İptal'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Gönder'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              List<String> answers = [
                                                _selectedOption1!,
                                                _selectedOption2!,
                                                _selectedOption3!,
                                              ];
                                              saveAnswers(answers);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const BottomNavBar(),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                        ),
                        ElevatedButton(
                          child: const Text('Geri Bildirim Gönder'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ContactUsPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

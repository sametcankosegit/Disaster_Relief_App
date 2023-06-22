import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/file_utils.dart';
import '../../widgets/drawer_header_widget/drawer.dart';
import '../questions_screen.dart/question_main_screen.dart';

class DonatePage extends StatefulWidget {
  DonatePage() : super();
  final String title = 'BAĞIŞ YAP';
  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  String fileContents = 'Henüz Bağış Yapmadınız.';
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.question_mark_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuestionsPage()),
              );
            },
          ),
        ],
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
        title: Center(child: Text(widget.title)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_morning.png'),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
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
                        )
                      ]),
                  child: Image.asset(
                    'assets/images/bagis.png',
                    height: 370,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40, left: 30, right: 30),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12.withOpacity(0.11),
                        blurRadius: 40,
                        spreadRadius: 0)
                  ],
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 204, 220, 250),
                    hintText: 'Bağış Tutarınız Giriniz',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 129, 129, 129),
                        fontSize: 14),
                  ),
                  controller: myController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text(
                  '    Bağış Yap   ',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 183, 205, 224)),
                onPressed: () {
                  FileUtils.saveToFile(myController.text);
                },
              ),
              ElevatedButton(
                child: const Text(
                  'Bağışı Göster',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 183, 205, 224)),
                onPressed: () {
                  FileUtils.readFromFile().then((contents) {
                    setState(() {
                      fileContents = contents;
                    });
                  });
                },
              ),
              Text(fileContents),
            ],
          ),
        ),
      ),
    );
  }
}

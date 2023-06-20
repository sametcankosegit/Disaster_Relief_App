import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/register_textfield.dart';
import '../login/login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  void signUpUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Firestore'a kullanıcı profili bilgilerini kaydet
      await FirebaseFirestore.instance
          .collection('profiles')
          .doc(userCredential
              .user!.uid) // Kullanıcının UID'sini belge kimliği olarak kullanın
          .set({
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
      });

      Navigator.of(_navigatorKey.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      showDialog(
        context: _navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Kayıt Hatası'),
            content: const Text(
              'Kayıt olurken bir hata oluştu. Lütfen tekrar deneyin.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _navigatorKey,
      body: Container(
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
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo1.png',
                    width: 220,
                    height: 220,
                    color: Colors.black,
                  ),
                  const Text(
                    'Hoşgeldiniz',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),
                  RegisterTextField(
                    controller: nameController,
                    hintText: 'Ad Soyad',
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    maxLength: 30,
                  ),
                  const SizedBox(height: 10),
                  RegisterTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 30,
                  ),
                  const SizedBox(height: 10),
                  RegisterTextField(
                    controller: passwordController,
                    hintText: 'Şifre',
                    obscureText: true,
                    maxLength: 30,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 10),
                  RegisterTextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                    hintText: 'Telefon',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: signUpUser,
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 68, 22, 80),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'KAYIT OL',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hesabınız var mı?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => LoginPage()),
                            ),
                          );
                        },
                        child: const Text(
                          'Giriş Yap',
                          style: TextStyle(
                            color: Color.fromARGB(255, 68, 22, 80),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

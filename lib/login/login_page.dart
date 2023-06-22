import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/login_textfield.dart';
import '../components/square_tile.dart';
import '../register/register_page.dart';
import '../widgets/bottom_navbar.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  void signUserIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.of(_navigatorKey.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const BottomNavBar()),
        (Route<dynamic> route) => false,
        //Bu kod parçası, mevcut sayfayı kapatıp, BottomNavBar adlı yeni bir sayfaya geçiş yapmayı sağlar ve diğer sayfaları kaldırır. 
        //Böylece, kullanıcı yeni sayfaya yönlendirilirken, geri düğmesine basıldığında veya
        //başka bir gezinme işlemi gerçekleştirildiğinde mevcut sayfaların birikmemesini sağlar.
      );
    } catch (e) {
      showDialog(
        context: _navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Giriş Hatası'),
            content: const Text(
                'Giriş yaparken bir hata oluştu. Lütfen tekrar deneyin.'),
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
                  LoginTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  LoginTextField(
                    controller: passwordController,
                    hintText: 'Şifre',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Şifrenizi mi Unuttunuz?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: signUserIn,
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 63, 42, 73),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'GİRİŞ YAP',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Yada bununla devam et',
                            style: TextStyle(
                              color: Color.fromARGB(255, 236, 230, 230),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(imagePath: 'assets/images/google.png'),
                      SizedBox(width: 25),
                      SquareTile(imagePath: 'assets/images/facebook.png'),
                      SizedBox(width: 25),
                      SquareTile(imagePath: 'assets/images/github.png'),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hesabınız yok mu?',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                          );
                        },
                        child: const Text(
                          'Kayıt Ol',
                          style: TextStyle(
                            color: Color.fromARGB(255, 68, 22, 80),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Kayıt olmadan devam etmek için',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomNavBar()),
                          );
                        },
                        child: const Text(
                          'Buraya tıkla',
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

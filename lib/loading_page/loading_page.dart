import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../get_started/get_started_page.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const GetStartedPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo1.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 16),
            const Text(
              'Yükleniyor...',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            const SpinKitDoubleBounce(
              color: Color.fromARGB(255, 61, 138, 80),
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}

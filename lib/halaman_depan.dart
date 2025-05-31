import 'package:flutter/material.dart';
import 'package:sabar_/halaman_login.dart';
import 'package:sabar_/main.dart';

void main() => runApp(MyApp());

class SabarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Spacer(flex: 2),
                Image.asset(
                  'images/domba.png',
                  height: 300,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _indicator(isActive: false),
                    SizedBox(width: 8),
                    _indicator(isActive: true),
                    SizedBox(width: 8),
                    _indicator(isActive: false),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Sistem Aplikasi Amanah Bantuan Rakyat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(height: 40),
                Spacer(),
                SizedBox(
                  width: 300,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text('Lanjut',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: "Poppins")),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _indicator({required bool isActive}) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }
}

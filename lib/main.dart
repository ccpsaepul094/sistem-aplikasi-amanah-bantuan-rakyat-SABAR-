import 'package:flutter/material.dart';
import 'package:sabar_/pages/halaman_users/halaman_depan.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SabarApp(),
    );
  }
}

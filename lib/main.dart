import 'package:flutter/material.dart';
import 'package:flutter_pant_app/home_page.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

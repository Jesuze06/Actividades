import 'package:flutter/material.dart';
import 'package:actividad2/views/login.dart';

void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Actividad',
      theme: ThemeData(
        primarySwatch: Colors.blue, 
      ),
      home: const Scaffold(
        body: LoginView(),
      ),
    );
  }
}

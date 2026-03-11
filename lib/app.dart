import 'package:flutter/material.dart';

class ChrugApp extends StatelessWidget {
  const ChrugApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chrug',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Chrug'),
        ),
      ),
    );
  }
}

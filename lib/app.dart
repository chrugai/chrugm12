import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';

class ChrugApp extends StatelessWidget {
  const ChrugApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chrug',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const Scaffold(
        body: Center(
          child: Text('Chrug'),
        ),
      ),
    );
  }
}

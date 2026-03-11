import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://eitisulgrwcgnsyhrmvk.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVpdGlzdWxncndjZ25zeWhybXZrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMxOTUxOTcsImV4cCI6MjA4ODc3MTE5N30.Ua3C404pfxSecCEGaTBPVeKQzprqg_i3CLQNXA3bIrU',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chrug',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chrug')),
      body: const Center(child: Text('Ready to build')),
    );
  }
}
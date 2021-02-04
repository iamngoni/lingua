import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingua/controllers/LetterController.dart';
import 'package:lingua/pages/home.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(
    ChangeNotifierProvider(
      create: (content) => LettersController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lingua',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LinguaHome(),
    );
  }
}

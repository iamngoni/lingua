import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingua/pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingua/models/letter.dart';

class LettersController extends ChangeNotifier {
  List<Letter> _letters = [];
  List<String> _words = [
    "bathroom",
    "come",
    "equality",
    "far",
    "farewell",
    "good",
    "hello",
    "i love you",
    "later",
    "letter",
    "like",
    "no",
    "ok",
    "perfect",
    "question",
    "sign language",
    "stare",
    "stop",
    "what are you doing",
    "wow"
  ];

  init() async {
    String lettersJson =
        await rootBundle.loadString("assets/data/letters.json");
    List jsonData = json.decode(lettersJson);
    for (var jt in jsonData) {
      _letters.add(Letter.fromMap(jt));
    }
    notifyListeners();
  }

  get letters => _letters;
  get words => _words;
}

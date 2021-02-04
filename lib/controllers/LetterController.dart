import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingua/models/letter.dart';

class LettersController extends ChangeNotifier {
  List<Letter> _letters = [];
  List<String> _words = [];

  init() async {
    String lettersJson =
        await rootBundle.loadString("assets/data/letters.json");
    List jsonData = json.decode(lettersJson);
    for (var jt in jsonData) {
      _letters.add(Letter.fromMap(jt));
    }
    notifyListeners();

    String wordsJson = await rootBundle.loadString("assets/data/words.json");
    List jsnDt = json.decode(wordsJson);
    for (var gt in jsnDt) {
      _words.add(gt);
    }

    notifyListeners();
  }

  get letters => _letters;
  get words => _words;
}

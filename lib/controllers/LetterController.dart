import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingua/models/letter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LettersController extends ChangeNotifier {
  List<Letter> _letters = [];
  List<String> _favorites = [];
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
    if (await _isFirstTime()) {
      _setFavorites();
      _setFirstTime();
    }

    String lettersJson =
        await rootBundle.loadString("assets/data/letters.json");
    List jsonData = json.decode(lettersJson);
    for (var jt in jsonData) {
      _letters.add(Letter.fromMap(jt));
    }
    this._favorites = await _getDataFromPrefs();
    notifyListeners();
  }

  addToFavorites(String word) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<String> favs = await this._getDataFromPrefs();
    print(favs);
    favs.add(word);
    await _setFavorites();
    print(await _getDataFromPrefs());
    await _prefs.setStringList("favorites", favs);
    print(await _getDataFromPrefs());
    this._favorites = await this._getDataFromPrefs();
    notifyListeners();
  }

  removeFromFavorites(String word) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<String> favs = await this._getDataFromPrefs();
    favs.remove(word);
    await _prefs.setStringList("favorites", favs);
    this._favorites = favs;
    notifyListeners();
  }

  Future<List<String>> _getDataFromPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getStringList("favorites");
  }

  Future<bool> _isFirstTime() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool("is_first_time") ?? true;
  }

  void _setFavorites() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setStringList("favorites", []);
  }

  void _setFirstTime() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool("is_first_time", false);
  }

  get letters => _letters;
  get words => _words;
  get favorites => _favorites;
}

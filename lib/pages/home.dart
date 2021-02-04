import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';
import 'package:lingua/controllers/LetterController.dart';
import 'package:lingua/models/letter.dart';
import 'package:provider/provider.dart';

class LinguaHome extends StatefulWidget {
  @override
  _LinguaHomeState createState() => _LinguaHomeState();
}

class _LinguaHomeState extends State<LinguaHome> {
  List<String> _tabs = ["Most used", "Favorite"];
  int _index = 0;
  ImageSequenceAnimatorState offlineImageSequenceAnimator;
  bool _isOpen = false;
  bool shouldPlay = false;
  Letter _ltr;
  TextEditingController _fieldController = new TextEditingController();

  void showUnShowField() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void onOfflineReadyToPlay(ImageSequenceAnimatorState _imageSequenceAnimator) {
    offlineImageSequenceAnimator = _imageSequenceAnimator;
  }

  @override
  void initState() {
    super.initState();
    Provider.of<LettersController>(context, listen: false).init();
  }

  processWord(String word) {
    setState(() {
      shouldPlay = false;
    });
    List<Letter> images = [];
    for (int i = 0; i < word.length; i++) {
      Letter letter = getWordImagePath(word[i]);
      images.add(letter);
    }

    playVideo(images);
  }

  reciteAlphabet() {
    setState(() {
      shouldPlay = false;
    });
    List<Letter> _letters =
        Provider.of<LettersController>(context, listen: false).letters;
    playVideo(_letters);
  }

  Letter getWordImagePath(String character) {
    List<Letter> _letters =
        Provider.of<LettersController>(context, listen: false).letters;
    Letter item = _letters
        .where(
          (Letter letter) =>
              letter.letter.toLowerCase() == character.toLowerCase(),
        )
        .first;
    return item;
  }

  void playVideo(List<Letter> images) async {
    int index = 0;
    int length = images.length;
    setState(() async {
      _ltr = images[index];
      shouldPlay = true;
    });

    index = index + 1;
    while (index < length) {
      print(images[index]);
      print('looping');
      await Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _ltr = images[index];
        });
      });
      index = index + 1;
    }
    _fieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var dimensions = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF032059),
        child: Icon(Icons.keyboard),
        onPressed: showUnShowField,
      ),
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
          height: dimensions.height,
          width: dimensions.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: dimensions.height * 0.6,
                    child: shouldPlay == true
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(_ltr.image),
                                width: 50,
                                color: Colors.white,
                              ),
                              SizedBox(height: 25),
                              Text(
                                _ltr.letter.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        : renderNothing(),
                  ),
                  Container(
                    height: dimensions.height * 0.4,
                    width: dimensions.width,
                    color: Colors.white,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: _tabs.map((tabItem) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _index = _tabs.indexOf(tabItem);
                                  });
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      tabItem,
                                      style: TextStyle(
                                        color: Color(0xFF032059),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Container(
                                      width: dimensions.width * 0.2,
                                      height: 3,
                                      color: _tabs.indexOf(tabItem) == _index
                                          ? Color(0xFF032059)
                                          : Colors.white,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _isOpen
                  ? Positioned(
                      bottom: dimensions.height * 0.45,
                      child: floatingTextField(),
                    )
                  : SizedBox(
                      height: 0,
                      width: 0,
                    ),
              Positioned(
                top: 10,
                left: 20,
                child: alphabetRecitor(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget floatingTextField() {
    return PhysicalModel(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: TextField(
          controller: _fieldController,
          decoration: InputDecoration(
            labelText: "Word",
            border: InputBorder.none,
          ),
          onSubmitted: (String word) =>
              processWord(word.replaceAll(new RegExp(r"\s+\b|\b\s"), "")),
        ),
      ),
      elevation: 5.0,
      color: Colors.black,
      shadowColor: Colors.white,
    );
  }

  Widget renderNothing() {
    return SizedBox(
      height: 0,
      width: 0,
    );
  }

  Widget alphabetRecitor() {
    return GestureDetector(
      onTap: reciteAlphabet,
      child: Text(
        "Do The Alphabet  🔠",
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
      ),
    );
  }
}

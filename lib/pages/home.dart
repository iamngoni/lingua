import 'package:flutter/material.dart';

class LinguaHome extends StatefulWidget {
  @override
  _LinguaHomeState createState() => _LinguaHomeState();
}

class _LinguaHomeState extends State<LinguaHome> {
  List<String> _tabs = ["Most used", "Favorite", "Sentence"];
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    var dimensions = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF032059),
        child: Icon(Icons.keyboard),
        onPressed: null,
      ),
      body: Container(
        height: dimensions.height,
        width: dimensions.width,
        child: Column(
          children: [
            Container(
              height: dimensions.height * 0.6,
              color: Colors.black,
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
                                color: _tabs.indexOf(tabItem) == _index ? Color(0xFF032059) : Colors.white,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hayakuchi_game/drawer_page.dart';
import 'package:hayakuchi_game/play_page.dart';
import 'file:///C:/Users/ignit/AndroidStudioProjects/hayakuchi_game/lib/game_page/test.dart';
import 'file:///C:/Users/ignit/AndroidStudioProjects/hayakuchi_game/lib/game_page/test2.dart';


class GamePage extends StatelessWidget {
  GamePage({Key key, this.title, this.images}) : super(key: key);
  final String title;
  File images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ButtonTheme(
              minWidth: 150,
              height: 200,
              padding: const EdgeInsets.all(20),
              child: RaisedButton(
                color: Colors.grey[300],
                child: const Text('音声入力レベル1'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TestPage(imaged: images, title: title,)));
                },
                highlightColor: Colors.redAccent,
                onHighlightChanged: (value) {},
              ),
            ),
            ButtonTheme(
              minWidth: 150,
              height: 200,
              padding: const EdgeInsets.all(20),
              child: RaisedButton(
                color: Colors.grey[300],
                child: const Text('音声入力レベル2'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TestPage2(imaged: images, title: title,)));
                },
                highlightColor: Colors.blueAccent,
                onHighlightChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

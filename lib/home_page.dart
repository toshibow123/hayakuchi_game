import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/ignit/AndroidStudioProjects/hayakuchi_game/lib/constants/theme_data.dart';
import 'package:hayakuchi_game/game_page.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as image;

class MyHomePage extends StatefulWidget {
  String level;

  MyHomePage({Key key, this.title, this.level}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uint8List _imageBytes;
  var images;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image(
          image: AssetImage('assets/images/titlelogo.png'),
        ),
        centerTitle: true,
        backgroundColor: AppBarColor,
      ),
      body: Container(
        color: backGroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return RadialGradient(
                          center: Alignment.topLeft,
                          radius: 1.0,
                          colors: <Color>[Colors.red, Colors.yellowAccent],
                          tileMode: TileMode.mirror,
                        ).createShader(bounds);
                      },
                      child: Text(
                        "ボ〇ー・オ〇ゴン監修！",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(),
                  Container(
                    child: Center(
                      child: Image.asset('assets/images/bobiimain.png')
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                    Text(
                      '下のボタンからゲームを開始してくれよ！',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                ],
              ),
              Container(
                width: ((MediaQuery.of(context).size.width) / 2) - 10,
                height: 50,
                child: FlatButton(
                  focusColor: Colors.red,
                  highlightColor: Colors.blue,
                  hoverColor: Colors.lightBlue[100],
                  color: Colors.indigo,
                  shape: StadiumBorder(
                    side: BorderSide(color: Colors.white),
                  ),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return RadialGradient(
                        center: Alignment.topLeft,
                        radius: 1.0,
                        colors: <Color>[Colors.red, Colors.yellowAccent],
                        tileMode: TileMode.mirror,
                      ).createShader(bounds);
                    },
                    child: Text(
                      "ゲームを開始する",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GamePage(
                              images: _imageBytes,
                              title: widget.title,
                            ),
                          ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
  }

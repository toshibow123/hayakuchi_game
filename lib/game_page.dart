import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'file:///C:/Users/ignit/AndroidStudioProjects/hayakuchi_game/lib/constants/theme_data.dart';
import 'package:hayakuchi_game/drawer_page.dart';
import 'file:///C:/Users/ignit/AndroidStudioProjects/hayakuchi_game/lib/game_page/test.dart';
import 'file:///C:/Users/ignit/AndroidStudioProjects/hayakuchi_game/lib/game_page/test2.dart';

class GamePage extends StatelessWidget {
  GamePage({Key key, this.title, this.images}) : super(key: key);
  final String title;
  Uint8List images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        title: Image(
          image: AssetImage('assets/images/titlelogo.png'),
        ),
        centerTitle: true,
        backgroundColor: AppBarColor,
      ),
      drawer: DrawerMenu(),
      body: Column(
        children: [
          Container(
              alignment: Alignment.center,
              height: 200.0,
              child: Center(
                child: Text(
                  "好きなレベルを選択してください",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 150,
                width: 150,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TestPage(
                                  title: title,
                                )));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.lightBlueAccent,
                        offset: Offset(0.0, 4.0),
                        blurRadius: 10.0)
                      ],
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.indigo[300],
                          Colors.indigo[500],
                          Colors.indigo[700],
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(5),
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
                        '英語発音レベル1',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TestPage2(
                              title: title,
                            )));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.redAccent[100],
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0)
                      ],
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.red[300],
                          Colors.red[500],
                          Colors.red[700],
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return RadialGradient(
                          center: Alignment.topLeft,
                          radius: 1.0,
                          colors: <Color>[Colors.white, Colors.greenAccent],
                          tileMode: TileMode.mirror,
                        ).createShader(bounds);
                      },
                      child: Text(
                        '英語発音レベル2',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

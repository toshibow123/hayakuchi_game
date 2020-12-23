import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hayakuchi_game/constants/theme_data.dart';
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
              Container(
                child: Center(
                  child: _imageBytes == null
                      ? Text(
                    '画像が選択されていません',
                    style: TextStyle(color: Colors.white),
                  )
                      : Image.memory(_imageBytes),
                ),
              ),
              Column(
                children: [
                  if (images == null)
                    Text(
                      '右下のボタンから好きな画像を読み込んでください',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  if (images != null)
                    Text('ボタンを押してゲームを開始してください',
                        style: TextStyle(color: Colors.white)),
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
                    if (_imageBytes == null) {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            content: Text("画像を読み込まないとゲームは始められません"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("OK"),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    if (_imageBytes != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GamePage(
                              images: _imageBytes,
                              title: widget.title,
                            ),
                          ));
                    } else {}
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_photo_alternate),
      ),
    );
  }

  Future getImage() async {
    final PickedFile file = await ImagePicker().getImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 250,
        maxHeight: 250);

    if (file != null) {
      final Uint8List bytes = await file.readAsBytes();
      final image.Image img = image.decodeImage(bytes);
      setState(() {
        _imageBytes = image.encodePng(img);
      });
    }
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hayakuchi_game/game_page.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {

  String level;

  MyHomePage({Key key, this.title, this.level}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File images;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality:80, maxWidth:300, maxHeight: 300);

    setState(() {
      if (pickedFile != null) {
        images = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: images == null
                    ? Text('画像が選択されていません')
                    : Image.file(images),
              ),
              Container(
                child: Text('右下のボタンから好きな画像を読み込んでください'),
              ),
              Container(
                width: ((MediaQuery
                    .of(context)
                    .size
                    .width) / 2) - 10,
                height: 50,
                child: OutlineButton(
                  focusColor: Colors.red,
                  highlightColor: Colors.blue,
                  hoverColor: Colors.lightBlue[100],
                  borderSide: BorderSide(width: 3, color: Colors.blue),
                  shape: StadiumBorder(),
                  child: Text("ゲームを開始する", style: TextStyle(fontSize: 17),
                  ),
                  onPressed: () {
                    if(images == null){
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

                    } if(images != null) {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => GamePage(images: images, title: widget.title,),
                      ));
                    } else {


                    }
                    },
                ),
              )
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
}
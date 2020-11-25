import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:hayakuchi_game/drawer_page.dart';

const languages = const [
  const Language('Japanese', 'ja_JA'),
];

const List<String> baseThemeList = [
  '生麦生米生卵',
  '隣の客はよく柿食う客だ',
  'バスガス爆発',
  '裏庭には二羽ニワトリがいる',
  '赤パジャマ黄パジャマ青パジャマ',
  '赤巻紙青巻紙黄巻紙',
  '老若男女',
  '旅客機の旅客'
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class TestPage extends StatefulWidget {
  File imaged;
  final String title;

  TestPage({Key key, this.title, this.imaged}) : super(key: key);

  @override
  _TestPage createState() => new _TestPage();
}

class _TestPage extends State<TestPage> {

  SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String transcription = '';
  String _themeText = '';
  int _hp = 5;

  //String _currentLocale = 'en_US';
  Language selectedLang = languages.first;

  @override
  initState() {
    super.initState();
    activateSpeechRecognizer();
    setTongueTwister();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void activateSpeechRecognizer() {
    print('_TestPage.activateSpeechRecognizer... ');
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.setErrorHandler(errorHandler);
    _speech.activate('fr_FR').then((res) {
      setState(() => _speechRecognitionAvailable = res);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      drawer: DrawerMenu(),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () => _themeText != '終了!!'? setTongueTwister() : null,
                child: Container(
                  child: _themeText != '終了!!'? Icon(Icons.autorenew) : null,
                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    _themeText,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('HP : ',
                  style: TextStyle(
                    fontSize: 18,
                  )),
              Text(_hp.toString(),
                  style: TextStyle(fontSize: 18, color: Colors.red)),
            ],
          ),
          Container(
            height: 280,
            child: Center(
              child: aaa(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5.0),
            width: 300,
            color: Colors.grey.shade200,
            child: Text(transcription),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton(
                  onPressed: _speechRecognitionAvailable && !_isListening
                      ? () => start()
                      : null,
                  label: _isListening ? 'Listening...' : '詠唱開始',
                ),
                _buildButton(
                  onPressed: _isListening ? () => clear() : null,
                  label: 'やり直し',
                ),
                _buildButton(
                  onPressed: () {
                    attack();
                  },
                  label: '攻撃',
                ),
              ])
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed("/home");
        },
        child: Text('ホーム'),
      ),
    );
  }

  List<CheckedPopupMenuItem<Language>> get _buildLanguagesWidgets =>
      languages
          .map((l) =>
      new CheckedPopupMenuItem<Language>(
        value: l,
        checked: selectedLang == l,
        child: new Text(l.name),
      ))
          .toList();

  void _selectLangHandler(Language lang) {
    setState(() => selectedLang = lang);
  }

  Widget _buildButton({String label, VoidCallback onPressed}) =>
      new Padding(
          padding: new EdgeInsets.all(12.0),
          child: new RaisedButton(
            color: Colors.cyan.shade600,
            onPressed: onPressed,
            child: new Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ));

  void start() =>
      _speech.activate(selectedLang.code).then((_) {
        return _speech.listen().then((result) {
          print('_TestPage.start => result $result');
          setState(() {
            _isListening = result;
          });
        });
      });

  void cancel() =>
      _speech.cancel().then((_) => setState(() => _isListening = false));

  void stop() =>
      _speech.stop().then((_) {
        setState(() => _isListening = false);
      });

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) {
    print('_TestPage.onCurrentLocale... $locale');
    setState(
            () => selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionStarted() {
    setState(() => _isListening = true);
  }

  void onRecognitionResult(String text) {
    print('_TestPage.onRecognitionResult... $text');
    setState(() => transcription = text);
  }

  void onRecognitionComplete(String text) {
    print('_TestPage.onRecognitionComplete... $text');
    setState(() => _isListening = false);
  }

  void errorHandler() => activateSpeechRecognizer();

  void attack() async {
    if (_isListening) {
      stop();
      await Future.delayed(Duration(milliseconds: 500));
    }
    if (_themeText == transcription) {
      setState(() => _hp = _hp - 1);
      setTongueTwister();
    }
    if (_hp <= 0) {
      //setState(() => widget.imaged = 'images/otukare.jpg');
      setState(() => _themeText = '終了!!');
    }
  }

  void clear() {
    cancel();
    setState(() => transcription = '');
  }

 void setTongueTwister() {
    int index = Random().nextInt(baseThemeList.length);
    setState(() => _themeText = baseThemeList[index]);
  }

  aaa() {
    if(_hp > 0){
     return Image.file(widget.imaged);
    } if(_hp == 0) {
     return Image.asset('assets/images/aaa.jpg');
    }
  }
}
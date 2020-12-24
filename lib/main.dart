
import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String title = '英語発音チェッカー';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        // default
        // primarySwatch: Colors.cyan,
        primaryColor: Colors.blueGrey[600],
        accentColor: Colors.blueGrey[600],
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: title),
      routes: <String,WidgetBuilder>{
        '/home': (BuildContext context) => MyHomePage(title: title),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:open_wa_chat/consts.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home_screen.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      useLoader: false,
      seconds: 2,
      navigateAfterSeconds: HomeScreen(),
      title: Text(
        'Open WhatsApp chat \n without saving number',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image(image: AssetImage('assets/icon.png')),
      photoSize: 70,
      gradientBackground: LinearGradient(
        begin: Alignment.topLeft,
        end:  Alignment(1.25, 0.0),
        colors: [kWhatsAppColorDark, kWhatsAppColorMid],
          tileMode: TileMode.repeated
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_wa_chat/consts.dart';
import 'package:open_wa_chat/models/numbers.dart';
import 'package:open_wa_chat/preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

import 'screens/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        useLoader: false,
        seconds: 1,
        navigateAfterSeconds: HomeScreen(),
        title: Text(
          'Open chat \n without saving number',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
        ),
        image: Image(image: AssetImage('assets/icon.png')),
        photoSize: 70,
        gradientBackground: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(1.25, 0.0),
            colors: [kWhatsAppColorDark, kWhatsAppColorMid],
            tileMode: TileMode.repeated),
      );
  }
}

import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../consts.dart';

class Services{


  launchURL(phoneNumber, checkNumber, context) async {
    final url = 'https://wa.me/$phoneNumber';
    if (await canLaunch(url) && checkNumber) {
      await launch(url);
    } else {
      coolAlert(context);
      throw 'Could not launch $url';
    }
  }

  coolAlert(context) => CoolAlert.show(
      context: context,
      type: CoolAlertType.warning,
      animType: CoolAlertAnimType.slideInDown,
      text: "Write correct phone number",
      confirmBtnColor: kWhatsAppColorDark);

  }

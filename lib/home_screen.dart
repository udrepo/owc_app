import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:open_wa_chat/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  String initialCountry =
  !kIsWeb ? Platform.localeName.substring(Platform.localeName.length - 2) : 'KZ';
  PhoneNumber number = PhoneNumber(
      isoCode: !kIsWeb ? Platform.localeName.substring(Platform.localeName.length - 2) : 'KZ');
  bool checkNumber = false;
  Color openColor;
  String phoneNumber = '';

  _launchURL() async {
    final url = 'https://wa.me/$phoneNumber';
    if (await canLaunch(url) && checkNumber) {
      await launch(url);
    } else {
      coolAlert(context);
      print('enter valid number');
      throw 'Could not launch $url';
    }
  }



  coolAlert(context) => CoolAlert.show(
      context: context,
      type: CoolAlertType.warning,
      animType: CoolAlertAnimType.slideInDown,
      text: "Write correct phone number",
      confirmBtnColor: kWhatsAppColorDark);

  @override
  Widget build(BuildContext context) {
    Color _giveColor() {
      setState(() {
        openColor = checkNumber ? kWhatsAppColorLight : Colors.black;
      });
      return openColor;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [kWhatsAppColorDark, kWhatsAppColorMid],),),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.93,
              height: 500,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Open WhatsApp chat',
                    style: kTitleTextStyle,
                  ),
                  SizedBox(
                    height: 44,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.83,
                    child: Form(
                      key: formKey,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {
                                print(number.phoneNumber);
                                phoneNumber = number.toString();
                                print(phoneNumber);
                              },
                              onInputValidated: (bool value) {
                                setState(() {
                                  checkNumber = value;
                                });
                                print(value);
                              },
                              selectorConfig: SelectorConfig(
                                  selectorType:
                                  PhoneInputSelectorType.BOTTOM_SHEET,
                                  leadingPadding: 7,
                                  trailingSpace: false),
                              cursorColor: kWhatsAppColorMid,
                              ignoreBlank: false,
                              inputDecoration: InputDecoration(
                                  hintText: 'Write phone number',
                                  border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide:
                                      BorderSide(color: kWhatsAppColorDark)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: kWhatsAppColorMid))),
                              autoValidateMode:
                              AutovalidateMode.onUserInteraction,
                              selectorTextStyle: TextStyle(color: Colors.black),
                              initialValue: number,
                              textFieldController: controller,
                              formatInput: false,
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: true, decimal: true),
                              inputBorder: OutlineInputBorder(),
                              onSaved: (PhoneNumber number) {
                                setState(() {
                                  phoneNumber = number.toString();
                                });
                                print('On Saved: $phoneNumber');
                              },
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            ConstrainedBox(
                              constraints:
                              BoxConstraints.tightFor(width: 193, height: 50),
                              child: ElevatedButton(
                                onPressed: () async {
                                  formKey.currentState.save();
                                  _launchURL();
                                  print(checkNumber);
                                },
                                child: Text('Open chat in WhatsApp'),
                                style: ElevatedButton.styleFrom(
                                  primary: _giveColor(),
                                  shape: const StadiumBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            Text(
                              'Write a number in +X-XXX-XX-XX format \n'
                                  '⚠ If you want to text to yourself enter your WhatsApp number',
                              textAlign: TextAlign.center,
                              style: kNoteTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

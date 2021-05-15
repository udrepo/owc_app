import 'dart:async';

import 'package:alert/alert.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var darkTheme = ThemeData.light().copyWith(primaryColor: Colors.blue);

    return MaterialApp(
      title: 'Demo',
      themeMode: ThemeMode.dark,
      darkTheme: darkTheme,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'KZ';
  PhoneNumber number = PhoneNumber(isoCode: 'KZ');
  bool checkNumber = false;
  Color openColor;
  String phoneNumber = '';

  _launchURL() async {
    final url = 'https://wa.me/$phoneNumber';
    if (await canLaunch(url) && checkNumber) {
      await launch(url);
    } else {
     // _showAlertDialog(context);
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
    confirmBtnColor: Color(0xff075e54)
  );

  _showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK", style: TextStyle(
        color: Color(0xff075e54)
      ),),
      onPressed: () {Navigator.pop(context);},
    );



    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Text("⚠ Write correct phone number",
        style: TextStyle(
        fontSize: 18
      ),),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color _giveColor() {
      setState(() {
        openColor = checkNumber ? Color(0xff25D366) : Colors.black;
      });
      return openColor;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [Color(0xff075e54), Color(0xff128c7e)])),
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
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff333333),
                  ),
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
                            cursorColor: Color(0xff128c7e),
                            ignoreBlank: false,
                            inputDecoration: InputDecoration(
                                hintText: 'Write phone number',
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                    borderSide:
                                        BorderSide(color: Color(0xff075e54))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff128c7e)))),
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
                              child: Text('Save'),
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
                            style: TextStyle(color: Color(0xff666666)),
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
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');
    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

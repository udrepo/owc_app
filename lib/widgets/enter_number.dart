import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:open_wa_chat/services/services.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

import '../consts.dart';
import '../models/numbers.dart';

class EnterNumber extends StatefulWidget {
  @override
  _EnterNumberState createState() => _EnterNumberState();
}

class _EnterNumberState extends State<EnterNumber> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = !kIsWeb ? prefCountry : 'KZ';
  PhoneNumber number = PhoneNumber(isoCode: !kIsWeb ? prefCountry : 'KZ');
  bool checkNumber = false;
  Color openColor;
  String phoneNumber = '';
  Services services = Services();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.83,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(
            'Open WhatsApp chat',
            style: kTitleTextStyle,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.05,
              ),
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
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    leadingPadding: 7,
                    trailingSpace: false),
                cursorColor: kWhatsAppColorMid,
                ignoreBlank: false,
                inputDecoration: InputDecoration(
                    hintText: 'Write phone number',
                    hintStyle: kButtonTextStyle,
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide:
                        BorderSide(color: kWhatsAppColorDark)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: kWhatsAppColorMid))),
                autoValidateMode: AutovalidateMode.onUserInteraction,
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
                child: Consumer<Numbers>(builder: (context, numbers, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      formKey.currentState.save();
                      services.launchURL(phoneNumber, checkNumber, context);
                      print(checkNumber);
                      if(checkNumber) numbers.addNumber(phoneNumber);
                      FocusScope.of(context).unfocus();
                    },
                    child: Text(
                      'Open chat in WhatsApp',
                      style: kButtonTextStyle,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: checkNumber ? kWhatsAppColorLight : Colors.black,
                      shape: const StadiumBorder(),
                    ),
                  );
                }
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show Platform;

const kWhatsAppColorDark = Color(0xff075e54);
const kWhatsAppColorMid = Color(0xff128c7e);
const kWhatsAppColorLight = Color(0xff25D366);



const kNoteTextStyle = TextStyle(color: Color(0xff666666));
var kTitleTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Color(0xff333333),
    )
);

var kButtonTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ));

var kOptionButtonTextStyle = GoogleFonts.poppins(
textStyle: TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.bold,
  color: Color(0xff333333),
));

var kHistoryListTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: Color(0xff333333),
    ));

var kOpenChatButtonTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: kWhatsAppColorDark,
    ));

var kNTSTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: kWhatsAppColorDark,
    ));


String prefCountry = Platform.localeName.substring(Platform.localeName.length - 2);

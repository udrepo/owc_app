import 'package:flutter/material.dart';
import 'package:open_wa_chat/consts.dart';

class NothingToShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Nothing to show \n"
              "Enter a number and start a chat!",
            style: kNTSTextStyle,
          textAlign: TextAlign.center,
          ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:open_wa_chat/consts.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryList extends StatelessWidget {
  final services;
  final numbers;
  final index;

  HistoryList(this.services, this.numbers, this.index);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(
          color: kWhatsAppColorMid,
          width: 3
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(numbers.numbers.elementAt(index),
              textAlign: TextAlign.center,
              style: kHistoryListTextStyle,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex:2,
                    child: TextButton(
                      child: Text("Open chat",
                        style: kOpenChatButtonTextStyle,),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(50, 30),
                          alignment: Alignment.center
                      ),
                      onPressed: () async {
                        services.launchURL(
                            numbers.numbers.elementAt(index), true, context);
                      },
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(50, 30),
                          alignment: Alignment.center
                      ),
                      onPressed: () {launch("tel://${numbers.numbers.elementAt(index)}");}
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(50, 30),
                          alignment: Alignment.center
                      ),
                      onPressed: () {numbers.deleteNumber(numbers.numbers.elementAt(index));},
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
}

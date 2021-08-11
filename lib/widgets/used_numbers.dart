import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_wa_chat/models/numbers.dart';
import 'package:open_wa_chat/services/services.dart';
import 'package:provider/provider.dart';
import 'history_list.dart';
import 'nothing_to_show.dart';

import '../consts.dart';

class UsedNumbers extends StatefulWidget {
  @override
  _UsedNumbersState createState() => _UsedNumbersState();
}

class _UsedNumbersState extends State<UsedNumbers> {
  Services services = Services();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'History',
              style: kTitleTextStyle,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Consumer<Numbers>(builder: (context, numbers, child) {
                    return numbers.numbers.isEmpty ?
                        NothingToShow() :
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: numbers.numbers.length,
                        itemBuilder: (context, index) {
                          return HistoryList(services, numbers, index);
                        });
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


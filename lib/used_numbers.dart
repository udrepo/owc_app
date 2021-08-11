import 'package:flutter/material.dart';
import 'package:open_wa_chat/services.dart';

import 'consts.dart';

class UsedNumbers extends StatefulWidget {

  @override
  _UsedNumbersState createState() => _UsedNumbersState();
}

class _UsedNumbersState extends State<UsedNumbers> {

  Services services = Services();
  @override
  Widget build(BuildContext context) {
    List<String> items = ["77772051717", "77028989882", "77772051717",
      "77772051717", "77028989882", "77772051717",
      "77772051717", "77028989882", "77772051717",
    ];
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
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index){
                    return ListTile(
                      title: Text(items[index]),
                      trailing: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(child: Text("Open chat"), onPressed: () async{
                              services.launchURL(items[index], true, context);
                            },),
                            TextButton(child: Icon(Icons.delete, color: Colors.red,), onPressed: () async{
                              services.launchURL(items[index], true, context);
                            },),
                          ],
                        ),
                      ),
                    );
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

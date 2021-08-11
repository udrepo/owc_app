import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:flutter/material.dart';
import 'package:open_wa_chat/consts.dart';
import 'package:open_wa_chat/models/numbers.dart';
import 'package:provider/provider.dart';
import '../widgets/enter_number.dart';
import '../widgets/used_numbers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState(0);
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  _HomeScreenState(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [kWhatsAppColorDark, kWhatsAppColorMid],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.93,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white),
              child: ChangeNotifierProvider(
                create: (context) => Numbers(),
                child: IndexedStack(
                    index: index,
                    children: [EnterNumber(), UsedNumbers()],
                  ),
              )
              ),
            Container(
              width: MediaQuery.of(context).size.width * 0.98,
              height: (MediaQuery.of(context).size.height<770)
                  ? MediaQuery.of(context).size.height * 0.12 :
              MediaQuery.of(context).size.height * 0.1,
              child: AnimatedButtonBar(
                radius: 10,
                padding: const EdgeInsets.all(8),
                backgroundColor: Colors.white,
                foregroundColor: kWhatsAppColorLight,
                elevation: 4,
                borderColor: Colors.white,
                borderWidth: 2,
                children: [
                  ButtonBarEntry(
                    onTap: () => setState(() { index = 0; }),
                    child: Text("Open chat", style: kOptionButtonTextStyle,),
                  ),
                  ButtonBarEntry(
                    onTap: () => setState(() { index = 1; }),
                    child: Text("History", style: kOptionButtonTextStyle,),
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

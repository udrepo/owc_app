import 'package:flutter/material.dart';
import 'package:open_wa_chat/preferences.dart';


class Numbers extends ChangeNotifier{
  Set<String> _numbers = Preferences.getNumbers()?.toSet() ?? {};
  Set<String> get numbers => _numbers;

void addNumber(String newNumber) async{
  _numbers.add(newNumber);
 await Preferences.setNumbers(_numbers.toList());
  notifyListeners();
}

void deleteNumber(String number) async{
  _numbers.remove(number);
  await Preferences.setNumbers(_numbers.toList());
  notifyListeners();
}


}
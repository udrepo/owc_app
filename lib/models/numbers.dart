import 'package:flutter/material.dart';


class Numbers extends ChangeNotifier{
  Set<String> _numbers = {"77772051717", "77028989882"};

  Set<String> get numbers => _numbers;

void addNumber(String newNumber){
  _numbers.add(newNumber);
  notifyListeners();
}

void deleteNumber(String number){
  _numbers.remove(number);
  notifyListeners();
}


}
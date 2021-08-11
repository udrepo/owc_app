import 'package:shared_preferences/shared_preferences.dart';

class Preferences{
static SharedPreferences _preferences;

static init() async => _preferences = await SharedPreferences.getInstance();

static setNumbers(List<String> numbers) async => await _preferences.setStringList("numbers", numbers);

static List<String> getNumbers() => _preferences.getStringList("numbers");

}
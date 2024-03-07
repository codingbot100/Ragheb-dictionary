import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper2 {
  static const String key = 'your_list_key';

  List<dynamic> itemList = [];

  // Read the list from SharedPreferences
  Future<void> readList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      List<dynamic> decodedList = jsonDecode(jsonString);
      itemList = decodedList.cast<String>();
    }
  }

  // Save the list to SharedPreferences
  Future<void> saveList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(itemList);
    prefs.setString(key, jsonString);
  }
  void removeItemFromList(String item) {
  itemList.remove(item);
  // Optionally, save the updated list to SharedPreferences
  saveList();
}

  // Add an item to the list
  void addItemToList(String item) {
    itemList.add(item);
  }
}

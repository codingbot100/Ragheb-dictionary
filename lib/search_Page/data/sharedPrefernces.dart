import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String keyPrefix = 'your_list_key_';

  List<Map<String, dynamic>> itemList = [];

  // Read the list from SharedPreferences
  Future<void> readList(String listKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonString = prefs.getString(_getListKey(listKey));
      if (jsonString != null) {
        List<dynamic> decodedList = jsonDecode(jsonString);
        itemList = decodedList.cast<Map<String, dynamic>>();
      }
    } catch (e) {
      print('Error reading list: $e');
      // Handle the error as needed
    }
  }

  // Save the list to SharedPreferences
  Future<void> saveList(String listKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonString = jsonEncode(itemList);
      prefs.setString(_getListKey(listKey), jsonString);
    } catch (e) {
      print('Error saving list: $e');
      // Handle the error as needed
    }
  }

  // Toggle favorites and update the list
  void toggleFavoritesAndUpdateList(String listKey, String itemName) {
    // Find the item in the list
    Map<String, dynamic>? item = itemList.firstWhere(
      (element) => element['name'] == itemName,
      
    );

    // If the item is found, remove it; otherwise, add it
    if (item.isEmpty) {
      itemList.remove(item);

      // Optionally, remove the item from external storage (SharedPreferences)
      removeItemFromSharedPreferences(listKey, itemName);
    } else {
      // Add the item with favorites set to true by default
      Map<String, dynamic> newItem = {
        'name': itemName,
        'favorites': true,
      };
      itemList.add(newItem);
    }

    // Save the updated list to SharedPreferences
    saveList(listKey);
  }

  Future<void> removeItemFromSharedPreferences(
      String listKey, String itemName) async {
    // Read the list from SharedPreferences
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonString = prefs.getString(_getListKey(listKey));
      if (jsonString != null) {
        List<dynamic> decodedList = jsonDecode(jsonString);
        List<Map<String, dynamic>> externalList =
            decodedList.cast<Map<String, dynamic>>();

        // Remove the item from the external list
        externalList.removeWhere((element) => element['name'] == itemName);

        // Save the updated external list to SharedPreferences
        String updatedJsonString = jsonEncode(externalList);
        prefs.setString(_getListKey(listKey), updatedJsonString);
      }
    } catch (e) {
      print('Error removing item from SharedPreferences: $e');
      // Handle the error as needed
    }
  }

  String _getListKey(String listKey) {
    return '$keyPrefix$listKey';
  }
}

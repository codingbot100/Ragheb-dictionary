import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class RecentSearchManager {
  static const String _keyRecentSearches = 'recent_searches';

  Future<List<Map<String, String>>> getRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyRecentSearches) ?? '[]';
    return (jsonDecode(jsonString) as List)
        .cast<Map<String, String>>(); // Parse JSON to List<Map<String, String>>
  }

  Future<void> addRecentSearch(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, String>> searches = await getRecentSearches();

    // Remove duplicates
    searches.removeWhere((search) => search['name'] == query);

    // Add the new search to the list
    searches.insert(0, {'name': query, 'info': 'Info about $query'});

    // Limit the list to a certain number of searches (if desired)
    if (searches.length > 10) {
      searches = searches.sublist(0, 10);
    }

    // Save the updated list to SharedPreferences
    prefs.setString(_keyRecentSearches, jsonEncode(searches));
  }

  Future<void> deleteRecentSearch(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, String>> searches = await getRecentSearches();

    // Remove the search from the list
    searches.removeWhere((search) => search['name'] == query);

    // Save the updated list to SharedPreferences
    prefs.setString(_keyRecentSearches, jsonEncode(searches));
  }
}
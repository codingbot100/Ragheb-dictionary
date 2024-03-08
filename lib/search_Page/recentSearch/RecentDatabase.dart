// import 'package:shared_preferences/shared_preferences.dart';

// class RecentSearchManager {
//   static const String _keyRecentSearches = 'recent_searches';

//   Future<List<String>> getRecentSearches() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getStringList(_keyRecentSearches) ?? [];
//   }

//   Future<void> addRecentSearch(String query) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> recentSearches = prefs.getStringList(_keyRecentSearches) ?? [];
    
//     // Add the new search query to the list
//     recentSearches.insert(0, query);

//     // Limit the number of recent searches (optional)
//     if (recentSearches.length > 5) {
//       recentSearches = recentSearches.sublist(0, 5);
//     }

//     // Save the updated list
//     prefs.setStringList(_keyRecentSearches, recentSearches);
//   }
// }

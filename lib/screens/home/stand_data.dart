import 'dart:convert';

import 'package:flutter/services.dart';

class StandData {
  // static String? ing = "";
  // static List<dynamic> ingred = [];
  // static List<String> ingreds = [];
  // static List cits = [];
  static List<String> cities = [];
  static Future<List> parseJsonFromAssets(String assetsPath) async {
    return rootBundle.loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  static Future<void> getStands() async {
    // ingred = json.decode(await lstorage.getItem('ingreds'))['ingredients'];
   var cits = await parseJsonFromAssets('assets/cities.json');
    cities = List<String>.from(cits);
  }

  static List<String> getSuggestions(String query) {
    getStands();
    // print(cities);
    return query.isEmpty
        ? []
        : List.of(cities).where((ing) {
            final ingLower = ing.toLowerCase();
            final queryLower = query.toLowerCase();

            return ingLower.contains(queryLower);
          }).toList();
  }
}

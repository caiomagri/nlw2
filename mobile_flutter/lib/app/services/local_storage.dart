import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<List<dynamic>> loadFavorite() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String favsString = prefs.getString('favorites');
    if (favsString != null) {
      List<dynamic> favorites = jsonDecode(favsString);

      return favorites;
    }
    return [];
  }

  static void addFavorite(Map<String, dynamic> teacher) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> favorites = await loadFavorite();
    favorites.add(teacher);
    await prefs.setString('favorites', jsonEncode(favorites));
  }

  static void removeFavorite(int teacherId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> favorites = await loadFavorite();
    if (favorites.length > 0) {
      favorites.removeWhere((teacher) => teacher['id'] == teacherId);
      await prefs.setString('favorites', jsonEncode(favorites));
    }
  }
}

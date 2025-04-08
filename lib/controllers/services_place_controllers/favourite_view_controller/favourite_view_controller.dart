import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/salon.response.model.dart';

class FavouriteViewController extends GetxController {
  @override
  void onInit() {
    loadFavorites();
    super.onInit();
  }

  var favorites = <ServiceSalon>[].obs;
  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList('favorites');
    if (data != null) {
      favorites.clear();
      favorites.addAll(data.map((e) => ServiceSalon.fromJson(jsonDecode(e))));
    }
  }

  Future<void> toggleFavorite(ServiceSalon salon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String salonJson = jsonEncode(salon.toJson());

    if (favorites.any((e) => jsonEncode(e.toJson()) == salonJson)) {
      favorites.removeWhere((e) => jsonEncode(e.toJson()) == salonJson);
    } else {
      favorites.add(salon);
    }

    List<String> jsonList =
        favorites.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('favorites', jsonList);
    update(); // Notify listeners
  }

  bool isFavorite(ServiceSalon salon) {
    String salonJson = jsonEncode(salon.toJson());
    return favorites.any((e) => jsonEncode(e.toJson()) == salonJson);
  }
}

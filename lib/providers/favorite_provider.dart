import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../utils/db_helper.dart';

class FavoriteProvider with ChangeNotifier {
  List<Restaurant> _favorites = [];

  List<Restaurant> get favorites => _favorites;

  Future<void> loadFavorites() async {
    final data = await DBHelper.getFavorites();
    _favorites = data.map((item) => Restaurant.fromMap(item)).toList();
    notifyListeners();
  }

  Future<void> addFavorite(Restaurant restaurant) async {
    await DBHelper.insertFavorite(restaurant);
    _favorites.add(restaurant);
    notifyListeners();
  }

  Future<void> removeFavorite(String id) async {
    await DBHelper.removeFavorite(id);
    _favorites.removeWhere((restaurant) => restaurant.id == id);
    notifyListeners();
  }

  void toggleFavorite(Restaurant restaurant) {
    if (_favorites.contains(restaurant)) {
      _favorites.remove(restaurant);
    } else {
      _favorites.add(restaurant);
    }
    notifyListeners();
  }

  bool isFavorite(String id) {
    return _favorites.any((restaurant) => restaurant.id == id);
  }
}

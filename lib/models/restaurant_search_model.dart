// restaurant_search_model.dart
import '../models/restaurant_list_model.dart'; // Pastikan path ini benar

class RestaurantSearchResult {
  final List<Restaurant> restaurants;

  RestaurantSearchResult({required this.restaurants});

  factory RestaurantSearchResult.fromJson(Map<String, dynamic> json) {
    var list = json['restaurants'] as List;
    List<Restaurant> restaurantList =
        list.map((i) => Restaurant.fromJson(i)).toList();
    return RestaurantSearchResult(restaurants: restaurantList);
  }
}
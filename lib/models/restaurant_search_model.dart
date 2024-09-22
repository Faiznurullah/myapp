import '../models/restaurant_list_model.dart'; // Ganti dengan path model yang benar

class RestaurantSearchResult {
  final bool error;
  final int founded;
  final List<Restaurant>
      restaurants; // Menggunakan model Restaurant dari restaurant_list_model.dart

  RestaurantSearchResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearchResult.fromJson(Map<String, dynamic> json) {
    return RestaurantSearchResult(
      error: json['error'],
      founded: json['founded'],
      restaurants: (json['restaurants'] as List)
          .map((restaurant) => Restaurant.fromJson(
              restaurant)) // Pastikan menggunakan model yang benar
          .toList(),
    );
  }
}

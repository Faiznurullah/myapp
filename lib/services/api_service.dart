import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/restaurant_list_model.dart';
import '../models/restaurant_detail_model.dart';
import '../models/restaurant_search_model.dart';

class ApiService {
  final String baseUrl = 'https://restaurant-api.dicoding.dev/';

  // Fetch list of restaurants
  Future<List<Restaurant>> fetchRestaurants() async {
    final response = await http.get(Uri.parse('${baseUrl}list'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // Use RestaurantListResponse model to handle the list response
      final restaurantList = RestaurantListResponse.fromJson(jsonData);
      return restaurantList.restaurants; // Return the list of restaurants
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  // Fetch restaurant details
  Future<RestaurantDetail> fetchRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('${baseUrl}detail/$id'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // Use RestaurantDetailResponse model to handle the detail response
      final restaurantDetail = RestaurantDetailResponse.fromJson(jsonData);
      return restaurantDetail.restaurant; // Return restaurant detail
    } else {
      throw Exception('Failed to load restaurant details');
    }
  }

  // Search for restaurants
  Future<RestaurantSearchResult> searchRestaurants(String query) async {
    final response = await http.get(Uri.parse('${baseUrl}search?q=$query'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return RestaurantSearchResult.fromJson(
          jsonData); // Gunakan model hasil pencarian
    } else {
      throw Exception('Failed to search restaurants');
    }
  }
}

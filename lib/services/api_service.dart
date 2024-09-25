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
      final restaurantList = RestaurantListResponse.fromJson(jsonData);
      return restaurantList.restaurants;
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  // Fetch restaurant details
  Future<RestaurantDetail> fetchRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('${baseUrl}detail/$id'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final restaurantDetail = RestaurantDetailResponse.fromJson(jsonData);
      return restaurantDetail.restaurant;
    } else {
      throw Exception('Failed to load restaurant details');
    }
  }

  // Search for restaurants
  Future<RestaurantSearchResult> searchRestaurants(String query) async {
    final response = await http.get(Uri.parse('${baseUrl}search?q=$query'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return RestaurantSearchResult.fromJson(jsonData);
    } else {
      throw Exception('Failed to search restaurants');
    }
  }
}

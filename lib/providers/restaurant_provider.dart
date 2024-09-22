// lib/providers/restaurant_provider.dart

import 'package:flutter/material.dart';
import '../models/restaurant_list_model.dart';
import '../models/restaurant_detail_model.dart';
import '../models/restaurant_search_model.dart';
import '../services/api_service.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService});

  // State variables
  List<Restaurant> _restaurants = [];
  RestaurantDetail? _restaurantDetail;
  List<Restaurant> _searchResults = [];
  String _message = '';
  ResultState _state = ResultState.Loading;

  // Getters for state variables
  List<Restaurant> get restaurants => _restaurants;
  RestaurantDetail? get restaurantDetail => _restaurantDetail;
  List<Restaurant> get searchResults => _searchResults;
  String get message => _message;
  ResultState get state => _state;

  // Fetch all restaurants
  Future<void> fetchAllRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final fetchedRestaurants = await apiService.fetchRestaurants();
      if (fetchedRestaurants.isEmpty) {
        _state = ResultState.NoData;
        _message = 'No Restaurants Available';
      } else {
        _restaurants = fetchedRestaurants;
        _state = ResultState.HasData;
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Failed to load restaurants: $e';
    }
    notifyListeners();
  }

  // Fetch restaurant detail
  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final fetchedDetail = await apiService.fetchRestaurantDetail(id);
      _restaurantDetail = fetchedDetail;
      _state = ResultState.HasData;
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Failed to load restaurant details: $e';
    }
    notifyListeners();
  }

  // Search restaurants by query
  Future<void> searchRestaurants(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final fetchedSearchResults = await apiService.searchRestaurants(query);
      // Access the restaurants list from the RestaurantSearchResult object
      if (fetchedSearchResults.restaurants.isEmpty) {
        _state = ResultState.NoData;
        _message = 'No restaurants found for "$query"';
      } else {
        _searchResults = fetchedSearchResults.restaurants; // Assign the list of restaurants
        _state = ResultState.HasData;
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Failed to search restaurants: $e';
    }
    notifyListeners();
  }
}

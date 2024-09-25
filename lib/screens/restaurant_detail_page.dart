import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import '../providers/favorite_provider.dart';
import '../models/restaurant.dart';
import '../models/restaurant_detail_model.dart';

class RestaurantDetailPage extends StatelessWidget {
  final String id;

  RestaurantDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RestaurantProvider>(context, listen: false)
          .fetchRestaurantDetail(id);
      Provider.of<FavoriteProvider>(context, listen: false).loadFavorites();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Restoran'),
        actions: [
          Consumer<RestaurantProvider>(
            builder: (context, restaurantProvider, child) {
              if (restaurantProvider.state == ResultState.HasData) {
                var restaurantDetail = restaurantProvider.restaurantDetail!;
                return Consumer<FavoriteProvider>(
                  builder: (context, favoriteProvider, child) {
                    // Mengecek apakah restoran ini merupakan favorit
                    final isFavorite =
                        favoriteProvider.isFavorite(restaurantDetail.id);

                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: () {
                        // Membuat objek Restaurant dari RestaurantDetail
                        final restaurant = Restaurant(
                          id: restaurantDetail.id,
                          name: restaurantDetail.name,
                          description: restaurantDetail.description,
                          pictureId: restaurantDetail.pictureId,
                          city: restaurantDetail.city,
                          rating: restaurantDetail.rating,
                        );

                        // Toggle favorit
                        favoriteProvider.toggleFavorite(restaurant);
                      },
                    );
                  },
                );
              } else {
                return Container(); // Return empty container jika belum ada data
              }
            },
          ),
        ],
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.state == ResultState.HasData) {
            var restaurant = provider.restaurantDetail!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey,
                        child: Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 50,
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('City: ${restaurant.city}',
                            style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text('Rating: ${restaurant.rating}',
                            style: TextStyle(fontSize: 16)),
                        SizedBox(height: 16),
                        Text(
                          restaurant.description,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (provider.state == ResultState.Error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Failed to load restaurant details',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      provider.fetchRestaurantDetail(id);
                    },
                    child: Text('Try Again'),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No details available'));
          }
        },
      ),
    );
  }
}

// lib/screens/restaurant_list_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import 'restaurant_detail_page.dart';
import 'search_delegate.dart';

class RestaurantListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Memanggil fetchAllRestaurants saat halaman dibangun
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RestaurantProvider>(context, listen: false)
          .fetchAllRestaurants();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Restoran'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: RestaurantSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.state == ResultState.HasData) {
            return ListView.builder(
              itemCount: provider.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = provider.restaurants[index];
                return ListTile(
                  leading: Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  title: Text(restaurant.name),
                  subtitle:
                      Text('${restaurant.city} • Rating: ${restaurant.rating}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RestaurantDetailPage(id: restaurant.id),
                      ),
                    );
                  },
                );
              },
            );
          } else if (provider.state == ResultState.Error) {
            return Center(child: Text(provider.message));
          } else {
            return Center(child: Text('No restaurants available'));
          }
        },
      ),
    );
  }
}

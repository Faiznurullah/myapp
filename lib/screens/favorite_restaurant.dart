import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import 'restaurant_detail_page.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Restaurants')),
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, child) {
          if (provider.favorites.isEmpty) {
            return Center(child: Text('No favorites added'));
          }

          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              var restaurant = provider.favorites[index];
              return ListTile(
                title: Text(restaurant.name),
                subtitle: Text(restaurant.city),
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
        },
      ),
    );
  }
}

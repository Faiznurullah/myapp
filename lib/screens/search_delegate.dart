import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import 'restaurant_detail_page.dart';

class RestaurantSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context); // Tampilkan kembali saran pencarian
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Menutup search
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text('Please enter a restaurant name or menu to search'),
      );
    }

    final provider = Provider.of<RestaurantProvider>(context, listen: false);
    provider.searchRestaurants(query);

    return Consumer<RestaurantProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (provider.state == ResultState.HasData) {
          return ListView.builder(
            itemCount: provider.searchResults.length,
            itemBuilder: (context, index) {
              var restaurant = provider.searchResults[index];
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
          return Center(child: Text('No restaurants found for "$query"'));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(child: Text('Cari restoran berdasarkan nama atau menu'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('Searching for "$query"...'),
    );
  }
}

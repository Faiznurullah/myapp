import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  final String id;

  RestaurantDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    // Memanggil fetchRestaurantDetail saat halaman dibangun
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RestaurantProvider>(context, listen: false)
          .fetchRestaurantDetail(id);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Restoran'),
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
                        Text(
                          'City: ${restaurant.city}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Rating: ${restaurant.rating}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Address: ${restaurant.address}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 16),
                        Text(
                          restaurant.description,
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Categories',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: restaurant.categories
                              .map((category) =>
                                  Chip(label: Text(category.name)))
                              .toList(),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Menu Makanan',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ...restaurant.menus.foods.map((food) => ListTile(
                              leading: Icon(Icons.food_bank),
                              title: Text(food.name),
                            )),
                        SizedBox(height: 16),
                        Text(
                          'Menu Minuman',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ...restaurant.menus.drinks.map((drink) => ListTile(
                              leading: Icon(Icons.local_drink),
                              title: Text(drink.name),
                            )),
                        SizedBox(height: 16),
                        Text(
                          'Customer Reviews',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ...restaurant.customerReviews.map((review) => ListTile(
                              leading: CircleAvatar(
                                child: Text(review.name[0]),
                              ),
                              title: Text(review.name),
                              subtitle: Text(review.review),
                              trailing: Text(review.date),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (provider.state == ResultState.Error) {
            return Center(child: Text(provider.message));
          } else {
            return Center(child: Text('No details available'));
          }
        },
      ),
    );
  }
}

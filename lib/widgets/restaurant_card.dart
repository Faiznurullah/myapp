import 'package:flutter/material.dart';
import '../models/restaurant_list_model.dart'; // Ganti dengan model yang sesuai
import '../screens/restaurant_detail_page.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant
      restaurant;
      
  const restaurantId = null; // Tipe data sesuai dengan model terbaru untuk daftar restoran

  const RestaurantCard({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}', // Sesuaikan URL gambar
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.broken_image,
                  size: 100); // Gambar placeholder saat gagal dimuat
            },
          ),
        ),
        title: Text(
          restaurant.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(restaurant.city),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Colors.yellow[700]),
            SizedBox(width: 4),
            Text(
              restaurant.rating.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RestaurantDetailPage(
                  restaurantId: restaurant.id), // Navigasi dengan ID
            ),
          );
        },
      ),
    );
  }
}

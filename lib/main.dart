import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Restoran',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RestaurantListPage(),
    );
  }
}

class RestaurantListPage extends StatefulWidget {
  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  List restaurants = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/data/data.json');
    setState(() {
      var jsonData = json.decode(jsonString);
      restaurants = jsonData['restaurants']; // Akses array "restaurants"
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Restoran'),
      ),
      body: restaurants.isEmpty
          ? Center(child: CircularProgressIndicator()) // Loading indicator
          : ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return ListTile(
                  leading: Image.network(restaurant['pictureId']),
                  title: Text(restaurant['name']),
                  subtitle: Text(restaurant['city']),
                  onTap: () {
                    // Navigate to detail page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailPage(
                          restaurant: restaurant,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class RestaurantDetailPage extends StatelessWidget {
  final Map restaurant;

  RestaurantDetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(restaurant['pictureId']),
              SizedBox(height: 10),
              Text(
                restaurant['description'],
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Text(
                'Menu Makanan:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              ...List<Widget>.from(restaurant['menus']['foods']
                  .map((item) => Text("- ${item['name']}"))),
              SizedBox(height: 20),
              Text(
                'Menu Minuman:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              ...List<Widget>.from(restaurant['menus']['drinks']
                  .map((item) => Text("- ${item['name']}"))),
            ],
          ),
        ),
      ),
    );
  }
}

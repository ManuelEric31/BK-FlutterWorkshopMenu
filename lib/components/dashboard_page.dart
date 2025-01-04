// lib/widgets/dashboard_column.dart
import 'package:flutter/material.dart';
import 'package:food_finder/components/restaurant_card.dart';
import 'package:food_finder/helpers/api_services.dart';

import '../models/restaurant.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Restaurant> _restaurants = [];
  APIServices api = APIServices();

  Future<void> getResto() async {
    api.getResto().then((responses) {
      print(responses);
      setState(() {
        _restaurants = responses;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getResto();
  }

  void _onSearchChanged(String query) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: TextField(
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              labelText: 'Cari Restoran',
              prefixIcon: Icon(Icons.search, color: Colors.blue[900]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue[900]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue[900]!),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = _restaurants[index];
              return RestaurantCard(restaurant: restaurant);
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class RestaurantMenuDashboard extends StatelessWidget {
  const RestaurantMenuDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant Menu Dashboard')),
      body: const Center(
        child: Text(
          'Welcome to the Restaurant Menu Dashboard!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

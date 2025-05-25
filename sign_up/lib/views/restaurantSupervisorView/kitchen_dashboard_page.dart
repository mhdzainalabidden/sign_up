import 'package:flutter/material.dart';

class RestaurantSupervisorDashboard extends StatelessWidget {
  const RestaurantSupervisorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Kitchen Supervisor Dashboard',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class KitchenDashboardPage extends StatelessWidget {
  const KitchenDashboardPage({super.key});

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

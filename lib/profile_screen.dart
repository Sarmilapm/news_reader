import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(child:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/person.png"),
            ),
            const SizedBox(height: 16),
            const Text(
              "Sarmila",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "User ID: 123456",
              style: TextStyle(fontSize: 16, ),
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade300, thickness: 1),
            const SizedBox(height: 16),


            _buildInfoRow(Icons.email, "sarmila@example.com",context),
            _buildInfoRow(Icons.location_on, "Karur,Tamil Nadu",context),
            _buildInfoRow(Icons.cake, "May 15, 2000",context),
            _buildInfoRow(Icons.phone, "+91 98765 43210",context),

            const SizedBox(height: 20),
            Divider(color: Colors.grey.shade300, thickness: 1),
          ],
        ),
      ),
    ));
  }

  Widget _buildInfoRow(IconData icon, String info,BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color:  Colors.grey, size: 19),
          const SizedBox(width: 12),
          Text(
            info,
            style: const TextStyle(fontSize: 17),
          ),
        ],
      ),
    );
  }
}

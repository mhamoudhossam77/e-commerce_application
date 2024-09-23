import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ElectronicDeviceCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String price;

  ElectronicDeviceCard({required this.name, required this.imageUrl, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              price,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
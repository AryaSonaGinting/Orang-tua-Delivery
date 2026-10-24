import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../screens/restaurant_detail_page.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RestaurantDetailPage(
                restaurant: restaurant,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Tempat foto toko
              Container(
                width: 90,  // Lebar seragam untuk semua foto
                height: 90, // Tinggi seragam untuk semua foto
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    restaurant.imagePath, // Memanggil foto sesuai toko
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover, // Memastikan gambar terpotong rapi & presisi
                    errorBuilder: (context, error, stackTrace) {
                      // Tampilan cadangan jika gambar gagal dimuat
                      return const Icon(
                        Icons.restaurant,
                        size: 45,
                        color: Colors.orange,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      restaurant.category,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 17,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 4),
                        Text(restaurant.rating),

                        const SizedBox(width: 12),

                        const Icon(
                          Icons.access_time,
                          size: 17,
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 4),

                        Text(restaurant.deliveryTime),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
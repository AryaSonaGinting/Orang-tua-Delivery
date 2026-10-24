import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String image;
  final String name;

  const CategoryItem({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              image,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            )
          ),
          const SizedBox(height: 6),
          Text(name),
        ],
      ),
    );
  }
}
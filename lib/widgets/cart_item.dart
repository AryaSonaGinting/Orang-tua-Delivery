import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String name;
  final int price;
  final int quantity;

  const CartItem({
    super.key,
    required this.name,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.orange,
          child: Icon(
            Icons.fastfood,
            color: Colors.white,
          ),
        ),

        title: Text(name),

        subtitle: Text('Rp$price'),

        trailing: Text('x$quantity'),
      ),
    );
  }
}
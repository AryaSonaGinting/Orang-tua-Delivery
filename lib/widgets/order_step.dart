import 'package:flutter/material.dart';

class OrderStep extends StatelessWidget {
  final String title;
  final bool completed;

  const OrderStep({
    super.key,
    required this.title,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(
            completed
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color:
            completed ? Colors.green : Colors.grey,
          ),

          const SizedBox(width: 15),

          Text(
            title,
            style: TextStyle(
              fontWeight: completed
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
class Subtotal extends StatelessWidget {
  final String sum;
  const Subtotal({super.key, required this.sum});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "SubTotal",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            "\$$sum",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

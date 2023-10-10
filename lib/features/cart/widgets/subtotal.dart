import 'package:flutter/material.dart';
import 'package:jugaad_junction/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Subtotal extends StatelessWidget {
  const Subtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final userCart = context.watch<UserProvider>().user.cart;
    double sum = 0;
    userCart.map((e) => sum += e['quantity'] * e['product']['price']).toList();

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

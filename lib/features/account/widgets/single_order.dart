// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SingleOrder extends StatelessWidget {
  SingleOrder({super.key});

  List<String> orderImages = [
    'https://cdn5.vectorstock.com/i/1000x1000/80/84/shopping-cart-with-products-supermarket-vector-29628084.jpg',
    'https://cdn5.vectorstock.com/i/1000x1000/80/84/shopping-cart-with-products-supermarket-vector-29628084.jpg',
    'https://cdn5.vectorstock.com/i/1000x1000/80/84/shopping-cart-with-products-supermarket-vector-29628084.jpg',
    'https://cdn5.vectorstock.com/i/1000x1000/80/84/shopping-cart-with-products-supermarket-vector-29628084.jpg',
    'https://cdn5.vectorstock.com/i/1000x1000/80/84/shopping-cart-with-products-supermarket-vector-29628084.jpg',
    'https://cdn5.vectorstock.com/i/1000x1000/80/84/shopping-cart-with-products-supermarket-vector-29628084.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: orderImages.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(8),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              shadowColor: Colors.grey,
              elevation: 5,
              child: Image.network(
                orderImages[index],
                fit: BoxFit.cover,
              ),
            );
          }),
    );
  }
}

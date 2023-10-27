import 'package:flutter/material.dart';
import 'package:jugaad_junction/models/order.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details-screen';
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

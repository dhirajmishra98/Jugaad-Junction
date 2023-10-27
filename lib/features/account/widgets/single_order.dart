// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/widgets/loader.dart';
import 'package:jugaad_junction/features/account/screens/order_details_screen.dart';
import 'package:jugaad_junction/features/account/services/account_service.dart';

import '../../../models/order.dart';

class SingleOrder extends StatefulWidget {
  const SingleOrder({super.key});

  @override
  State<SingleOrder> createState() => _SingleOrderState();
}

class _SingleOrderState extends State<SingleOrder> {
  List<Order>? orders;
  final AccountService _accountService = AccountService();

  @override
  void initState() {
    super.initState();
    fetchMyOrders();
  }

  void fetchMyOrders() async {
    orders = await _accountService.fetchOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : orders!.isEmpty
            ? const SizedBox()
            : SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    if (orders![index].products.isEmpty) return Container();
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        OrderDetailsScreen.routeName,
                        arguments: orders![index],
                      ),
                      child: Card(
                        margin: const EdgeInsets.all(8),
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        shadowColor: Colors.grey,
                        elevation: 5,
                        child: Image.network(
                          orders![index].products[0].images[0],
                          fit: BoxFit.cover,
                          height: 100,
                          width: 150,
                        ),
                      ),
                    );
                  },
                ),
              );
  }
}

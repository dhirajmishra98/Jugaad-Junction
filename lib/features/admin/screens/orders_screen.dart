import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/widgets/loader.dart';
import 'package:jugaad_junction/features/account/screens/order_details_screen.dart';
import 'package:jugaad_junction/features/admin/services/admin_service.dart';
import 'package:jugaad_junction/features/admin/widgets/single_product.dart';

import '../../../models/order.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = '/orders-screen';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final AdminService _adminService = AdminService();
  List<Order>? orders;

  @override
  void initState() {
    super.initState();
    fetchAllOrders();
  }

  void fetchAllOrders() async {
    orders = await _adminService.getOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Orders",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
        ),
        centerTitle: true,
      ),
      body: orders == null
          ? const Loader()
          : orders!.isEmpty
              ? const Center(
                  child: Text("No orders let for fulfillment"),
                )
              : GridView.builder(
                  itemCount: orders!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final orderData = orders![index];
                    return orderData.products.isEmpty
                        ? Container()
                        : GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              OrderDetailsScreen.routeName,
                              arguments: orderData,
                            ),
                            child: SizedBox(
                              height: 150,
                              width: 100,
                              child: Column(
                                children: [
                                  SingleProduct(
                                    image: orderData.products[0].images[0],
                                  ),
                                  Text(" Order Status : ${orderData.status}"),
                                ],
                              ),
                            ),
                          );
                  },
                ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/global_variables.dart';
import 'package:jugaad_junction/features/cart/widgets/cart_product.dart';
import 'package:jugaad_junction/features/cart/widgets/subtotal.dart';
import 'package:jugaad_junction/features/home/widgets/address_box.dart';
import 'package:jugaad_junction/initials/widgets/custom_button.dart';
import 'package:jugaad_junction/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: GlobalVariables.secondaryColor,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: AddressBox()),
          const SliverToBoxAdapter(child: Subtotal()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: "Proceed to Buy (${user.cart.length} Item)",
                onTap: () {},
              ),
            ),
          ),
          SliverList.builder(
            itemCount: user.cart.length,
            itemBuilder: (context, index) {
              return CartProduct(index: index);
            },
          ),
        ],
      ),
    );
  }
}

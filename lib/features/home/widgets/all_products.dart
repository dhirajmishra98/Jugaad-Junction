import 'package:flutter/material.dart';
import 'package:jugaad_junction/features/home/screens/product_detail_screen.dart';
import 'package:jugaad_junction/common/widgets/linear_loader.dart';
import 'package:jugaad_junction/features/home/services/home_service.dart';
import 'package:jugaad_junction/features/home/widgets/product_card.dart';
import 'package:jugaad_junction/models/product.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final HomeService _homeService = HomeService();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    products = await _homeService.fetchProducts(context);
    setState(() {});
  }

  void navigateToProductDetailScreen(Product product) {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const SliverToBoxAdapter(child: LinearLoader())
        : products!.isEmpty
            ? const SliverToBoxAdapter(
                child: Center(
                  child: Text("No Products Found!"),
                ),
              )
            : SliverGrid.builder(
                itemCount: products!.length,
                itemBuilder: (context, index) {
                  Product product = products![index];
                  return GestureDetector(
                    onTap: () => navigateToProductDetailScreen(product),
                    child: ProductCard(
                      product: product,
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  mainAxisExtent: 300,
                ),
              );
  }
}

import 'package:flutter/material.dart';
import 'package:jugaad_junction/features/home/screens/product_detail_screen.dart';
import 'package:jugaad_junction/common/widgets/loader.dart';
import 'package:jugaad_junction/features/home/services/home_service.dart';

import '../../../models/product.dart';
import '../widgets/product_card.dart';

class ProductCategoryScreen extends StatefulWidget {
  static const String routeName = '/product-category-screen';
  const ProductCategoryScreen({required this.category, super.key});

  final String category;

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  final HomeService _homeService = HomeService();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    getProductByCategory();
  }

  Future<void> getProductByCategory() async {
    final String category = widget.category;
    products = await _homeService.fetchProductsByCategory(category, context);
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
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.grey,
        centerTitle: true,
        title: Text(widget.category),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text("Keep Shopping for ${widget.category}"),
          ),
          products == null
              ? const Loader()
              : products!.isEmpty
                  ? const Center(
                      child: Text("No products in this collection"),
                    )
                  : Expanded(
                      child: GridView.builder(
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          mainAxisExtent: 300,
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}

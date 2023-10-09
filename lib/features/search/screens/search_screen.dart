import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/widgets/loader.dart';
import 'package:jugaad_junction/features/home/widgets/address_box.dart';
import 'package:jugaad_junction/features/search/services/search_service.dart';
import 'package:jugaad_junction/features/search/widgets/searched_product.dart';

import '../../home/screens/product_detail_screen.dart';
import '../../../models/product.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchService _searchService = SearchService();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    getSearchedProduct();
  }

  Future<void> getSearchedProduct() async {
    products = await _searchService.fetchSearchedProducts(
        searchQuery: widget.searchQuery, context: context);
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
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Your Searched Products!'),
      ),
      body: products == null
          ? const Loader()
          : products!.isEmpty
              ? const Center(
                  child: Text('No Products Matched!'),
                )
              : Column(
                  children: [
                    const AddressBox(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: products!.length,
                        itemBuilder: (context, index) {
                          Product product = products![index];
                          return GestureDetector(
                            onTap: () => navigateToProductDetailScreen(product),
                            child: SearchedProduct(
                              product: product,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}

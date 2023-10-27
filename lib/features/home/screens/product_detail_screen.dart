import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jugaad_junction/common/widgets/stars_rating.dart';
import 'package:jugaad_junction/features/cart/screens/cart_screen.dart';
import 'package:jugaad_junction/features/home/services/product_services.dart';
import 'package:jugaad_junction/models/product.dart';
import 'package:jugaad_junction/providers/user_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../search/screens/search_screen.dart';
import '../../../initials/widgets/custom_button.dart';
import '../../../common/global_variables.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-detail-screen';
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductServices _productServices = ProductServices();
  final TextEditingController _searchProductController =
      TextEditingController();
  double avgRating = 0.0;
  double userRating = 0.0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0.0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        userRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0.0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void navigateToSearchScreen(String searchQeury) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: searchQeury,
    );
  }

  void ratingProduct(double rating) async {
    _productServices.rateProduct(
        context: context, product: widget.product, rating: rating);
  }

  void addToCart() async {
    _productServices.addToCart(context: context, product: widget.product);
  }

  void navigateToCartScreen() {
    MaterialPageRoute(
      builder: (context) => const CartScreen(),
    );
  }

  @override
  void dispose() {
    _searchProductController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, size.height * 0.08),
        child: AppBar(
          titleSpacing: 0,
          backgroundColor: GlobalVariables.secondaryColor,
          flexibleSpace: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Lottie.asset('assets/animations/waving_hi.json',
                    repeat: true, reverse: true, height: 50, width: 50),
                Container(
                  height: size.height * 0.05,
                  width: size.width * 0.75,
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      if (value.isNotEmpty) {
                        navigateToSearchScreen(value);
                      }
                    },
                    controller: _searchProductController,
                    decoration: InputDecoration(
                      hintText: "Search Products",
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: InkWell(
                        onTap: () {
                          String searchQuery =
                              _searchProductController.text.trim();
                          navigateToSearchScreen(searchQuery);
                        },
                        child: const Icon(
                          Icons.search_outlined,
                        ),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: const EdgeInsets.only(top: 10),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.mic_outlined,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "id: ${widget.product.id!}",
                  ),
                  StarsRating(
                    rating: avgRating,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map(
                (i) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 300,
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  text: 'Deal Price: ',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: '\$${widget.product.price}',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'Buy Now',
                onTap: navigateToCartScreen,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'Add to Cart',
                onTap: addToCart,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Rate The Product',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RatingBar.builder(
              initialRating: userRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: GlobalVariables.secondaryColor,
              ),
              onRatingUpdate: (rating) => ratingProduct(rating),
            ),
          ],
        ),
      ),
    );
  }
}

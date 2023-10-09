import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/global_variables.dart';
import 'package:jugaad_junction/common/widgets/linear_loader.dart';
import 'package:jugaad_junction/features/home/screens/product_detail_screen.dart';
import 'package:jugaad_junction/features/home/services/product_services.dart';
import 'package:jugaad_junction/models/product.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  final ProductServices _productServices = ProductServices();
  Product? product;

  @override
  void initState() {
    super.initState();
    getDealOfDay();
  }

  void getDealOfDay() async {
    product = await _productServices.getDealOfDay(context);
    setState(() {});
  }

  void navigateToProductDetailScreen() {
    Navigator.pushNamed(context, ProductDetailScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const LinearLoader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToProductDetailScreen,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Deal Of The Day',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ListTile(
                        title: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.network(
                            product!.images[0],
                            fit: BoxFit.cover,
                            height: 250,
                          ),
                        ),
                        subtitle: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          child: Container(
                            color: const Color.fromARGB(255, 220, 213, 213),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 5, right: 40),
                                  child: Text(
                                    product!.name.length <= 11
                                        ? product!.name
                                        : '${product!.name.substring(0, 12)}...',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 15),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    '\$ ${product!.price}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: GlobalVariables.secondaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: product!.images
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Image.network(
                                    e,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}

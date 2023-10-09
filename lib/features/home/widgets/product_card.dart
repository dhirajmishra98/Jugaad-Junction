import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/global_variables.dart';
import 'package:like_button/like_button.dart';
import 'package:remixicon/remixicon.dart';

import '../../../models/product.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(GlobalVariables.cardColor),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.grey.withOpacity(.3), width: .2)),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                product.images[0],
                fit: BoxFit.cover,
                height: 150,
                width: 150,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              product.name,
              maxLines: 1,
              softWrap: true,
              style: const TextStyle(
                fontSize: 20.0,
                fontFamily: "Raleway",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                LikeButton(
                  circleColor: const CircleColor(
                      start: Color(0xff00ddff), end: Color(0xff0099cc)),
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: Colors.blue,
                    dotSecondaryColor: Colors.white,
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      Remix.heart_3_fill,
                      color: isLiked ? Colors.blueAccent : Colors.grey,
                    );
                  },
                ),
                Column(
                  children: <Widget>[
                    Text(
                      product.price.toString(),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 136, 132, 250),
                        fontSize: 16.0,
                        fontFamily: "Helvetica",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Useful Info...",
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: "Helvetica",
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Remix.shopping_cart_2_fill,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

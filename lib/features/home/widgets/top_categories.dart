import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/global_variables.dart';
import 'package:jugaad_junction/features/home/screens/product_category_screen.dart';

class TopCategories extends StatefulWidget {
  const TopCategories({super.key});

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
  void navigateToProductCategoryScreen(int index) {
    Navigator.pushNamed(
      context,
      ProductCategoryScreen.routeName,
      arguments: GlobalVariables.topCategories[index]['title']!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Product Categories",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "See all",
                    style: TextStyle(color: GlobalVariables.secondaryColor),
                  ))
            ],
          ),
        ),
        Container(
          height: size.height * 0.12,
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: GlobalVariables.topCategories.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => navigateToProductCategoryScreen(index),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                              GlobalVariables.topCategories[index]['image']!),
                          radius: 30,
                        ),
                      ),
                      Text(
                        GlobalVariables.topCategories[index]['title']!,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}

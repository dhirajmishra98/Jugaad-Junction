import 'package:flutter/material.dart';
import 'package:jugaad_junction/constants/global_variables.dart';

class TopCategories extends StatefulWidget {
  const TopCategories({super.key});

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
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
                    onTap: () {},
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
    );
  }
}

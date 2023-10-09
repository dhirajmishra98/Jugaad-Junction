import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/global_variables.dart';

class CarouselCategories extends StatefulWidget {
  const CarouselCategories({super.key});

  @override
  State<CarouselCategories> createState() => _CarouselCategoriesState();
}

class _CarouselCategoriesState extends State<CarouselCategories> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider(
          items: GlobalVariables.carouselImages.map((e) {
            return Builder(
              builder: (context) => Image.network(
                e,
                fit: BoxFit.cover,
                height: 200,
              ),
            );
          }).toList(),
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
            viewportFraction: 1,
            height: 200,
            autoPlay: true,
            autoPlayCurve: Curves.decelerate,
          ),
        ),
        CarouselIndicator(
          count: GlobalVariables.carouselImages.length,
          index: currentIndex,
          color: Colors.grey,
          activeColor: GlobalVariables.secondaryColor,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/global_variables.dart';
import 'package:jugaad_junction/features/home/widgets/address_box.dart';
import 'package:jugaad_junction/features/home/widgets/all_products.dart';
import 'package:jugaad_junction/features/home/widgets/carousel_categories.dart';
import 'package:jugaad_junction/features/home/widgets/deal_of_day.dart';
import 'package:jugaad_junction/features/home/widgets/top_categories.dart';
import 'package:jugaad_junction/features/search/screens/search_screen.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchProductController =
      TextEditingController();

  navigateToSearchScreen(String searchQeury) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: searchQeury,
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
      body: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AddressBox(),
          ),
          SliverToBoxAdapter(
            child: CarouselCategories(),
          ),
          SliverToBoxAdapter(
            child: TopCategories(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(),
          ),
          SliverToBoxAdapter(
            child: DealOfDay(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "All products",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          AllProducts(),
        ],
      ),
    );
  }
}

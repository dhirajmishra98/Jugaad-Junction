import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/global_variables.dart';
import 'package:jugaad_junction/common/widgets/loader.dart';
import 'package:jugaad_junction/common/utils.dart';
import 'package:jugaad_junction/features/admin/screens/add_product_screen.dart';
import 'package:jugaad_junction/features/admin/services/admin_service.dart';
import 'package:jugaad_junction/models/product.dart';

import '../widgets/single_product.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin-screen';
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final AdminService _adminService = AdminService();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  void fetchAllProducts() async {
    products = await _adminService.getProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    _adminService.removeProduct(context, product, () {
      products!.removeAt(index);
      setState(() {});
      showSnackBar(context, "Product Deleted Successfully!");
    });
  }

  void logout() {
    _adminService.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.secondaryColor,
        title: const Text(
          "Admin Panel",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(
              Icons.logout_outlined,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: products == null
            ? const Loader()
            : products!.isEmpty
                ? const Text('Add Products')
                : GridView.builder(
                    itemCount: products!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      final productData = products![index];
                      return Card(
                        elevation: 2,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 140,
                              child: SingleProduct(
                                image: productData.images[0],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Text(
                                      productData.name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        deleteProduct(productData, index),
                                    icon: const Icon(
                                      Icons.delete_outline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProductScreen(),
            ),
          );
        },
        tooltip: "Add a product",
        child: const Icon(Icons.add),
      ),
    );
  }
}

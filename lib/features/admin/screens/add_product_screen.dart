import 'dart:io';

import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:jugaad_junction/common/utils.dart';
import 'package:jugaad_junction/features/admin/services/admin_service.dart';
import 'package:jugaad_junction/initials/widgets/custom_button.dart';
import 'package:jugaad_junction/initials/widgets/custom_textfield.dart';

import '../../../common/global_variables.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();
  final _addProductFormKey = GlobalKey<FormState>();
  final AdminService _adminService = AdminService();

  List<File> images = [];
  int currentIndex = 0;
  List<String> categories = <String>[
    'Mobiles',
    'Appliances',
    'Books',
    'Essentials',
    'Fashion',
    'Furniture',
    'Headphones',
    'Sports'
  ];
  String dropdownValue = 'Mobiles';

  void selectFiles() async {
    var result = await pickFiles(context);
    setState(() {
      images = result;
    });
  }

  void addProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      _adminService.sellProduct(
        context: context,
        productName: _productNameController.text,
        productDescription: _productDescriptionController.text,
        productPrice: double.parse(_productPriceController.text.trim()),
        productQuantity: double.parse(_productQuantityController.text.trim()),
        productCategory: dropdownValue,
        productImages: images,
      );
    }
  }

  @override
  void dispose() {
    _productDescriptionController.dispose();
    _productNameController.dispose();
    _productPriceController.dispose();
    _productQuantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _addProductFormKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: selectFiles,
                    child: images.isEmpty
                        ? DottedBorder(
                            strokeWidth: 1,
                            borderType: BorderType.RRect,
                            borderPadding: const EdgeInsets.all(5),
                            dashPattern: const [10, 4],
                            radius: const Radius.circular(15),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              height: size.height * 0.2,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_open_outlined,
                                    size: 35,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    'Select Product Images',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CarouselSlider(
                                items: images.map((e) {
                                  return Builder(
                                    builder: (context) => Image.file(
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
                                count: images.length,
                                index: currentIndex,
                                color: Colors.grey,
                                activeColor: GlobalVariables.secondaryColor,
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                      controller: _productNameController,
                      labelText: "Product Name"),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _productDescriptionController,
                    labelText: "Product Description",
                    maxLines: 7,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                      controller: _productPriceController,
                      labelText: "Product Price"),
                  const SizedBox(height: 10),
                  CustomTextField(
                      controller: _productQuantityController,
                      labelText: "Product Quantity"),
                  const SizedBox(height: 20),
                  const Text(
                    "Select Categories",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      underline: const SizedBox(),
                      isExpanded: true,
                      style: const TextStyle(color: Colors.black),
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: Colors.black),
                      selectedItemBuilder: (BuildContext context) {
                        return categories.map((String value) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              dropdownValue,
                            ),
                          );
                        }).toList();
                      },
                      items: categories
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  CustomButton(text: "Sell Product", onTap: addProduct),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ));
  }
}

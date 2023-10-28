import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/widgets/loader.dart';
import 'package:jugaad_junction/features/admin/services/admin_service.dart';
import 'package:jugaad_junction/features/admin/widgets/category_products_chart.dart';

import '../../../models/sales.dart';

class AnalyticsScreen extends StatefulWidget {
  static const String routeName = '/analytics-screen';
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminService _adminService = AdminService();
  int? totalEarnings;
  List<Sales>? sales;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningData = await _adminService.getAnalytics(context);
    totalEarnings = earningData['totalEarnings'];
    sales = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return sales == null || totalEarnings == null
        ? const Loader()
        : sales!.isEmpty
            ? const Center(
                child: Text("No Sales"),
              )
            : Scaffold(
                appBar: AppBar(
                  title: const Text("Analytics"),
                  centerTitle: true,
                ),
                body: Column(
                  children: [
                    Text(
                      'Total Earnings : \$$totalEarnings',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 550,
                      child: CategoryProductsChart(salesList: sales!),
                    ),
                  ],
                ),
              );
  }
}

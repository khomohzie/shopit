import 'package:shopit/common/widgets/loader.dart';
import 'package:shopit/features/admin/models/sales.dart';
import 'package:shopit/features/admin/services/admin.service.dart';
import 'package:shopit/features/admin/widgets/category_products_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminService adminService = AdminService();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminService.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                '\$$totalSales',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 250.0,
                child: CategoryProductsChart(seriesList: [
                  charts.Series(
                    id: 'Sales',
                    data: earnings!,
                    domainFn: (Sales sales, _) => sales.label,
                    measureFn: (Sales sales, _) => sales.earning,
                  ),
                ]),
              )
            ],
          );
  }
}

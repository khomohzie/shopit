import 'package:flutter/material.dart';
import 'package:shopit/common/widgets/loader.dart';
import 'package:shopit/constants/global_variables.dart';
import 'package:shopit/features/account/services/account.service.dart';
import 'package:shopit/features/account/widgets/single_product.dart';
import 'package:shopit/features/order_details/screens/order_details.screen.dart';
import 'package:shopit/models/order.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders = [];

  final AccountService accountService = AccountService();

  void fetchOrders() async {
    orders = await accountService.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      'See all',
                      style:
                          TextStyle(color: GlobalVariables.selectedNavBarColor),
                    ),
                  ),
                ],
              ),
              // Display orders
              Container(
                height: 170.0,
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 20.0,
                  right: 0,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, OrderDetailScreen.routeName,
                            arguments: orders![index]);
                      },
                      child: SingleProduct(
                        image: orders![index].products[0].images[0],
                      ),
                    );
                  }),
                ),
              )
            ],
          );
  }
}

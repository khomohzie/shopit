import 'package:flutter/material.dart';
import 'package:shopit/common/widgets/bottom_bar.dart';
import 'package:shopit/features/address/screens/address.screen.dart';
import 'package:shopit/features/admin/screens/add_product.screen.dart';
import 'package:shopit/features/auth/screens/auth.screen.dart';
import 'package:shopit/features/home/screens/category_deals.screen.dart';
import 'package:shopit/features/home/screens/home.screen.dart';
import 'package:shopit/features/order_details/screens/order_details.screen.dart';
import 'package:shopit/features/product_details/screens/product_details.screen.dart';
import 'package:shopit/features/search/screens/search.screen.dart';
import 'package:shopit/models/order.dart';
import 'package:shopit/models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AuthScreen(),
        settings: routeSettings,
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
        settings: routeSettings,
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        builder: (_) => const BottomBar(),
        settings: routeSettings,
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AddProductScreen(),
        settings: routeSettings,
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => CategoryDealsScreen(category: category),
        settings: routeSettings,
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => SearchScreen(searchQuery: searchQuery),
        settings: routeSettings,
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        builder: (_) => ProductDetailScreen(product: product),
        settings: routeSettings,
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
        settings: routeSettings,
      );
  }
}

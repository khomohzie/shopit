import 'dart:convert';

import 'package:shopit/models/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final double totalPrice;

  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((e) => e.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
        id: map['_id'] as String,
        products: List<Product>.from(
          map['products']?.map(
            (e) => Product.fromMap(e['product']),
          ),
        ),
        quantity: List<int>.from(
          map['products']?.map(
            (e) => e['quantity'],
          ),
        ),
        address: map['address'] as String,
        userId: map['userId'] as String,
        orderedAt: map['orderedAt'] as int,
        status: map['status'] as int,
        totalPrice: map['totalPrice']?.toDouble() ?? 0.0);
  }

  String toJson() => jsonEncode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(jsonDecode(source));
}

import 'package:flutter/foundation.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String categoryId;
  final String imageUrl;
  final double rating;
  final bool isFeatured;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.imageUrl,
    required this.rating,
    required this.isFeatured,
  });

  factory ProductModel.fromFirestore(String id, Map<String, dynamic> data) {

    final resolvedName = data['productName'] ?? data['name'] ?? data['title'] ?? 'Unnamed Product';

    debugPrint('📦 [ProductModel] ID: $id | Received Name: "$resolvedName" | Raw Data: $data');
    return ProductModel(
      id: id,
      name: data['productName'] ?? '',
      description: data['description']?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      categoryId: data['categoryId'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      isFeatured: data['isFeatured'] ?? false,
    );
  }
}
import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String description;
  final String imageUrl;
  bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.isFavourite = false,
  });
  void toggleFavouritestatus() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
  ];
  // var _showFavouritesOnly;

  List<Product> get favouriteItems {
    return _items.where((element) => element.isFavourite).toList();
  }
  // getter for return only favourite items

  List<Product> get items {
    // if (_showFavouritesOnly) {
    //   return _items.where((prod) => prod.isFavourite).toList();
    //}

    // above is a getter that returns only list of all items

    return [..._items];
  }

  // void showFavourite() {
  //   _showFavouritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavouritesOnly = false;
  //   notifyListeners();
  // }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> addproducts(Product product) {
    final url = Uri.parse(
        'https://jewelshop-a0ac1-default-rtdb.firebaseio.com/prodcut.json');
    return (http.post(url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavourite': product.isFavourite,
        }))).then((response) {
      // this method tells that this method
      // runs after above code running  and it is asynchronus
      print(json.decode(response.body)); // this will prints the respose
      // with name key of unique id which is at the server
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          imageUrl: product.imageUrl,
          price: product.price);
      _items.add(newProduct);
      notifyListeners();
    }).catchError((error) {
      throw error;
    });
    //items.insert(0, product);// fro addding at start of the list to any products
  }

  void deleteItem(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }

  void upDateProducts(String id, Product neweditedProduct) {
    //we need to find the specific index of product by compairing id of that and then we need to update the chnaegs
    int index = items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      _items[index] = neweditedProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }
}

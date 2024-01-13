import 'package:flutter/foundation.dart';

class Product {
  final String image;
  final String name;
  final String price;
  final String details;
  int quantity;

  Product({
    required this.image,
    required this.name,
    required this.price,
    required this.details,
    this.quantity = 1,
  });
}

class CartModel extends ChangeNotifier {
  final List<Product> _cart = [];

  List<Product> get cart => _cart;

  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  bool isProductInCart(String productName) {
    return _cart.any((product) => product.name == productName);
  }
}

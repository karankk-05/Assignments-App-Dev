// Button.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Model.dart';

class PressableElevatedButton extends StatelessWidget {
  final String productName;
  final String productImage;
  final String productPrice;
  final String productDetails;

  PressableElevatedButton(
      {required this.productName,
      required this.productImage,
      required this.productPrice,
      required this.productDetails});

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        content: Text(
          message,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    bool isInCart = cart.isProductInCart(productName);
    IconData icon = isInCart
        ? Icons.remove_shopping_cart
        : Icons.add_shopping_cart_outlined;
    String buttonText = isInCart ? 'Remove From Cart' : 'Add to Cart';
    Color buttonColor = isInCart
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.background;

    return ElevatedButton.icon(
      onPressed: () {
        if (isInCart) {
          Product existingProduct = cart.cart.firstWhere(
            (product) => product.name == productName,
          );
          cart.removeFromCart(existingProduct);
          _showSnackBar(context, 'Removed from Cart: $productName');
        } else {
          cart.addToCart(Product(
              image: productImage,
              name: productName,
              price: productPrice,
              details: productDetails));
          _showSnackBar(context, 'Added to Cart: $productName');
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
      ),
      icon: Icon(
        icon,
        color: isInCart
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.primary,
      ),
      label: Text(
        buttonText,
        style: TextStyle(
          color: isInCart
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.primary,
          fontSize: 16,
        ),
      ),
    );
  }
}

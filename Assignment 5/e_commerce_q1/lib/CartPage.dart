import 'package:flutter/material.dart';
import 'Model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            Expanded(
              child: Consumer<CartModel>(
                builder: (context, cart, child) {
                  if (cart.cart.isEmpty) {
                    return Center(
                      child: Text('You have not added items yet.'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: cart.cart.length,
                      itemBuilder: (context, index) {
                        final product = cart.cart[index];
                        return CartItem(
                          product: product,
                          onOrderConfirmed: () {
                            cart.removeFromCart(product);
                          },
                          onQuantityChanged: () {
                            Provider.of<CartModel>(context, listen: false)
                                .notifyListeners();
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
            if (Provider.of<CartModel>(context).cart.isNotEmpty)
              TotalPriceWidget(),
          ],
        ),
        floatingActionButton: Builder(
          builder: (context) {
            if (Provider.of<CartModel>(context).cart.isNotEmpty) {
              return FloatingActionButton.extended(
                backgroundColor: Theme.of(context).colorScheme.background,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm'),
                        content: Text('Confirm Order?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<CartModel>(context, listen: false)
                                  .clearCart();
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  content: Text(
                                    'Order Placed! Your items will reach you soon!!',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                label: Text(
                  'Buy All',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                icon: Icon(
                  Icons.shopping_cart_checkout_sharp,
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      ),
    );
  }
}

class TotalPriceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        double totalPrice = cart.cart.fold(
          0,
          (previousValue, element) =>
              previousValue +
              (double.parse(element.price.substring(0)) * element.quantity),
        );

        return Container(
          height: 80,
          padding: EdgeInsets.all(16.0),
          color: Theme.of(context).colorScheme.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price: ${formatPrice(totalPrice)}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String formatPrice(double amount) {
    final format =
        NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);
    return format.format(amount);
  }
}

class CartItem extends StatefulWidget {
  final Product product;
  final VoidCallback onOrderConfirmed;
  final VoidCallback? onQuantityChanged;

  CartItem({
    required this.product,
    required this.onOrderConfirmed,
    this.onQuantityChanged,
  });

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  String formatPrice(double amount) {
    final format =
        NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);
    return format.format(amount);
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        content: Text(
          message,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            margin: EdgeInsets.all(8.0),
            child: Container(
              height: 230,
              child: Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 220,
                      width: 220,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Image.asset('assets/${widget.product.image}'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                          child: Text(
                            '${widget.product.name}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Text(
                            '${formatPrice(double.parse(widget.product.price))}',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 230,
                          child: Card(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    if (widget.product.quantity > 1) {
                                      setState(() {
                                        widget.product.quantity--;
                                        widget.onQuantityChanged?.call();
                                      });
                                    }
                                  },
                                ),
                                Text(
                                  '${widget.product.quantity}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  onPressed: () {
                                    setState(() {
                                      widget.product.quantity++;
                                      widget.onQuantityChanged?.call();
                                    });
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Confirm'),
                                        content: Text('Confirm Order?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              widget.onOrderConfirmed();
                                              _showSnackBar(context,
                                                  'Placed: Your ${widget.product.name} will reach you soon !!');
                                            },
                                            child: Text('Yes'),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  child: Text('Place Order'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Provider.of<CartModel>(context, listen: false)
                                  .removeFromCart(widget.product);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 59, 171, 25),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.remove_shopping_cart,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                                Text(
                                  'Remove from Cart',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}

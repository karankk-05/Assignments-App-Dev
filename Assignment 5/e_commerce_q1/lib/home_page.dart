import 'package:flutter/material.dart';
import 'ProfilePage.dart';
import 'CartPage.dart';
import 'ProductPage.dart';

class HomePage extends StatefulWidget {
  final String? name;
  final String? phone;

  HomePage({this.name, this.phone});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text('Welcome ${widget.name} !!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
              leading: IconButton(
                color: Theme.of(context).colorScheme.onPrimary,
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm'),
                        content: Text('Do you want to logout?'),
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
                              Navigator.of(context).pop();
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              actions: [
                Card(
                  child: Row(
                    children: [
                      IconButton(
                        color: Theme.of(context).colorScheme.primary,
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: Text(
                          'Cart',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                  child: Transform.scale(
                      scale: 0.8,
                      child: Image.asset('assets/logo.png',
                          height: 100, width: 50)),
                ),
              ],
            ),
            body: Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    extended: true,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(
                          Icons.home,
                        ),
                        label: Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.shopping_cart),
                        label: Text(
                          'Cart',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.person),
                        label: Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: getPage(),
                  ),
                ),
              ],
            ),
          );  

          
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text('Welcome ${widget.name} !!',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary)),
              leading: IconButton(
                color: Theme.of(context).colorScheme.onPrimary,
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm'),
                        content: Text('Do you want to logout?'),
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
                              Navigator.of(context).pop();
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: IconButton(
                    color: Theme.of(context).colorScheme.onPrimary,
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                  child: Transform.scale(
                      scale: 0.8,
                      child: Image.asset('assets/logo.png',
                          height: 100, width: 50)),
                ),
              ],
            ),
            body: getPage(),
            bottomNavigationBar: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: BottomNavigationBar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                key: ValueKey<int>(selectedIndex),
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
                currentIndex: selectedIndex,
                onTap: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
          );
        }
      },
    );
  }

  Widget getPage() {
    switch (selectedIndex) {
      case 0:
        return ProductPage();
      case 1:
        return CartPage();
      case 2:
        return ProfilePage(
          name: '${widget.name}',
          phone: '${widget.phone}',
        );
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
  }
}

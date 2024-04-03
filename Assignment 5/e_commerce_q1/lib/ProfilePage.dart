import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String phone;

  ProfilePage({required this.name, required this.phone});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 50, 30, 50),
              child: Image.asset('assets/logo.png', height: 200)),
          Expanded(
            child: Column(
              children: [
                Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Icon(Icons.person)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                        child: Animate(
                            child: Text(
                          '$name',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ).animate().fade(duration: 1000.ms)),
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Icon(Icons.phone)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                        child: Animate(
                            child: Text(
                          '$phone',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ).animate().fade(duration: 1000.ms)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
        Padding(
            padding: const EdgeInsets.fromLTRB(60.0, 0, 0, 0),
            child: Container(
              height: 50,
              width: 150,
              child: Card(
                color: Theme.of(context).colorScheme.primary,
                child: TextButton(
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
                                  Navigator.of(context)
                                      .pop('$name Logged Out Successfully');
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ))
      ]),
    );
  }
}

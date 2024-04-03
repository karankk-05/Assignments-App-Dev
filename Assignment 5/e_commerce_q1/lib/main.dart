import 'package:flutter/material.dart';
import 'animate_screen.dart';
import 'Model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
          ChangeNotifierProvider(create: (context) => CartModel(),

        child: MaterialApp(
          title: 'k-Kart App',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme:
                ColorScheme.fromSeed(seedColor: Color.fromRGBO(31, 167, 1, 1.0)),
          ),
          home: LogoAnimate(),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'home_page.dart';

class LogoAnimate extends StatefulWidget {
  @override
  _LogoAnimateState createState() => _LogoAnimateState();
}

class _LogoAnimateState extends State<LogoAnimate> {
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  List<String> userDetailsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        body: Center(
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(65.0, 0, 0, 0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Transform.scale(
                        scale: 0.8,
                        child: RichText(
                          text: TextSpan(
                            text: 'Welcome To',
                            style: DefaultTextStyle.of(context).style.copyWith(
                                  foreground: Paint()
                                    ..shader = LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 174, 236, 4),
                                        Color.fromARGB(255, 17, 101, 2),
                                      ],
                                    ).createShader(
                                      Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                                    ),
                                  decoration: TextDecoration.none,
                                ),
                          ),
                        ).animate().fade(duration: 1.seconds).moveY(
                              delay: 2.seconds,
                              begin: -20,
                              end: -320,
                              duration: 2.seconds,
                            ),
                      ),
                    ),
                    Transform.scale(
                      scale: 3,
                      child:
                          Image.asset('assets/logo.png', height: 100, width: 50)
                              .animate()
                              .fade(duration: 1.seconds)
                              .moveY(
                                delay: 2.seconds,
                                begin: 0,
                                end: -70,
                                duration: 2.seconds,
                              ),
                    ),
                  ]),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 230,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Container(
                    width: 400,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.onPrimary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                      controller: _name,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 3.seconds),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: 400,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.onPrimary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                      controller: _phone,
                      decoration: InputDecoration(
                        hintText: 'Enter your Phone No',
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 3.seconds),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    child: ElevatedButton(
                        onPressed: () {
                          String name = _name.text;
                          String phone = _phone.text;

                          if (name.isNotEmpty && phone.isNotEmpty) {
                            setState(() {
                              userDetailsList.add('$name - $phone');
                              _name.clear();
                              _phone.clear();
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                  name: name,
                                  phone: phone,
                                ),
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(180, 60)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 118, 210, 60)),
                        ),
                        child: Transform.scale(
                            scale: 1.6,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ))),
                  ),
                ).animate().fadeIn(delay: 3.seconds),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      userDetailsList.map((detail) => Text(detail)).toList(),
                ),
              ],
            ),
          ]),
        ));
  }
}

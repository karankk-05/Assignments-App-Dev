import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FormData(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromRGBO(14, 113, 199, 1)),
        ),
        home: GeneratorPage(),
      ),
    );
  }
}

class FormData extends ChangeNotifier {
  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  List<String> get fieldData {
    return controllers.map((controller) => controller.text).toList();
  }

  void resetForm() {
    for (var controller in controllers) {
      controller.clear();
    }
    notifyListeners();
  }
}


class GeneratorPage extends StatefulWidget {
  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  final _form = GlobalKey<FormState>();

  void _saveForm() {
  final isValid = _form.currentState!.validate();

  if (isValid) {
  _form.currentState!.save();

  }
}

  List<String> fieldLabels = ['Username', 'Email', 'Roll No', 'Phone No'];
  @override
  Widget build(BuildContext context) {
    var formData = Provider.of<FormData>(context);
    ThemeData theme = Theme.of(context);
    var i;
    var l1 = <String>["Username", "e-Mail", "Roll No", "Phone No"];
    List<Icon> icons = [
      Icon(Icons.person),
      Icon(Icons.mail),
      Icon(Icons.school),
      Icon(Icons.phone)
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Login Page',
            style: theme.textTheme.bodyText1?.copyWith(
                color: theme.colorScheme.onBackground,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: Card(
                  color: theme.colorScheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('Enter Your Login Details',
                        style: theme.textTheme.bodyText1?.copyWith(
                            color: theme.colorScheme.onPrimary, fontSize: 20)),
                  ),
                ),
              ),
              for (i in l1)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: icons[l1.indexOf(i)],
                      ),
                      SizedBox(
                        height: 60,
                        width: 140,
                        child: Card(
                          color: theme.colorScheme.primaryContainer,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(i,
                                  style: theme.textTheme.bodyText1?.copyWith(
                                      color: theme
                                          .colorScheme.onSecondaryContainer,
                                      fontSize: 20)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "Field cannot be empty!";
                              }
                              return null;
                            },
                            controller: formData.controllers[l1.indexOf(i)],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromRGBO(255, 255, 255, 1),
                              border: OutlineInputBorder(),
                              hintText: 'Enter your $i',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_form.currentState!.validate()) {
                              List<String> fieldData = [];
                              for (int i = 0; i < l1.length; i++) {
                                fieldData.add(formData.controllers[i].text);
                              }

                              var result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()),
                              );

                              if (result != null) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Session Ended'),
                                      content: Text('$result'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          child: Center(child: Text('OK')),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }

                              _saveForm();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: theme.colorScheme.primary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('Login',
                                style: theme.textTheme.bodyText1?.copyWith(
                                    color: theme.colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          )))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formData = Provider.of<FormData>(context);
    ThemeData theme = Theme.of(context);
    List<Icon> icons = [
      Icon(Icons.person),
      Icon(Icons.mail),
      Icon(Icons.school),
      Icon(Icons.phone)
    ];

    if (formData.fieldData.isNotEmpty) {
      List<String> fieldData = formData.fieldData;
      var user = fieldData[0];

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {
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
                                  Navigator.pop(context);
                                  Navigator.of(context)
                                      .pop('$user Logged Out Successfully');
                                  Provider.of<FormData>(context, listen: false)
                                      .resetForm();
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          );
                        })
                  }),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('User Details',
              style: theme.textTheme.bodyText1?.copyWith(
                  color: theme.colorScheme.onBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        body: Column(children: [
          for (int i = 0; i < fieldData.length; i++)
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icons[i],
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Animate(
                      child: Text(
                        fieldData[i],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ).animate().fade(duration: 1000.ms),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
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
                              Navigator.pop(context);
                              Navigator.of(context)
                                  .pop('$user Logged Out Successfully');
                              Provider.of<FormData>(context, listen: false)
                                  .resetForm();
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: theme.colorScheme.primary,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Logout',
                      style: theme.textTheme.bodyText1?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                )),
          )
        ]),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Text('No data available'),
        ),
      );
    }
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<List<Album>> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    List<Album> albums = jsonList
        .map((json) => Album.fromJson(json as Map<String, dynamic>))
        .toList();
    return albums;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<void> addAlbum(Album newAlbum) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(newAlbum.toJson()),
  );

  if (response.statusCode != 201) {
    throw Exception('Failed to add album');
  }
}

Future<void> deleteAlbum(int albumId) async {
  final response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$albumId'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to delete album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
    };
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Album>> futureAlbums;
  TextEditingController newAlbumController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return MaterialApp(
      title: 'Data',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 183, 123, 58)),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Data From API',
              style: theme.textTheme.bodyText1?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          backgroundColor: theme.colorScheme.primary,
        ),
        floatingActionButton: Builder(
          builder: (BuildContext innerContext) {
            return FloatingActionButton(
              backgroundColor: theme.colorScheme.primary,
              onPressed: () {
                showDialog(
                  context: innerContext,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Add Item'),
                      actions: [
                        TextFormField(
                            decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(255, 255, 255, 1),
                          border: OutlineInputBorder(),
                          hintText: 'Enter New Item Title',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () async {
                                    String newAlbumTitle =
                                        newAlbumController.text;
      
                                    Album newAlbum = Album(
                                      userId:
                                          1, // You may need to set a proper user ID
                                      id: 0, // Assuming the ID will be assigned by the server
                                      title: newAlbumTitle,
                                    );
      
                                    try {
                                      await addAlbum(newAlbum);
      
                                      setState(() {
                                        futureAlbums = fetchAlbum();
                                      });
      
                                      Navigator.of(context).pop();
                                    } catch (e) {
                                      print('Error adding album: $e');
                                    }
                                  },
                                  child: Text('Confirm'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Icon(
                Icons.add,
                color: theme.colorScheme.onPrimary,
              ),
            );
          },
        ),
        body: FutureBuilder<List<Album>>(
          future: futureAlbums,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var album = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      color: theme.colorScheme.background,
                      borderOnForeground: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(album.title),
                            subtitle: Text('ID: ${album.id}'),
                            trailing: IconButton(
                              onPressed: () async {
                                await deleteAlbum(album.id);
                                setState(() {
                                  futureAlbums = fetchAlbum();
                                });
                              },
                              icon: Icon(Icons.delete,
                                  color:
                                      theme.colorScheme.onPrimaryContainer),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
      
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}



import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(0, 249, 0, 1)),
        ),
        home: GeneratorPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }


  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void deleteFavorite() {
    for (var pair in favorites){
    favorites.remove(pair);
    notifyListeners();
  }
}
}

  




class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),

              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var style=theme.textTheme.displayMedium!.copyWith(
      color:theme.colorScheme.onPrimary,
    );
    return Card(
      color:theme.colorScheme.primary,
      

        child: Padding(
         
          padding: const EdgeInsets.all(8.0),
          child: Text(pair.asLowerCase,style:style),
        ),
      
    );
  }
}



class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    
    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }
    
    IconData delete;
    delete=Icons.delete;
    
    return ListView(
      children: [
        
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
            trailing: IconButton(
                onPressed: () {
                  setState((){
                  appState.favorites.remove(pair);
                });
                },
                icon: Icon(delete),
                
              ),
              ),
          

          
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Alert"),
                          content: Text("Do you really want to delete all?"),               
                          actions: [ElevatedButton(onPressed:()=> [ setState((){appState.favorites.clear();}),Navigator.pop(context),],
                          child: Text("Yes")),
                          ElevatedButton(onPressed:()=> Navigator.pop(context), child: Text("No"))
                       
                      ]
                          );
                        });
                      
                      
                    
                    },
                    child: Text('Delete All')
                      .animate()
                      .shake(duration: 700.ms)
                  ),
          ),
      ],
      
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0,50.0,0,0),
        child: CircleAvatar(
          backgroundImage:
          NetworkImage('https://yt3.googleusercontent.com/ytc/APkrFKaD8t4oFlgXcZKoW512Z81CBJuej3K9uHAlSI0x=s900-c-k-c0x00ffffff-no-rj'),
          radius: 150,
          
            ),
      ),

      Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0,40,0,0),
            child: Text('Karan Keer',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          ),
        ],
      ),
      
       Row(
         children: [
           Padding(
            padding: const EdgeInsets.fromLTRB(22.0,0,0,0),
            child: Text('karank23@iitk.ac.in',style: TextStyle(fontSize: 12),),
                 ),
         ],
       ),

      Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30,10,0,0),
            child: Icon(Icons.location_on)
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(2,10,0,0),
            child: Animate(child: Text('City:Kanpur',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)
            .animate()
            .fade(duration: 1000.ms)),
          )
        ],
      ),

      Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30,10,0,0),
            child: Icon(Icons.person)
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(2,10,0,0),
            
              child: Animate(child:Text('Roll No: 230531',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)
              .animate()
              .fade(duration: 1000.ms)
            
            ),
          )
        ],
      ),
    
      
    
      ]
    );

    }
  }
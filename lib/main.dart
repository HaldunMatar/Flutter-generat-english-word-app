
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


void main(){
  runApp(MyApp()) ;

}

class MyApp extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(title: 'genertate english ', debugShowCheckedModeBanner: false  ,

      theme: ThemeData(          // Add the 3 lines from here...
        primaryColor: Colors.amber,
      ),
      home: RandomWords() ,);
    // TODO: implement build
    throw UnimplementedError();
  }





}

class Logohm  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
return Image(image: AssetImage('assets/logo.png'));
}
}



class RandomWords extends StatefulWidget  {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {

  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();     // NEW

  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
                padding: const EdgeInsets.all(8.0), child: Text('genertate english words  '))
          ],

        ),

        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body:  _buildSuggestions(),)
    ;
  }
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          final tiles = _saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }, // ...to here.
      ),
    );
  }



  _buildSuggestions() {

return ListView.builder(itemBuilder: (context, i) {
  if (i.isOdd) return Divider(); /*2*/
  final index = i ~/ 2; /*3*/
  if (index >= _suggestions.length) {
    _suggestions.addAll(generateWordPairs().take(10)); /*4*/
  }
  return _buildRow(_suggestions[index]);
});

    
  }

  _buildRow(WordPair suggestion) {
    final alreadySaved = _saved.contains(suggestion);  // NEW

    return ListTile( title:Text(
      suggestion.asPascalCase,
      style: _biggerFont,
    ) ,trailing: Icon(   // NEW from here...
      alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.red : null,
    ) , onTap: () {      // NEW lines from here...
      setState(() {
        if (alreadySaved) {
          _saved.remove(suggestion);
        } else {
          _saved.add(suggestion);
        }
      });
    },               // ... to here.,                // ... to here.
    ) ;

  }
}


/*import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

// #docregion MyApp
class MyApp extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
// #enddocregion build
}
// #enddocregion MyApp

// #docregion RWS-var
class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  // #enddocregion RWS-var

  // #docregion _buildSuggestions
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }
  // #enddocregion _buildSuggestions

  // #docregion _buildRow
  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
  // #enddocregion _buildRow

  // #docregion RWS-build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
// #enddocregion RWS-build
// #docregion RWS-var
}
// #enddocregion RWS-var

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}*/
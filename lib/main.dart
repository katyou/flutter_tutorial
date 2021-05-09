import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp()); /*1*/

class MyApp extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  //   final wordPair = WordPair.random();
  //   return MaterialApp(
  //     title: 'Welcome to Flutter',
  //     home: Scaffold(
  //       appBar: AppBar(
  //         title: Text(
  //           'Welcome to Flutter',
  //           style: TextStyle(color: Colors.black),
  //         ),
  //         backgroundColor: Colors.lightGreen,
  //       ),
  //       body: Center(
  //         child: RandomWords(),
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Startup Name Generator', home: RandomWords());
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          /*itemBuilderで一行ごとに処理が呼ばれ、偶数業の場合にListTileを表示し、奇数行のときにDividerを表示*/
          if (i.isOdd) return Divider(); /*1ピクセルの高さの仕切りをListViewに追加している*/

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            /*行数を2で割ったときの整数値を求める。これにより、Dividerで線を入れた行を抜いた状態の英文数を計算しています。*/
            _suggestions.addAll(generateWordPairs()
                .take(10)); /*利用可能な英文リスト数を超えた場合は、更に10この英文を生成しリストに追加します。*/
          }
          return _buildRow(_suggestions[
              index]); /*最後に現在の行で表示する英文をリストから取得し、_buildRowメソッドで表示用に整形します。*/
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup generator'),
        backgroundColor: Colors.lightGreen,
      ),
      body: _buildSuggestions(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

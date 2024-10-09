import 'package:flutter/material.dart';
import 'package:myapp/screens/navbar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // packageをインポート

// main関数をFutureに変更
Future<void> main() async {
  await dotenv.load(fileName: '.env'); // .envファイルを読み込み
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital Map',
      theme: ThemeData(
        // themeを追加
        primarySwatch: Colors.green,
        fontFamily: 'Hiragino Sans',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF55C500),
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
            ),
      ),
      home: const NavigationExample(),
    );
  }
}

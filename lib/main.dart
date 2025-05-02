import 'package:flutter/material.dart';
import 'home.dart';
import 'players_info.dart';
import 'game_panel.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/players': (context) => const PlayersInfoPage(),
        '/game': (context) => const GamePanelPage(),
      },
    );
  }
}

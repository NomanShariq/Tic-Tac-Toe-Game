import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/screen/tictactoe_screen.dart';

void main() => runApp(TicTacToe());

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Tic Tac Toe',
      home: TicTacToeGame(),
    );
  }
}

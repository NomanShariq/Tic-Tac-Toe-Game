import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String>? _board;
  String? _currentPlayer;
  String? _winner;
  int _xScore = 0;
  int _oScore = 0;

  @override
  void initState() {
    super.initState();
    _board = List.filled(9, '');
    _currentPlayer = 'X';
    _winner = null;
  }

  void _handleTap(int index) {
    if (_board![index] == '' && _winner == null) {
      setState(() {
        _board![index] = _currentPlayer!;
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
        _checkForWinner();
      });
    }
  }

  void _checkForWinner() {
    List<List<int>> winningPositions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var position in winningPositions) {
      if (_board![position[0]] != '' &&
          _board![position[0]] == _board![position[1]] &&
          _board![position[1]] == _board![position[2]]) {
        setState(() {
          _winner = _board![position[0]];
          if (_winner == 'X') {
            _xScore += 1;
          } else {
            _oScore += 1;
          }
        });
        break;
      }
    }
    if (!_board!.contains('') && _winner == null) {
      setState(() {
        _winner = 'tie';
      });
    }
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = 'X';
      _winner = null;
    });
  }

  void _resetScoreboard() {
    setState(() {
      _xScore = 0;
      _oScore = 0;
    });
    _resetGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Tic Tac Toe',
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: _resetScoreboard,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 68, 66, 66),
            ),
            // tooltip: 'Reset Scoreboard',
            child: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Scoreboard',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'X: ',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$_xScore',
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'O: ',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$_oScore',
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: _board!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _handleTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _board![index],
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 64,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _winner != null
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Text(
                        _winner == 'tie' ? 'It\'s a tie!' : '$_winner wins!',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _resetGame,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                        child: const Text(
                          'Play Again',
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(TicTacToe());

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe - By Ian Connon',
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> board = List.filled(9, '');
  bool xTurn = true;

  @override
  void initState() {
    super.initState();
    board = List.filled(9, '');
    xTurn = true;
  }

  void _resetBoard() {
    setState(() {
      board = List.filled(9, '');
      xTurn = true;
    });
  }

  void _makeMove(int index) {
    if (board[index] == '') {
      setState(() {
        board[index] = xTurn ? 'X' : 'O';
        xTurn = !xTurn;
      });
    }
  }

  bool _checkWin(String player) {
    // Horizontal wins
    if ((board[0] == player && board[1] == player && board[2] == player) ||
        (board[3] == player && board[4] == player && board[5] == player) ||
        (board[6] == player && board[7] == player && board[8] == player)) {
      return true;
    }

    // Vertical wins
    if ((board[0] == player && board[3] == player && board[6] == player) ||
        (board[1] == player && board[4] == player && board[7] == player) ||
        (board[2] == player && board[5] == player && board[8] == player)) {
      return true;
    }

    // Diagonal wins
    if ((board[0] == player && board[4] == player && board[8] == player) ||
        (board[2] == player && board[4] == player && board[6] == player)) {
      return true;
    }

    return false;
  }

  String? _getWinner() {
    // Check rows
    for (int i = 0; i <= 6; i += 3) {
      if (board[i].isNotEmpty &&
          board[i] == board[i + 1] &&
          board[i] == board[i + 2]) {
        return board[i];
      }
    }

    // Check columns
    for (int i = 0; i <= 2; i++) {
      if (board[i].isNotEmpty &&
          board[i] == board[i + 3] &&
          board[i] == board[i + 6]) {
        return board[i];
      }
    }

    // Check diagonals
    if (board[0].isNotEmpty &&
        board[0] == board[4] &&
        board[0] == board[8]) {
      return board[0];
    }
    if (board[2].isNotEmpty &&
        board[2] == board[4] &&
        board[2] == board[6]) {
      return board[2];
    }

    // Check if draw
    if (!board.contains('')) {
      return 'draw';
    }

    // Return null if there is no winner yet
    return null;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(
                'Tic Tac Toe - By Ian Connon',
                style: TextStyle(
                  fontSize: 14.5,
                ),
            ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _makeMove(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueGrey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2, 4),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      board[index],
                      style: TextStyle(
                        fontSize: 50.0,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          _getWinner() != null
              ? Column(
            children: <Widget>[
              Text(
                _getWinner() == 'draw'
                    ? 'It\'s a draw!'
                    : '${_getWinner()} wins!',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  _resetBoard();
                },
                child: Text('Play again'),
              ),
            ],
          )
              : SizedBox(),
        ],
      ),
    );
  }
}
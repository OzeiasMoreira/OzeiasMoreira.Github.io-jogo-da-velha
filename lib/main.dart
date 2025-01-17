import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Velha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToePage(),
    );
  }
}

class TicTacToePage extends StatefulWidget {
  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String result = '';

  void _handleTap(int index) {
    if (board[index].isEmpty && result.isEmpty) {
      setState(() {
        board[index] = currentPlayer;
        if (_checkWinner(currentPlayer)) {
          result = '$currentPlayer venceu!';
        } else if (!board.contains('')) {
          result = 'Empate!';
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkWinner(String player) {
    // Linhas, colunas e diagonais
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      if (pattern.every((index) => board[index] == player)) {
        return true;
      }
    }
    return false;
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      result = '';
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Jogo da Velha'),
    ),
    body: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Faz com que a coluna use apenas o espaço necessário
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            result.isEmpty ? 'Vez de $currentPlayer' : result,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Flexible( // Substitui Expanded para evitar conflito
            fit: FlexFit.loose, // Permite que o GridView tenha um tamanho flexível
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              shrinkWrap: true, // Evita que o GridView ocupe espaço infinito
              physics: NeverScrollableScrollPhysics(), // Evita scroll interno no GridView
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _handleTap(index),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resetGame,
            child: Text('Reiniciar Jogo'),
          ),
        ],
      ),
    ),
  );
}

}

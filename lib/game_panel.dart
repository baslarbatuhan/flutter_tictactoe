import 'package:flutter/material.dart';

class GamePanelPage extends StatefulWidget {
  const GamePanelPage({super.key});

  @override
  State<GamePanelPage> createState() => _GamePanelPageState();
}

class _GamePanelPageState extends State<GamePanelPage> {
  late String player1;
  late String player2;

  int score1 = 0;
  int score2 = 0;
  int round = 1;

  List<String> board = List.filled(9, '');
  bool isPlayer1Turn = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    player1 = args['player1'];
    player2 = args['player2'];
  }

  void resetBoard({bool fullReset = false}) {
    setState(() {
      board = List.filled(9, '');
      isPlayer1Turn = fullReset ? true : isPlayer1Turn;
      if (fullReset) {
        round = 1;
        score1 = 0;
        score2 = 0;
      } else {
        round++;
      }
    });
  }

  void handleTap(int index) {
    if (board[index].isNotEmpty) return;

    setState(() {
      board[index] = isPlayer1Turn ? 'X' : 'O';
      if (checkWin(board[index])) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Congratulations !!!'),
            content: Text('${isPlayer1Turn ? player1 : player2} won (+ 3 points)'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    if (isPlayer1Turn) {
                      score1 += 3;
                    } else {
                      score2 += 3;
                    }
                    resetBoard();
                  });
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      } else if (!board.contains('')) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Draw !!!'),
            content: const Text('One point for each player'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    score1++;
                    score2++;
                    resetBoard();
                  });
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      } else {
        isPlayer1Turn = !isPlayer1Turn;
      }
    });
  }

  bool checkWin(String symbol) {
    const winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    return winPatterns.any((pattern) =>
        pattern.every((index) => board[index] == symbol));
  }

  void confirmExit() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: const Text('Are you sure to exit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, {
                'name': score1 > score2 ? player1 : player2,
                'symbol': score1 > score2 ? 'X' : 'O',
                'score': score1 > score2 ? score1 : score2,
              });
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final turnPlayer = isPlayer1Turn ? player1 : player2;
    final turnSymbol = isPlayer1Turn ? 'X' : 'O';
    final turnColor = isPlayer1Turn ? Colors.blue : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Panel'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: const Color(0xFFEFF8EF),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            '$player1 Score: $score1',
            style: const TextStyle(color: Colors.blue, fontSize: 25),
          ),
          Text(
            '$player2 Score: $score2',
            style: const TextStyle(color: Colors.red, fontSize: 25),
          ),
          const Divider(thickness: 1),
          Text(
            'Round: $round',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              height: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Turn: $turnPlayer ($turnSymbol)',
            style: TextStyle(
              color: turnColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => handleTap(index),
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(
                          fontSize: 48,
                          color: board[index] == 'X' ? Colors.blue : Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => resetBoard(fullReset: true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  minimumSize: const Size(100, 45),
                ),
                child: const Text(
                  'Reset',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ElevatedButton(
                onPressed: confirmExit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  minimumSize: const Size(100, 45),
                ),
                child: const Text(
                  'Exit',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),

        ],
      ),
    );
  }
}

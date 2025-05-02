import 'package:flutter/material.dart';

class PlayersInfoPage extends StatefulWidget {
  const PlayersInfoPage({super.key});

  @override
  State<PlayersInfoPage> createState() => _PlayersInfoPageState();
}

class _PlayersInfoPageState extends State<PlayersInfoPage> {
  TextEditingController player1Controller = TextEditingController();
  TextEditingController player2Controller = TextEditingController();

  List<Map<String, dynamic>> heroes = [];

  void swapNames() {
    setState(() {
      final temp = player1Controller.text;
      player1Controller.text = player2Controller.text;
      player2Controller.text = temp;
    });
  }

  void addHero(String name, String symbol, int score) {
    setState(() {
      heroes.add({'name': name, 'symbol': symbol, 'score': score});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Players Panel"),
        backgroundColor: Colors.green,
      ),
      backgroundColor: const Color(0xFFEFF8EF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            const SizedBox(height: 30),
            buildPlayerCard(player1Controller, "Player 1", Colors.blue),
            const SizedBox(height: 12),
            IconButton(
              onPressed: swapNames,
              icon: const Icon(Icons.swap_vert, size: 40),
            ),
            const SizedBox(height: 12),
            buildPlayerCard(player2Controller, "Player 2", Colors.red),
            const SizedBox(height: 40),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Heros List:",
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: heroes.isEmpty
                  ? const Center(
                  child: Text("No heroes yet.", style: TextStyle(fontSize: 16)))
                  : ListView.builder(
                itemCount: heroes.length,
                itemBuilder: (context, index) {
                  final hero = heroes[index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (_) {
                      setState(() => heroes.removeAt(index));
                    },
                    child: ListTile(
                      leading: const Icon(Icons.star, color: Colors.orange),
                      title: Text(hero['name'], style: const TextStyle(fontSize: 16)),
                      subtitle: Text(hero['symbol']),
                      trailing: Text('${hero['score']}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.arrow_forward),
        onPressed: () async {
          if (player1Controller.text.isEmpty || player2Controller.text.isEmpty) return;

          final result = await Navigator.pushNamed(
            context,
            '/game',
            arguments: {
              'player1': player1Controller.text,
              'player2': player2Controller.text,
            },
          );

          if (result != null && result is Map<String, dynamic>) {
            addHero(result['name'], result['symbol'], result['score']);
          }
        },
      ),
    );
  }

  Widget buildPlayerCard(TextEditingController controller, String label, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16, vertical: 8),
        child: Row(
          children: [
            const Icon(Icons.person, size: 30),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: const TextStyle(fontSize: 16),
                  border: InputBorder.none,
                ),
              ),
            ),
            CircleAvatar(backgroundColor: color, radius: 12),
          ],
        ),
      ),
    );
  }
}

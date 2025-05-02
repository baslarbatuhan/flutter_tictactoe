import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to TTT'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: const Color(0xFFEFF8EF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/background.png',
                  width: 420,
                  height: 420,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/images/words.png',
                  width: 250,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            const SizedBox(height: 70),
            const CircleAvatar(
              radius: 35,
              backgroundColor: Colors.orange,
              child: Text(
                'V 1.0',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/players');
              },
              child: const Text(
                'Continue >>',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

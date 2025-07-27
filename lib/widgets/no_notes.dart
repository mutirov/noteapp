import 'package:flutter/material.dart';

class NoNotes extends StatelessWidget {
  const NoNotes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/person.png',
              width: MediaQuery.of(context).size.width * 0.75,
            ),
            const SizedBox(height: 32.0),
            const Text(
              'You have no notes yet. Start adding by tapping the + button',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Fredoka',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
  }
}
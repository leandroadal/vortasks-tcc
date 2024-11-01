import 'package:flutter/material.dart';

class FriendsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FriendsButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          textStyle: const TextStyle(fontSize: 16),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.people),
            SizedBox(width: 8.0),
            Text('Meus Amigos'),
          ],
        ),
      ),
    );
  }
}

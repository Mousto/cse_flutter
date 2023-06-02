import 'package:cse_talant_valmy/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(TabsScreen.routeName);
          },
          child: const Text('Vers les produits'),
        ),
      ),
    );
  }
}

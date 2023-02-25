import 'package:flutter/material.dart';

import '../screens/tabs_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Provider.of<ProduitsProvider>(context, listen: false)
    //     .setProduits(_listProduits);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application cse'),
      ),
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

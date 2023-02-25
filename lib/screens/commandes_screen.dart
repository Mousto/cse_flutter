import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/commande_provider.dart';
import '../widgets/commande_item.dart';
import '../widgets/main_drawer.dart';

class CommandesScreen extends StatelessWidget {
  const CommandesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lesCommandes = Provider.of<CommandeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Vos commandes'),
        ),
        //Menu hamburger
        drawer: const MainDrawer(),
        body: ListView.builder(
          itemCount: lesCommandes.commandes.length,
          itemBuilder: (context, index) =>
              CommandeItem(commande: lesCommandes.commandes[index]),
        ));
  }
}

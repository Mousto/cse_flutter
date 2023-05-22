import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/commande_provider.dart';
import '../widgets/commande_item.dart';
import '../widgets/main_drawer.dart';

class CommandesScreen extends StatefulWidget {
  const CommandesScreen({super.key});
  //route
  static const routeName = '/commandes';

  @override
  State<CommandesScreen> createState() => _CommandesScreenState();
}

class _CommandesScreenState extends State<CommandesScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<CommandeProvider>(context, listen: false)
          .fetchAndSetCommandes();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lesCommandes = Provider.of<CommandeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Vos commandes'),
        ),
        //Menu hamburger
        drawer: const MainDrawer(),
        body: Card(
          child: Column(
            children: [
              if (lesCommandes.paniers.length > 1)
                Text(
                  'Tu as ${lesCommandes.paniers.length} commandes en cours',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              if (lesCommandes.paniers.length == 1)
                Text('Tu as ${lesCommandes.paniers.length} commande en cours'),
              if (lesCommandes.paniers.isEmpty)
                const Text("tu n'as aucune commande en cours"),
              Expanded(
                child: ListView.builder(
                  itemCount: lesCommandes.paniers.length,
                  itemBuilder: (context, index) => CommandeItem(
                    panier: lesCommandes.paniers[index],
                    index: index,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

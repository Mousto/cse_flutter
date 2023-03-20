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
        body: ListView.builder(
          itemCount: lesCommandes.commandes.length,
          itemBuilder: (context, index) =>
              CommandeItem(panier: lesCommandes.commandes[index]),
        ));
  }
}

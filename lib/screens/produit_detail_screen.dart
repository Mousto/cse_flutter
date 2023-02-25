import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/produits_provider.dart';
import '../providers/panier_provider.dart';
import '../widgets/badge.dart';
import '../widgets/produit_detail_card.dart';
import '../screens/panier_screen.dart';

class ProduitDetailScreen extends StatelessWidget {
  const ProduitDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Extraction des données transmises
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    //Récupération des données
    final produitId = routeArgs['id'];
    //final dispo = routeArgs['dispo'];
    //Récupération du produit concerné via le provider(ProduitProvider)
    final produit = Provider.of<ProduitsProvider>(context,
            listen:
                false //par defaut à true et ici false pour dire que cet widget n'écoute pas les changement dans Produit l'écoute se fesant dans les widget supérieurs qui fournissent donc les données à jour.
            )
        .findById(produitId!);
    //final produitIsFavorit = Provider.of<Produit>(context);

    return ChangeNotifierProvider.value(
      value: produit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Infos & réservation billet(s)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            Consumer<PanierProvider>(
              builder: (_, panier, ch) => Badge(
                value: panier.itemCount.toString(),
                child:
                    ch!, // le point d'exclamation certifie à dart que ch ne sera jamais null
              ),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(PanierScreen.routeName);
                },
                //color: Colors.white,
              ),
            ),
          ],
        ),
        body: const ProduitDetailCard(),
      ),
    );
  }
}

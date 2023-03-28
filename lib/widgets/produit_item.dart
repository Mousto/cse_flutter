import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'dart:math';

import '../providers/produit.dart';
import '../providers/panier_provider.dart';
import 'mon_badge.dart';

class ProduitItem extends StatelessWidget {
  const ProduitItem({super.key});
  static const IconData info = IconData(0xe33c, fontFamily: 'MaterialIcons');

  void selectProduit(BuildContext ctx, int id) {
    Navigator.of(ctx).pushNamed(
      '/produit-detail-screen',
      arguments: {
        'id': id,
        //'dispo': getDispo(dispo),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final leProduit = Provider.of<ProduitProvider>(context);
    final lePanier = Provider.of<PanierProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        //padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              leProduit.couleur.withOpacity(0.7),
              leProduit.couleur,
              //Colors.primaries[Random().nextInt(Colors.primaries.length)],
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(children: [
          Positioned(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Consumer(
                      builder: (_, value, ch) => MonBadge(
                        value:
                            lePanier.itemCountByName(leProduit.nom).toString(),
                        child: ch ??
                            const Text(
                                '0'), //si ch est null on le remplace par un text
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: () async {
                          lePanier.addItem(
                            leProduit.id,
                            leProduit.prixAdulte,
                            leProduit.prixEnfant,
                            leProduit.nom,
                            leProduit.billetAdulte,
                            leProduit.billetEnfant,
                            leProduit.sommeTotale,
                          );
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '1 Billet ${leProduit.nom.toLowerCase()} ajouté'),
                              duration: const Duration(seconds: 3),
                              action: SnackBarAction(
                                label: 'Annuler',
                                onPressed: () {
                                  lePanier.removeSingleItem(leProduit.id);
                                },
                              ),
                            ),
                          );
                        },

                        // ignore: deprecated_member_use
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(info),
                    onPressed: () => selectProduit(
                      context,
                      leProduit.id,
                    ),
                    color: Colors.white,
                  ),
                  Consumer<ProduitProvider>(
                    builder: (_, produit, _1) => IconButton(
                      icon: Icon(produit.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border),
                      onPressed: () {
                        produit.toggleIsFavorite();
                      },
                      color: Colors.white,
                    ),
                  ),
                ]),
          ),
          Center(
            child: Text(
              leProduit.nom,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ]),
      ),
    );
  }
}

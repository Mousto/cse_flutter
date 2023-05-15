import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

//import 'dart:math';

import '../providers/produit.dart';
import '../providers/panier_provider.dart';
import 'mon_badge.dart';
import '../models/billets_notification.dart';

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

    int countBilletAdulte = 0;
    int countBilletEnfant = 0;
    //Dialogue ajout de billet
    Future<dynamic> openDialog() => showDialog(
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                //scrollable:
                //true, //Éviter d'avoir dans mon cas un alertDialog avec une grande hauteur non nécessaire
                title: Text(
                  'Ajout Billets ${leProduit.nom}',
                  textAlign: TextAlign.center,
                ),
                content: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 100.0,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text('Adulte :'),
                                IconButton(
                                    color: Colors.purple,
                                    icon: const Icon(
                                      Icons.remove,
                                    ),
                                    onPressed: countBilletAdulte == 0
                                        ? null
                                        : () {
                                            setState(() => countBilletAdulte--);
                                          }),
                                Text(
                                  countBilletAdulte.toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  color: Colors.purple,
                                  icon: const Icon(Icons.add),
                                  onPressed: () =>
                                      setState(() => countBilletAdulte++),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text('Enfant :'),
                                IconButton(
                                  color: Colors.purple,
                                  icon: const Icon(
                                    Icons.remove,
                                  ),
                                  onPressed: countBilletEnfant == 0
                                      ? null
                                      : () {
                                          setState(() => countBilletEnfant--);
                                        },
                                ),
                                Text(
                                  countBilletEnfant.toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  color: Colors.purple,
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() => countBilletEnfant++);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          countBilletAdulte = 0;
                          countBilletEnfant = 0;
                          leProduit.billetAdulte = 0;
                          leProduit.billetEnfant = 0;
                          lePanier.removeSingleItem(leProduit.id);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Ennuler'),
                      ),
                      TextButton(
                        onPressed:
                            countBilletAdulte == 0 && countBilletEnfant == 0
                                ? null
                                : () {
                                    var reponse = {
                                      'nbBilletAdulte': countBilletAdulte,
                                      'nbBilletEnfant': countBilletEnfant,
                                      'totalItemPanier': lePanier.sommeTotale,
                                    };
                                    Navigator.of(context).pop(reponse);
                                  },
                        child: const Text('Soumettre'),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        );

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
                          //Récup du nombre de billet choisi
                          final rep = await openDialog();
                          if (rep != null) {
                            leProduit.billetAdulte = rep['nbBilletAdulte'];
                            leProduit.billetEnfant = rep['nbBilletEnfant'];
                            if (context.mounted) {
                              BilletsNotification(
                                id: leProduit.id,
                                billetAdulte: rep['nbBilletAdulte'],
                                billetEnfant: rep['nbBilletEnfant'],
                              ).dispatch(context);
                              //Ajout d'un produit au panier
                              lePanier.addItem(
                                leProduit.id,
                                leProduit.prixAdulte,
                                leProduit.prixEnfant,
                                leProduit.nom,
                                leProduit.billetAdulte,
                                leProduit.billetEnfant,
                                (leProduit.prixAdulte *
                                        leProduit.billetAdulte) +
                                    (leProduit.prixEnfant *
                                        leProduit.billetEnfant),
                              );
                            }
                          }
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
          Positioned(
            top: 70,
            left: 25,
            child: Column(children: [
              if (leProduit.billetAdulte != 0)
                Text(
                  'Billet Adulte : ${leProduit.billetAdulte.toString()}',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                ),
              if (leProduit.billetEnfant != 0)
                Text(
                  'Billet Enfant : ${leProduit.billetEnfant.toString()}',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                ),
            ]),
          ),
        ]),
      ),
    );
  }
}

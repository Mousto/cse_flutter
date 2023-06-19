import 'package:cse_talant_valmy/models/produit_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../models/panier_bdd.dart';
import 'ordered_product.dart';

class PanierProduitScreen extends StatelessWidget {
  const PanierProduitScreen({super.key});
  static const routeName = '/commandes';

  @override
  Widget build(BuildContext context) {
    final lePanier = Get.arguments as PanierBdd;
    print(lePanier.commandes[0].produit);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Votre Panier'), centerTitle: true),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Date Commande : ${DateFormat('dd/MM/yyyy').format(lePanier.dateCommande)}'),
            Text('Valeur Totale : ${lePanier.valeurTotale} €'),
            Text(
                'Date Retrait : ${DateFormat('dd/MM/yyyy').format(lePanier.dateRetrait)} '),
            Text('Lieu Retrait : ${lePanier.lieuRetrait} '),
            Expanded(
              child: ListView.builder(
                itemCount: lePanier.commandes.length,
                itemBuilder: (context, int index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'http://192.168.1.48:8000${lePanier.commandes[index].produit.photo}'),

                    //FileImage(File(imageUrl)),
                    // AssetImage('assets/images/$imageUrl'),
                  ),
                  title: Text(
                    'Billet ${lePanier.commandes[index].produit.nom}',
                  ),
                  trailing:
                      Text('Total : ${lePanier.commandes[index].sousTotal}'),
                  onTap: () {
                    Get.to(() => const OrderedProductScreen(),
                        arguments: lePanier.commandes[index]);
                    print(
                        'Detail complet de la commande ${lePanier.commandes[index].id} ');
                  },
                  subtitle: Text(
                    'Enfant ${lePanier.commandes[index].billetEnfant}/Adulte ${lePanier.commandes[index].billetAdulte}',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

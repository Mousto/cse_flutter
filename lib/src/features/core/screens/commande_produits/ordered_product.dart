import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../models/commande_bdd.dart';
import '../../../../constants/sizes.dart';

class OrderedProductScreen extends StatelessWidget {
  const OrderedProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final laCommande = Get.arguments as CommandeBdd;
    print("leProduit $laCommande ");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Produit Commandé'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              padding: const EdgeInsets.all(tDashboardCardPadding),
              margin: const EdgeInsets.all(tDashboardCardPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
                color: Colors.black87,
              ),
              child: Column(
                children: [
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'http://192.168.1.48:8000${laCommande.produit.photo}'),
                      ),
                      Text(
                        laCommande.produit.nom,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Prix Enfant : ${laCommande.produit.prixEnfant} €',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Text(
                            '/',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Prix Adulte : ${laCommande.produit.prixAdulte} €',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Colors.white),
                  Text('Commande : ')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

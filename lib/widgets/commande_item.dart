import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../models/commande_model_item.dart';
import '../models/panier_bdd.dart';

class CommandeItem extends StatefulWidget {
  //final CommandeModelItem commande;
  final PanierBdd panier;

  const CommandeItem({super.key, required this.panier});

  @override
  State<CommandeItem> createState() => _CommandeItemState();
}

class _CommandeItemState extends State<CommandeItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('${widget.panier.valeurTotale} €'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.panier.dateCommande),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          //Dans un statefull widget, la variable widget fourni les champs de la class
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.panier.commandes.length * 20.0 + 10, 100),
              child: ListView(
                children: widget.panier.commandes
                    .map((prod) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              prod.produit.nom,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${prod.billetAdulte} x ${prod.produit.prixAdulte} €',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../models/panier_bdd.dart';

class CommandeItem extends StatefulWidget {
  //final CommandeModelItem commande;
  final PanierBdd panier;
  final int index;

  const CommandeItem({
    super.key,
    required this.panier,
    required this.index,
  });

  @override
  State<CommandeItem> createState() => _CommandeItemState();
}

class _CommandeItemState extends State<CommandeItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
                'Le total du panier ${widget.index + 1} est de ${widget.panier.valeurTotale} €'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date Retrait le ${DateFormat('dd/MM/yyyy').format(widget.panier.dateRetrait)}',
                ),
                Text(
                  'Date Commande le ${DateFormat('dd/MM/yyyy').format(widget.panier.dateCommande)}',
                ),
                const Divider(
                  color: Colors.black,
                ),
              ],
            ),
            trailing: IconButton(
              color: Colors.purple,
              iconSize: 35,
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
              height: min(widget.panier.commandes.length * 40.0 + 10, 100),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: Colors.black,
                ),
                itemCount: widget.panier.commandes.length,
                itemBuilder: (BuildContext context, int index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.panier.commandes[index].produit.nom,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        const Text('Billet Enfant'),
                        Text(
                          '${widget.panier.commandes[index].billetEnfant} x ${widget.panier.commandes[index].produit.prixEnfant} €',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('Billet Adulte'),
                        Text(
                          '${widget.panier.commandes[index].billetAdulte} x ${widget.panier.commandes[index].produit.prixAdulte} €',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

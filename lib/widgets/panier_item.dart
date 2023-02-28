import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/panier_provider.dart';

class PanierItem extends StatelessWidget {
  final int id;
  final int produitId;
  final String intitule;
  final double prixAdulte;
  final double prixEnfant;
  final int quantite;
  const PanierItem({
    super.key,
    required this.id,
    required this.intitule,
    required this.prixAdulte,
    required this.prixEnfant,
    required this.quantite,
    required this.produitId,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Supprimer ?'),
            content: const Text('Veux-tu supprimer cet item de ton panier ?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Non')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Oui')),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<PanierProvider>(context, listen: false)
            .removeItem(produitId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: FittedBox(
                  child: Text('€ $prixAdulte'),
                ),
              ),
            ),
            title: Text(intitule),
            subtitle: Text('Total : ${(prixAdulte * quantite)} €'),
            trailing: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                const Text('Billet(s)'),
                Text('x $quantite'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

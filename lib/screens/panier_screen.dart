import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/panier_provider.dart';
import '../providers/commande_provider.dart';
import '../widgets/panier_item.dart';

class PanierScreen extends StatelessWidget {
  const PanierScreen({super.key});

  static const routeName = '/panier';

  @override
  Widget build(BuildContext context) {
    final panier = Provider.of<PanierProvider>(context);
    //final commande = Provider.of<CommandeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Votre panier'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Chip(
                      label: Text(
                        '${panier.sommeTotale.toStringAsFixed(2)} €',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleLarge
                                ?.color),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    const Spacer(), //Ajouter un espace en poussant les éléments suivant vers l'espace restant
                    PasserCommandeBouton(panier: panier),
                  ]),
            ),
          ),
          const SizedBox(height: 10),
          //ListView ne fonctionne pas dans Column.Il faut donc le wrapper dans Expanded() par example qui permet de prendre tout l'espace restant ou de toute la place qu'on souhaite avoir ce qui est le cas de Listview.
          //Utilisation de ListView.builder car ne sachant pas à priori la longeur de la list.
          Expanded(
              child: ListView.builder(
            itemCount: panier.items.length,
            itemBuilder: (context, index) => PanierItem(
              id: panier.items.values.toList()[index].id,
              intitule: panier.items.values.toList()[index].nomProduit,
              prixAdulte: panier.items.values.toList()[index].prixAdulte,
              prixEnfant: panier.items.values.toList()[index].prixEnfant,
              quantite: panier.items.values.toList()[index].quantite,
              produitId: panier.items.keys.toList()[index],
            ),
          ))
        ],
      ),
    );
  }
}

class PasserCommandeBouton extends StatefulWidget {
  const PasserCommandeBouton({
    Key? key,
    required this.panier,
  }) : super(key: key);

  final PanierProvider panier;

  @override
  State<PasserCommandeBouton> createState() => _PasserCommandeBoutonState();
}

class _PasserCommandeBoutonState extends State<PasserCommandeBouton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.panier.sommeTotale <= 0 || _isLoading == true
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              //On appelle directement Provider.of<CommandeProvider>(context) sans passer par une variable et on n'a pas besoin ici d'écouter l'ajout de commande d'où le listen à false.s
              await Provider.of<CommandeProvider>(context, listen: false)
                  .addCommande(
                widget.panier.items.values.toList(),
                widget.panier.sommeTotale,
              );
              setState(() {
                _isLoading = false;
              });
              widget.panier.clearPanier();
            },
      style: widget.panier.sommeTotale <= 0
          ? null
          : ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor),
            ),
      child: _isLoading
          ? const CircularProgressIndicator()
          : const Text('Passer commande'),
    );
  }
}

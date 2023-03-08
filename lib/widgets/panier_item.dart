import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/panier_provider.dart';

class PanierItem extends StatelessWidget {
  //final Function renvoiTotalItem;
  final int id;
  final int produitId;
  final String intitule;
  final double prixAdulte;
  final double prixEnfant;
  final int billetAdulte;
  final int billetEnfant;
  //final int quantite;
  final double total;
  const PanierItem({
    super.key,
    required this.id,
    required this.intitule,
    required this.prixAdulte,
    required this.prixEnfant,
    this.billetAdulte = 0,
    this.billetEnfant = 0,
    //required this.quantite,
    required this.produitId,
    required this.total,
    //required this.renvoiTotalItem,
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
          child: PanierListTileItem(
            total: total,
            intitule: intitule,
            prixAdulte: prixAdulte,
            billetAdulte: billetAdulte,
            billetEnfant: billetEnfant,
            prixEnfant: prixEnfant,
            id: id,
            //renvoiTotalItem: renvoiTotalItem,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PanierListTileItem extends StatefulWidget {
  PanierListTileItem({
    Key? key,
    required this.total,
    required this.intitule,
    required this.prixAdulte,
    required this.billetAdulte,
    required this.billetEnfant,
    required this.prixEnfant,
    required this.id,
    //required this.renvoiTotalItem,
  }) : super(key: key);

  final int id;
  late double total;
  final String intitule;
  final double prixAdulte;
  late int billetAdulte;
  late int billetEnfant;
  final double prixEnfant;
  //final Function renvoiTotalItem;

  @override
  State<PanierListTileItem> createState() => _PanierListTileItemState();
}

class _PanierListTileItemState extends State<PanierListTileItem> {
  int _countBilletAdulte = 0;
  int _countBilletEnfant = 0;
  RegExp regex = RegExp(
      r'([.]*0)(?!.*\d)'); //Pour enlever les zéros si la partie décimale est nulle
  @override
  Widget build(BuildContext context) {
    //Dialogue ajout de billet
    Future<dynamic> openDialog() => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: Text('Ajout Billets ${widget.intitule}'),
                content: FittedBox(
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          const Text('Billet Adulte :'),
                          IconButton(
                              icon: const Icon(
                                Icons.remove,
                              ),
                              onPressed: _countBilletAdulte == 0
                                  ? null
                                  : () {
                                      setState(() => _countBilletAdulte--);
                                    }),
                          Text(
                            _countBilletAdulte.toString(),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () =>
                                  setState(() => _countBilletAdulte++))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const Text('Billet Enfant :'),
                          IconButton(
                              icon: const Icon(
                                Icons.remove,
                              ),
                              onPressed: _countBilletEnfant == 0
                                  ? null
                                  : () {
                                      setState(() => _countBilletEnfant--);
                                    }),
                          Text(
                            _countBilletEnfant.toString(),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() => _countBilletEnfant++);
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Ennuler'),
                      ),
                      TextButton(
                        onPressed: () {
                          var reponse = {
                            'nbBilletAdulte': _countBilletAdulte,
                            'nbBilletEnfant': _countBilletEnfant,
                            'totalItemPanie': widget.total
                          };
                          Navigator.of(context).pop(reponse);
                        },
                        child: const Text('Soumettre'),
                      ),
                    ],
                  )
                ],
              );
            }));

    return ListTile(
      leading: CircleAvatar(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: FittedBox(
            child: Text('€ ${widget.total.toString().replaceAll(regex, '')}'),
          ),
        ),
      ),
      title: Text(widget.intitule),
      subtitle: Text(
          '${widget.billetAdulte} x ${widget.prixAdulte.toString().replaceAll(regex, '')}€ + ${widget.billetEnfant} x ${widget.prixEnfant.toString().replaceAll(regex, '')}€'),
      trailing: ElevatedButton(
        onPressed: () async {
          final rep = await openDialog();
          if (rep != null) {
            setState(() {
              widget.billetAdulte = rep['nbBilletAdulte'];
              widget.billetEnfant = rep['nbBilletEnfant'];
              widget.total = (widget.prixAdulte * widget.billetAdulte) +
                  (widget.prixEnfant * widget.billetEnfant);
              //widget.renvoiTotalItem(widget.total);
              Provider.of<PanierProvider>(context, listen: false)
                  .setTotalPanier(widget.id, widget.total);
            });
          }
        },
        child: const Text('Ajout Billet'),
      ),
    );
  }
}

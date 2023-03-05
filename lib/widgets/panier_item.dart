import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/panier_provider.dart';

class PanierItem extends StatelessWidget {
  final int id;
  final int produitId;
  final String intitule;
  final double prixAdulte;
  final double prixEnfant;
  final int billetAdulte;
  final int billetEnfant;
  final int quantite;
  const PanierItem({
    super.key,
    required this.id,
    required this.intitule,
    required this.prixAdulte,
    required this.prixEnfant,
    this.billetAdulte = 0,
    this.billetEnfant = 0,
    required this.quantite,
    required this.produitId,
  });

  @override
  Widget build(BuildContext context) {
    //Total pour ce panier
    var total = (billetAdulte * prixAdulte) + (billetEnfant * prixEnfant);
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
              prixEnfant: prixEnfant),
        ),
      ),
    );
  }
}

class PanierListTileItem extends StatefulWidget {
  PanierListTileItem({
    Key? key,
    required this.total,
    required this.intitule,
    required this.prixAdulte,
    required this.billetAdulte,
    required this.billetEnfant,
    required this.prixEnfant,
  }) : super(key: key);

  late double total;
  final String intitule;
  final double prixAdulte;
  late int billetAdulte;
  late int billetEnfant;
  final double prixEnfant;

  @override
  State<PanierListTileItem> createState() => _PanierListTileItemState();
}

class _PanierListTileItemState extends State<PanierListTileItem> {
  int _countBilletAdulte = 0;
  int _countBilletEnfant = 0;
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
                              icon: const Icon(Icons.remove),
                              onPressed: _countBilletAdulte == 0
                                  ? null
                                  : () {
                                      setState(() => _countBilletAdulte--);
                                    }),
                          Text(_countBilletAdulte.toString()),
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
                              icon: const Icon(Icons.remove),
                              onPressed: _countBilletEnfant == 0
                                  ? null
                                  : () {
                                      setState(() => _countBilletEnfant--);
                                    }),
                          Text(_countBilletEnfant.toString()),
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
                // const TextField(
                //   decoration: InputDecoration(hintText: 'Nombre billet adulte'),
                // ),
                actions: [
                  TextButton(
                      onPressed: () {
                        var reponse = {
                          'nbBilletAdulte': _countBilletAdulte,
                          'nbBilletEnfant': _countBilletEnfant,
                        };
                        Navigator.of(context).pop(reponse);
                      },
                      child: const Text('Soumettre'))
                ],
              );
            }));

    return ListTile(
      leading: CircleAvatar(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: FittedBox(
            child: Text('€ ${widget.total}'),
          ),
        ),
      ),
      title: Text(widget.intitule),
      subtitle: Text(
          '${widget.prixAdulte} x ${widget.billetAdulte} + ${widget.prixEnfant} x ${widget.billetAdulte}'),
      trailing: ElevatedButton(
        onPressed: () async {
          final rep = await openDialog();
          setState(() {
            widget.billetAdulte = rep['nbBilletAdulte'];
            widget.billetEnfant = rep['nbBilletEnfant'];
            widget.total = (widget.prixAdulte * widget.billetAdulte) +
                (widget.prixEnfant * widget.billetEnfant);
          });
        },
        child: const Text('Ajout Billet'),
      ),
    );
  }
}

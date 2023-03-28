import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/panier_provider.dart';
import './date_picker.dart';
import '../models/date_notification.dart';

class PanierItem extends StatelessWidget {
  final int id;
  final int produitId;
  final String intitule;
  final double prixAdulte;
  final double prixEnfant;
  final int billetAdulte;
  final int billetEnfant;
  final double total;
  const PanierItem({
    super.key,
    required this.id,
    required this.intitule,
    required this.prixAdulte,
    required this.prixEnfant,
    this.billetAdulte = 0,
    this.billetEnfant = 0,
    required this.produitId,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DateNotification>(
      onNotification: (notification) {
        print(
            'PanierItem NotificationListener : ${DateFormat('dd/MM/yyyy').format(notification.date)}');
        return true;
      },
      child: Dismissible(
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
                  child: const Text('Non'),
                ),
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
            ),
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
  }) : super(key: key);

  final int id;
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
  int countBilletAdulte = 0;
  int countBilletEnfant = 0;
  DateTime? dateRetrait;
  RegExp regex = RegExp(
      r'([.]*0)(?!.*\d)'); //Pour enlever les zéros si la partie décimale est nulle

  @override
  Widget build(BuildContext context) {
    final panierProvider = Provider.of<PanierProvider>(context, listen: false);

    //Dialogue ajout de billet
    Future<dynamic> openDialog() => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: Text(
                  'Ajout Billets ${widget.intitule}',
                  textAlign: TextAlign.center,
                ),
                content: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 200.0,
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
                            NotificationListener<DateNotification>(
                              onNotification: (notification) {
                                dateRetrait = notification.date;

                                return true;
                              },
                              child: const DatePickerWidget(),
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
                          Navigator.of(context).pop();
                        },
                        child: const Text('Ennuler'),
                      ),
                      TextButton(
                        onPressed: () {
                          var reponse = {
                            'nbBilletAdulte': countBilletAdulte,
                            'nbBilletEnfant': countBilletEnfant,
                            'totalItemPanier': widget.total,
                            'dateRetrait': dateRetrait
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
          padding: const EdgeInsets.all(3),
          child: FittedBox(
            child: Text('${widget.total.toString().replaceAll(regex, '')}€'),
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
            });
            if (mounted) {
              DateNotification(date: rep['dateRetrait']).dispatch(context);
            }
            panierProvider.setTotalPanier(widget.id, widget.total);
            panierProvider.addBillets(
                widget.id, rep['nbBilletAdulte'], rep['nbBilletEnfant']);
          }
        },
        child: const Text('Ajout Billet'),
      ),
    );
  }
}

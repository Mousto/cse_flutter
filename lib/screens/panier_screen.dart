import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/panier_provider.dart';
import '../providers/commande_provider.dart';
import '../widgets/panier_item.dart';
import '../models/lieu_notification.dart';
import '../models/date_notification.dart';

class PanierScreen extends StatefulWidget {
  const PanierScreen({super.key});

  static const routeName = '/panier';

  @override
  State<PanierScreen> createState() => _PanierScreenState();
}

class _PanierScreenState extends State<PanierScreen> {
  RegExp regex = RegExp(
      r'([.]*0)(?!.*\d)'); //Pour enlever les zéros si la partie décimale est nulle

  DateTime? _dateRetraitPanier = DateTime.now();

  String selectedItem = 'Lieu test';
  List<DropdownMenuItem<String>>? itemsDeMenu;

  @override
  Widget build(BuildContext context) {
    final panier = Provider.of<PanierProvider>(context);

    //Fonction s'exécutant à partir du widget enfant PasserCommandeBouton.
    void resetPanier() {
      panier.clearPanier();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Définir Date et Lieu Retrait'),
      ),
      body: NotificationListener<DateRetraitNotification>(
        onNotification: (notification) {
          _dateRetraitPanier = notification.date;
          return true;
        },
        child: Column(
          children: <Widget>[
            Card(
              elevation: 5.0,
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
                    const SizedBox(width: 5),
                    Consumer<PanierProvider>(
                      //revoir le role du param child(non utilisé ici) dans le concept de Consumer.
                      builder: (BuildContext context, consumerPanier,
                              Widget? child) =>
                          Chip(
                        label: Text(
                          '${consumerPanier.sommeTotale.toString().replaceAll(regex, '')} €',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleLarge
                                  ?.color),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const Spacer(), //Ajoute un espace en poussant les éléments suivant vers l'espace restant
                    PasserCommandeBouton(
                      panier: panier,
                      viderPanier: resetPanier,
                      dateR: Provider.of<PanierProvider>(context, listen: false)
                          .dateDeRetrait,
                      lieuR: selectedItem,
                    ),
                  ],
                ),
              ),
            ),
            //Affichage selon contenu du panier
            panier.itemCount != 0
                ? Card(
                    elevation: 5.0,
                    margin: const EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Column(
                        children: [
                          MonCalendrier(
                            dateRetrait: _dateRetraitPanier!,
                            onDateChange: (data) {
                              _dateRetraitPanier = data;
                              panier.setDateRetrait(data);
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Lieu Retrait :',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              //const Spacer(), //Ajouter un espace en poussant les éléments suivant vers l'espace restant
                              SizedBox(
                                width: 200,
                                child: MonDropdownBoutton(
                                    selectedItem: selectedItem,
                                    itemsDeMenu: itemsDeMenu),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : const Text(
                    'Ton panier est vide.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
            //ListView ne fonctionne pas dans Column.Il faut donc le wrapper dans Expanded() par example qui permet de prendre tout l'espace restant ou de toute la place qu'on souhaite avoir ce qui est le cas de Listview.
            //Utilisation de ListView.builder car ne sachant pas à priori la longeur de la list.
            Expanded(
              child: ListView.builder(
                itemCount: panier.items.length,
                itemBuilder: (context, index) => PanierItem(
                  id: panier.items.values.toList()[index].id,
                  intitule: panier.items.values.toList()[index].produit.nom,
                  prixAdulte:
                      panier.items.values.toList()[index].produit.prixAdulte,
                  prixEnfant:
                      panier.items.values.toList()[index].produit.prixEnfant,
                  produitId: panier.items.keys.toList()[index],
                  total: (panier.items.values
                              .toList()[index]
                              .produit
                              .prixAdulte *
                          panier.items.values.toList()[index].billetAdulte) +
                      (panier.items.values.toList()[index].produit.prixEnfant *
                          panier.items.values.toList()[index].billetEnfant),
                  billetAdulte:
                      panier.items.values.toList()[index].billetAdulte,
                  billetEnfant:
                      panier.items.values.toList()[index].billetEnfant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MonCalendrier extends StatefulWidget {
  final Function(DateTime) onDateChange;
  late DateTime dateRetrait;

  MonCalendrier({
    super.key,
    required this.dateRetrait,
    required this.onDateChange,
  });

  @override
  State<MonCalendrier> createState() => _MonCalendrierState();
}

class _MonCalendrierState extends State<MonCalendrier> {
  DateTime? date;
  Future<dynamic> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      locale: const Locale("fr", "FR"),
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (newDate == null) {
      return;
    }

    setState(() {
      widget.onDateChange(newDate);
      widget.dateRetrait = newDate;
      DateRetraitNotification(date: newDate).dispatch(context);
    });
    return newDate;
  }

  @override
  Widget build(BuildContext context) {
    // La ligne ci-dessous permet de place ce présent widget sous l'arborescence de InheritedWidget qu'est DateHeritage
    //final DateHeritage? dateHerited = DateHeritage.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Date Retrait :',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(
          width: 200.0,
          child: SizedBox(
            child: Row(
              children: [
                Text(
                  DateFormat('dd/MM/yyyy').format(widget.dateRetrait),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const Spacer(), //Ajouter un espace en poussant les éléments suivant vers l'espace restant,
                IconButton(
                  color: Colors.green,
                  icon: const Icon(Icons.calendar_month),
                  onPressed: () async {
                    await pickDate(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class MonDropdownBoutton extends StatefulWidget {
  String selectedItem;
  final List<DropdownMenuItem<String>>? itemsDeMenu;

  MonDropdownBoutton({
    super.key,
    required this.selectedItem,
    required this.itemsDeMenu,
  });

  @override
  State<MonDropdownBoutton> createState() => _MonDropdownBouttonState();
}

class _MonDropdownBouttonState extends State<MonDropdownBoutton> {
  List<DropdownMenuItem<String>>? itemsDeMenu = const [
    DropdownMenuItem(
      value: 'Sélectionner',
      child: Text('Sélectionner le lieu'),
    ),
    DropdownMenuItem(
      value: 'Talant',
      child: Text('Clinique Bénigne Joly'),
    ),
    DropdownMenuItem(
      value: 'Valmy',
      child: Text('SSR Valmy'),
    ),
  ];
  String selectedItem = 'Sélectionner';
  @override
  Widget build(BuildContext context) {
    final panier = Provider.of<PanierProvider>(context);
    return DropdownButton(
        value: selectedItem,
        items: itemsDeMenu,
        iconSize: 45.0,
        isExpanded: true,
        iconEnabledColor:
            selectedItem == 'Sélectionner' ? Colors.purple : Colors.green,
        onChanged: (String? selectedValue) {
          if (selectedValue is String) {
            setState(() {
              selectedItem = selectedValue;
              panier.setLieuRetrait(selectedItem);
              LieuRetraitNotification(lieu: selectedValue).dispatch(context);
            });
          }
        });
  }
}

class PasserCommandeBouton extends StatefulWidget {
  const PasserCommandeBouton(
      {Key? key,
      required this.panier,
      required this.viderPanier,
      required this.dateR,
      required this.lieuR})
      : super(key: key);

  final PanierProvider panier;
  final VoidCallback viderPanier;
  final DateTime dateR;
  final String lieuR;

  @override
  State<PasserCommandeBouton> createState() => _PasserCommandeBoutonState();
}

class _PasserCommandeBoutonState extends State<PasserCommandeBouton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final panierPasserComm =
        Provider.of<PanierProvider>(context); //Mise en écoute.

    return TextButton(
      onPressed: widget.panier.sommeTotale <= 0 || _isLoading == true
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });

              //On appelle directement Provider.of<CommandeProvider>(context) sans passer par une variable et on n'a pas besoin ici d'écouter l'ajout de commande d'où le listen à false.
              try {
                await Provider.of<CommandeProvider>(context, listen: false)
                    .addCommande(
                  widget.panier.items.values.toList(),
                  widget.panier.sommeTotale,
                  widget.dateR,
                  panierPasserComm.lieuRetrait,
                );
                widget.viderPanier(); //Exécute fonction dans le parent
                //Réinitialisation de la date
                panierPasserComm.setDateRetrait(DateTime.now());
                //réinitialisation du lieu de retrait
                panierPasserComm.setLieuRetrait('');
              } catch (error) {
                print('erreur à traiter : $error');
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Avertissement !',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: const Text(
                      "Désolé, cette opération n'a pas abouti.Vous n'avez probablement pas choisi un lieu de retrait. Si un lieu de retrait est défini, Veuillez essayer ultérieurement.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    elevation: 24.0,
                    backgroundColor: Colors.purple,
                    // shape: const CircleBorder(),
                  ),
                );
              }
              setState(() {
                _isLoading = false;
              });
            },
      style: widget.panier.sommeTotale <= 0
          ? null
          : ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.primary),
            ),
      child: _isLoading
          ? const CircularProgressIndicator()
          : const Text('Passer Commande'),
    );
  }
}

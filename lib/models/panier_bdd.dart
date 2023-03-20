import 'package:intl/intl.dart';

import '../models/commande_bdd.dart';

class PanierBdd {
  final int id;
  final List<CommandeBdd> commandes;
  final double valeurTotale;
  final DateTime dateRetrait;
  final DateTime dateCommande;
  final String lieuRetrait;
  final int commanditaire;

  PanierBdd({
    required this.id,
    required this.commandes,
    required this.valeurTotale,
    required this.dateRetrait,
    required this.dateCommande,
    required this.lieuRetrait,
    required this.commanditaire,
  });

  factory PanierBdd.fromJson(Map<String, dynamic> json) {
    List<CommandeBdd> commandes = [];
    for (var commande in json['commandes']) {
      commandes.add(CommandeBdd.fromJson(commande));
    }
    return PanierBdd(
      id: json['id'],
      commandes: commandes,
      commanditaire: json['commanditaire'],
      dateCommande: DateFormat("yyyy-MM-dd").parse(json['date']),
      dateRetrait: DateFormat("yyyy-MM-dd").parse(json['date_retrait']),
      lieuRetrait: json['lieu_retrait'],
      valeurTotale: json['valeur_totale'],
    );
  }
}

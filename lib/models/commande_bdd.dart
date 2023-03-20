import '../models/produit_model.dart';

class CommandeBdd {
  final int id;
  final int billetAdulte;
  final int billetEnfant;
  final double sousTotal;
  final ProduitModel produit;

  CommandeBdd({
    required this.id,
    required this.billetAdulte,
    required this.billetEnfant,
    required this.sousTotal,
    required this.produit,
  });

  factory CommandeBdd.fromJson(Map<String, dynamic> json) {
    return CommandeBdd(
      id: json['id'],
      billetAdulte: json['billet_adulte'],
      billetEnfant: json['billet_enfant'],
      sousTotal: json['sous_total'],
      produit: ProduitModel.fromJson(json['produit']),
    );
  }
}

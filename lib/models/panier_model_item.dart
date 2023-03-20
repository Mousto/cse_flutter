import './produit_model.dart';

class PanierModelItem {
  final int id;
  final ProduitModel produit;
  final int quantite;
  late int billetAdulte;
  late int billetEnfant;
  late double sousTotal;

  PanierModelItem({
    required this.produit,
    required this.id,
    required this.quantite,
    required this.billetAdulte,
    required this.billetEnfant,
    required this.sousTotal,
  });

  factory PanierModelItem.fromJson(Map<String, dynamic> json) {
    return PanierModelItem(
      id: json['id'],
      billetAdulte: json['billetAdulte'],
      billetEnfant: json['billetEnfant'],
      produit: json['produit'],
      quantite: json['quantite'],
      sousTotal: json['Soustotal'],
    );
  }
}

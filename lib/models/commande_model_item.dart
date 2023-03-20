import 'panier_model_item.dart';

class CommandeModelItem {
  final int id;
  final List<PanierModelItem> produits;
  final double montant;
  final DateTime dateCommande;
  final DateTime? dateRetrait;
  final String? lieuRetrait;
  final int commanditaire;

  CommandeModelItem({
    required this.id,
    required this.produits,
    required this.montant,
    required this.dateCommande,
    required this.dateRetrait,
    required this.lieuRetrait,
    required this.commanditaire,
  });

  factory CommandeModelItem.fromJson(Map<String, dynamic> json,
      {required commanditaire,
      required dateCommande,
      required dateRetrait,
      required id,
      required lieuRetrait,
      required montant,
      required produits}) {
    return CommandeModelItem(
      id: json['id'],
      produits: json['produit'],
      montant: json['montant'],
      dateCommande: json['dateCommande'],
      dateRetrait: json['dateRetrait'],
      lieuRetrait: json['lieuRetrait'],
      commanditaire: json['commanditaire'],
    );
  }
}

import 'panier_model_item.dart';

class CommandeModelItem {
  final String id;
  final double montant;
  final List<PanierModelItem> produits;
  final DateTime dateCommande;
  final DateTime? dateRetrait;
  final String? lieuRetrait;

  CommandeModelItem({
    required this.id,
    required this.montant,
    required this.produits,
    required this.dateCommande,
    this.dateRetrait,
    this.lieuRetrait,
  });
}

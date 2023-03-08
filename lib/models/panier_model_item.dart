class PanierModelItem {
  final int id;
  final String nomProduit;
  final int quantite;
  final double prixAdulte;
  final double prixEnfant;
  late int billetAdulte;
  late int billetEnfant;
  late double sousTotal;

  PanierModelItem({
    required this.id,
    required this.nomProduit,
    required this.quantite,
    required this.prixAdulte,
    required this.prixEnfant,
    required this.billetAdulte,
    required this.billetEnfant,
    required this.sousTotal,
  });
}

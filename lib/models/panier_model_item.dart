class PanierModelItem {
  final int id;
  final String nomProduit;
  final int quantite;
  final double prix;
  final DateTime? dateCommande;
  final DateTime? dateRetrait;
  final String? lieuRetrait;

  PanierModelItem({
    this.dateCommande,
    this.dateRetrait,
    this.lieuRetrait,
    required this.id,
    required this.nomProduit,
    required this.quantite,
    required this.prix,
  });
}

class ProduitModel {
  final int id;
  final String nom;
  final double prixAdulte;
  final double prixEnfant;
  final String photo;
  final bool disponible;

  ProduitModel({
    required this.id,
    required this.nom,
    required this.prixAdulte,
    required this.prixEnfant,
    required this.photo,
    required this.disponible,
  });
}

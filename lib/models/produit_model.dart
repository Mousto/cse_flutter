import 'package:cse_talant_valmy/widgets/produit_item.dart';

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

  factory ProduitModel.fromJson(Map<String, dynamic> json) {
    return ProduitModel(
      id: json['id'],
      nom: json['nom'],
      prixAdulte: json['prix_adulte'],
      prixEnfant: json['prix_enfant'],
      photo: json['photo'],
      disponible: json['disponible'],
    );
  }
}

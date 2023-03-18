import 'package:cse_talant_valmy/widgets/produit_item.dart';

import './produit_model.dart';

class PanierModelItem {
  final int id;
  final ProduitModel produit;
  //final String nomProduit;
  final int quantite;
  //final double prixAdulte;
  //final double prixEnfant;
  late int billetAdulte;
  late int billetEnfant;
  late double sousTotal;

  PanierModelItem({
    required this.produit,
    required this.id,
    //required this.nomProduit,
    required this.quantite,
    // required this.prixAdulte,
    // required this.prixEnfant,
    required this.billetAdulte,
    required this.billetEnfant,
    required this.sousTotal,
  });
}

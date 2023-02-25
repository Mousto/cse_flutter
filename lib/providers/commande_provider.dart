import 'package:flutter/foundation.dart';

import '../models/commande_model_item.dart';
import '../models/panier_model_item.dart';

class CommandeProvider with ChangeNotifier {
  List<CommandeModelItem> _commandes = [];

  //Getter des commandes
  List<CommandeModelItem> get commandes {
    // Retour d'une copie par Spreading
    return [..._commandes];
  }

  //Ajouter une commande
  void addCommande(List<PanierModelItem> panierProduits, double total) {
    //index de la methode insert() à 0 pour dire que l'élément à ajouter doit être en début de liste sinon utiliser la méthode add() pour ajouter en fin de liste
    _commandes.insert(
      0,
      CommandeModelItem(
        id: DateTime.now().toString(),
        montant: total,
        dateCommande: DateTime.now(),
        produits: panierProduits,
        //dateRetrait: dateRetrait,
        //lieuRetrait: lieuRetrait,
      ),
    );
    notifyListeners();
  }
}

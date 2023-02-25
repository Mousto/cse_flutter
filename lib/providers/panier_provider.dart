import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

import '../models/panier_model_item.dart';

class PanierProvider with ChangeNotifier {
  Map<int, PanierModelItem> _items = {};

  Map<int, PanierModelItem> get items {
    //On retourne une copie de la Map par Spreading
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  int itemCountByName(String nomProduit) {
    var count = 0;
    _items.forEach((key, panierItem) {
      if (panierItem.nomProduit == nomProduit) {
        count = panierItem.quantite;
      }
    });
    return count;
  }

  double get sommeTotale {
    var total = 0.0;
    _items.forEach((key, panierItem) {
      total += panierItem.prix * panierItem.quantite;
    });
    return total;
  }

  void addItem(int produitId, double prix, String intitule) {
    if (_items.containsKey(produitId)) {
      //change de quantité du produit concerné
      _items.update(
        produitId,
        (produitExistant) => PanierModelItem(
            id: produitExistant.id,
            nomProduit: produitExistant.nomProduit,
            quantite: produitExistant.quantite + 1,
            prix: produitExistant.prix),
      );
    } else {
      _items.putIfAbsent(
          produitId,
          () => PanierModelItem(
                id: produitId,
                nomProduit: intitule,
                quantite: 1,
                prix: prix,
              ));
    }
    notifyListeners();
  }

  void removeItem(int id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(int productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantite > 1) {
      _items.update(
        productId,
        (panierItemExistant) => PanierModelItem(
          id: panierItemExistant.id,
          nomProduit: panierItemExistant.nomProduit,
          quantite: panierItemExistant.quantite - 1,
          prix: panierItemExistant.prix,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearPanier() {
    _items = {};
    notifyListeners();
  }
}

import 'package:cse_talant_valmy/widgets/panier_item.dart';
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
      total += panierItem.sousTotal;
      // (panierItem.prixAdulte * panierItem.billetAdulte) +
      //     (panierItem.prixEnfant * panierItem.billetEnfant);
    });
    return total;
  }

  // void addBillets(int prodId, int nbBilletAdulte, int nbBilletEnfant) {
  //   var panierItem = _items[prodId];
  //   print('*************************${panierItem?.id}');
  //   panierItem?.billetAdulte = nbBilletAdulte;
  //   panierItem?.billetEnfant = nbBilletEnfant;
  //   notifyListeners();
  // }

  void addItem(int produitId, double prixAdulte, double prixEnfant,
      String intitule, int billetAdulte, int billetEnfant, double sousTotal) {
    if (_items.containsKey(produitId)) {
      //change de quantité du produit concerné
      _items.update(
        produitId,
        (produitExistant) => PanierModelItem(
          id: produitExistant.id,
          nomProduit: produitExistant.nomProduit,
          quantite: produitExistant.quantite,
          prixAdulte: produitExistant.prixAdulte,
          prixEnfant: produitExistant.prixEnfant,
          billetAdulte: produitExistant.billetAdulte,
          billetEnfant: produitExistant.billetEnfant,
          sousTotal: produitExistant.sousTotal,
          // (produitExistant.prixAdulte * produitExistant.billetAdulte) +
          //     (produitExistant.prixEnfant * produitExistant.billetEnfant),
        ),
      );
    } else {
      _items.putIfAbsent(
          produitId,
          () => PanierModelItem(
                id: produitId,
                nomProduit: intitule,
                quantite: 1,
                prixAdulte: prixAdulte,
                prixEnfant: prixEnfant,
                billetAdulte: billetAdulte,
                billetEnfant: billetEnfant,
                sousTotal: sousTotal,
                // (prixAdulte * billetAdulte) + (prixEnfant * billetEnfant),
              ));
    }
    notifyListeners();
  }

  void setTotalPanier(int panierId, double totalPanier) {
    if (_items.containsKey(panierId)) {
      print('yeah');
      _items[panierId]!.sousTotal = totalPanier;
    }
    //print(totalPanier);
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
          prixAdulte: panierItemExistant.prixAdulte,
          prixEnfant: panierItemExistant.prixEnfant,
          billetAdulte: panierItemExistant.billetAdulte,
          billetEnfant: panierItemExistant.billetEnfant,
          sousTotal: (panierItemExistant.prixAdulte *
                  panierItemExistant.billetAdulte) +
              (panierItemExistant.prixEnfant * panierItemExistant.billetEnfant),
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

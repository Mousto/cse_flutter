import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  Future<void> addCommande(
      List<PanierModelItem> panierProduits, double total) async {
    const url = 'http://192.168.1.48:8000/api/commandes/';
    final timeStamp = DateTime
        .now(); //On stock le timeStamp ici pour avoir la même valeur vers le serveur et en retour de la requête du serveur
    final reponse = await http.post(
      Uri.parse(url),
      body: json.encode({
        'valeur_totale': total,
        'produits': panierProduits
            .map((e) => {
                  'id': e.id,
                  'nom': e.nomProduit,
                  'quantite': e.quantite,
                  'prix_adulte': e.prixAdulte,
                  'prix_enfant': e.prixEnfant,
                })
            .toList(),
        'date': timeStamp
            .toIso8601String(), //facilement reconvertible en DateTime au besion dans dart.
        'date_retrait': timeStamp.toIso8601String(),
        'lieu_retrait': 'Talant',
        'billet_adulte': 10,
        'billet_enfant': 5,
        'commanditaire': 'Mous Dia'
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(reponse.body);
    //index de la methode insert() à 0 pour dire que l'élément à ajouter doit être en début de liste sinon utiliser la méthode add() pour ajouter en fin de liste
    // _commandes.insert(
    //   0,
    //   CommandeModelItem(
    //     id: json.decode(reponse.body)['id'],
    //     montant: total,
    //     dateCommande: timeStamp,
    //     produits: panierProduits,
    //     //dateRetrait: dateRetrait,
    //     //lieuRetrait: lieuRetrait,
    //   ),
    // );
    notifyListeners();
  }
}

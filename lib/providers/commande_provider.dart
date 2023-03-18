import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/commande_model_item.dart';
import '../models/panier_model_item.dart';

class CommandeProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<CommandeModelItem> _commandes = [];

  //Getter des commandes
  List<CommandeModelItem> get commandes {
    // Retour d'une copie par Spreading
    return [..._commandes];
  }

  Future<void> fetchAndSetCommandes() async {
    const url = 'http://192.168.1.48:8000/api/panier/';
    final reponse = await http.get(Uri.parse(url));
    print(json.decode(reponse.body));
  }

  //Ajouter une commande
  Future<void> addCommande(
      List<PanierModelItem> panierProduits, double total) async {
    const url = 'http://192.168.1.48:8000/api/panier/';
    final timeStamp = DateTime
        .now(); //On stock le timeStamp ici pour avoir la même valeur vers le serveur et en retour de la requête du serveur
    final reponse = await http.post(
      Uri.parse(url),
      body: json.encode({
        'commandes': panierProduits
            .map((e) => {
                  'id': e.id,
                  'nom': e.produit.nom,
                  //'quantite': e.quantite,
                  'prix_adulte': e.produit.prixAdulte,
                  'prix_enfant': e.produit.prixEnfant,
                  'billet_adulte': e.billetAdulte,
                  'billet_enfant': e.billetEnfant,
                  'sous_total': e.sousTotal,
                })
            .toList(),
        'valeur_totale': total,
        'date': timeStamp
            .toIso8601String(), //facilement reconvertible en DateTime au besion dans dart.
        'date_retrait': timeStamp.toIso8601String(),
        'lieu_retrait': 'Talant',
        'commanditaire': 1
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var jsonReponse = json.decode(reponse.body);
    print(jsonReponse['commandes'][0]);
    //index de la methode insert() à 0 pour dire que l'élément à ajouter doit être en début de liste sinon utiliser la méthode add() pour ajouter en fin de liste
    // _commandes.insert(
    //   0,
    //   CommandeModelItem(
    //     id: jsonReponse['commandes'][0]['id'],
    //     montant: total,
    //     dateCommande: timeStamp,
    //     produits: panierProduits,
    //     //dateRetrait: dateRetrait,
    //     //lieuRetrait: lieuRetrait,
    //   ),
    // );

    // jsonReponse['commandes'][0] => {id: 32, billet_adulte: 1, billet_enfant: 0, sous_total: 12.0, produit: {id: 1, nom: Bowling, prix_adulte: 12.0, prix_enfant: 7.5, photo: /media/img-produits/bowling_3ihTNd9_js4I98E_5Q7os7C.jpeg, disponible: true}}
    notifyListeners();
  }
}

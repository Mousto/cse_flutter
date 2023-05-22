import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/panier_model_item.dart';
import '../models/panier_bdd.dart';

class CommandeProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<PanierBdd> _paniers = [];

  //Getter des commandes
  List<PanierBdd> get paniers {
    // Retour d'une copie par Spreading
    //print('les paniers ${[..._paniers]}');
    return [..._paniers];
  }

  Future<void> fetchAndSetCommandes() async {
    const url = 'http://192.168.1.48:8000/api/panier';
    final reponse = await http.get(Uri.parse(url));
    final donneesExtraites = const Utf8Decoder().convert(reponse.bodyBytes);
    var myList = List<Map<String, dynamic>>.from(json.decode(donneesExtraites));
    if (_paniers.length != myList.length) {
      bool match = true;
      for (var i = 0; i < myList.length; i++) {
        for (final panier in _paniers) {
          if (myList[i]['id'] == panier.id) {
            match = match && false;
          }
        }
        if (match) {
          _paniers.insert(
            0,
            PanierBdd.fromJson(myList[i]),
          );
        }
      }
    }
    // print(
    //     '******************${json.decode(reponse.body)[0]['commandes'][0]['produit']['nom']}');
    notifyListeners();
  }

  //Ajouter une commande
  Future<void> addCommande(List<PanierModelItem> panierProduits, double total,
      DateTime dateRetrait, String lieuRetrait) async {
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
        'date_retrait': dateRetrait.toIso8601String(),
        'lieu_retrait': lieuRetrait,
        'commanditaire': 1
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var jsonReponse = json.decode(reponse.body);
    //print('Dans CommandeProvider -> addcommande, Lieu retrait : $lieuRetrait');

    //index de la methode insert() à 0 pour dire que l'élément à ajouter doit être en début de liste sinon utiliser la méthode add() pour ajouter en fin de liste
    _paniers.insert(
      0,
      PanierBdd.fromJson(jsonReponse),
    );

    notifyListeners();
  }
}

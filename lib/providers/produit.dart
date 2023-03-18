import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert'; //besoin de cet import pour la méthode jsonDecode().

import '../models/http_exception.dart';

class ProduitProvider with ChangeNotifier {
  final int id;
  final String nom;
  final double prixAdulte;
  final double prixEnfant;
  double sommeTotale;
  int billetAdulte;
  int billetEnfant;
  final String photo;
  final Color couleur;
  bool disponible;
  bool isFavorite;

  ProduitProvider({
    required this.id,
    required this.nom,
    required this.prixAdulte,
    required this.prixEnfant,
    this.billetAdulte = 0,
    this.billetEnfant = 0,
    this.sommeTotale = 0,
    required this.photo,
    this.couleur = Colors.purple,
    required this.disponible,
    this.isFavorite = false,
  });

  factory ProduitProvider.fromJson(Map<String, dynamic> json) {
    return ProduitProvider(
      id: json['id'],
      nom: json['nom'],
      prixAdulte: json['prix_adulte'],
      prixEnfant: json['prix_enfant'],
      photo: json['photo'],
      disponible: json['disponible'], //json['disponible'],
      isFavorite: false,
      couleur: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    );
  }

  void toggleIsFavorite() {
    isFavorite = !isFavorite;
    notifyListeners(); //informer les écouteurs
  }

  Future<void> isDisponible() async {
    //On utilise ici l'optimistic update(d'abord effectuer le changement et faire un roolback s'il ya un blem par la suite)
    final oldStatus = disponible; // on stock la valeur d'avant modification...
    //...on la modifie ensuite
    disponible = !disponible;
    notifyListeners(); //informer les écouteurs
    final url = 'http://192.168.1.48:8000/api/produits/$id/';
    try {
      final res = await http.patch(
        Uri.parse(url),
        body: json.encode({
          'disponible': disponible,
        }),
      );
      if (res.statusCode >= 400) {
        //En cas d'échec, on remet la valeur initiale de la variable disponible
        disponible = oldStatus;
        notifyListeners(); //informer les écouteurs
        //Lancer l'erreur
        throw HttpException(
            'Échec à changer la disponibilité du produit $nom.');
      }
      //print(json.decode(res.body));
    } catch (error) {
      //En cas d'échec, on remet la valeur initiale de la variable disponible
      disponible = oldStatus;
      notifyListeners(); //informer les écouteurs
      rethrow;
    }
  }
}

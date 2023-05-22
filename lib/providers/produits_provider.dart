import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; //besoin de cet import pour la méthode jsonDecode().

import 'produit.dart';

class ProduitsProvider with ChangeNotifier {
  List<ProduitProvider> _items = []; // PRODUITS_FACTICES;

  //Le getter de _items qui est privé et nom directement accessible à l'extérieur de cette class
  List<ProduitProvider> get items {
    //Renvoi d'une copie de la liste(pour éviter d'éditer et muter la liste) avec un spread operator
    return [..._items];
  }

  List<ProduitProvider> get favoriteProduct {
    return _items.where((element) => element.isFavorite).toList();
  }

  Future<void> addProduit(ProduitProvider prod, File image) async {
    //192.168.1.48 adresse ip de wifi de l'ordi qui sert pour le téléphone connecté en usb. Il faut démarrer le serveur Django avec l'adresse allant avec le ip donc : [python manage.py runserver http://192.168.1.48:8000]
    const url = 'http://192.168.1.48:8000/api/produits/';
    Dio dio = Dio();

    // Creating a form data
    FormData formData = FormData.fromMap({
      "donnees": {
        'nom': prod.nom,
        'prix_adulte': prod.prixAdulte,
        'prix_enfant': prod.prixEnfant,
        // 'billet_adulte': prod.billetAdulte,
        // 'billet_enfant': prod.billetEnfant,
      },
      "image": await MultipartFile.fromFile(image.path,
          filename: File(image.path).path.split('/').last),
    });

    //On fait le return ici et pas dans le then() car après exécution de cet dernier qui retourne un Future, il retournera au final le Future du post
    try {
      final reponseServeur = await dio.post(url,
          data: formData,
          options: Options(
              followRedirects: false,
              // will not throw errors
              validateStatus: (status) => true,
              headers: {
                "accept": "*/*",
                "Content-Type": "multipart/form-data",
              }));
      final nouveauProduit = ProduitProvider.fromJson(reponseServeur.data);
      _items.add(nouveauProduit);
      //_items.insert(0, nouveauProduit); //alternative qui place le nouvel élément en début de liste

      //Informer les écouteurs du changement
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> updateProduit(int id, ProduitProvider nouveauProduit) async {
    final url = 'http://192.168.1.48:8000/api/produits/$id/';
    final Dio dio = Dio();

    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      try {
        var formData = FormData();
        formData.files.add(MapEntry(
          "Picture",
          await MultipartFile.fromFile(nouveauProduit.photo),
        ));
        var response = await dio.patch(url, data: formData);

        //Ajouter le prod
        _items[prodIndex] = nouveauProduit;
        //Le notifier aux écouteurs
        notifyListeners();
      } catch (error) {
        print(error);
        rethrow;
      }
    }
  }

// Supression de produit
  Future<void> deleteProduit(int id) async {
    try {
      if (id == 0) {
        //Trouver la bonne condition pour lancer l'exception. Par exemple si on n'est pas admin, on ne peut faire de suppression. Ici évidemment aucun id n'est égal à 0,condition factice donc.
        throw 'Suppression non autorisée.';
      }
      var url = 'http://192.168.1.48:8000/api/produits/$id/';
      Dio dio = Dio();
      final reponse = await dio.delete(url);
      if (reponse.statusCode == 204) {
        _items.removeWhere((element) => element.id == id);
        notifyListeners();
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  ProduitProvider findById(int id) {
    return _items.firstWhere((element) => element.id == id);
  }

  //Charger les produits à partir du serveur
  Future<void> fetchAndSetProducts() async {
    if (_items.isEmpty) {
      const String url = 'http://192.168.1.48:8000';
      try {
        final reponse = await http.get(Uri.parse('$url/api/produits'));
        final donneesExtraites = const Utf8Decoder().convert(reponse.bodyBytes);
        final List<ProduitProvider> listProduits = [];
        for (var el in jsonDecode(donneesExtraites)) {
          listProduits.add(
            ProduitProvider.fromJson(
              el,
            ),
          );
        }
        _items = listProduits;
        notifyListeners();
      } catch (error) {
        print(
            '**************************** catch de fetchAndSetproduit : $error');
        rethrow; // relance l'erreur
      }
    }
  }

  Future<List<ProduitProvider>> setProduits(List<ProduitProvider> produits) {
    _items = produits;
    return Future.value(_items);
  }
}

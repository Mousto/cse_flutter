import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; //besoin de cet import pour la méthode jsonDecode().

import 'providers/produit.dart';

List<ProduitProvider> PRODUITS_FACTICES = [
  ProduitProvider(
    id: 1,
    nom: 'Cinéma',
    prixAdulte: 10,
    prixEnfant: 5,
    disponible: false,
    photo: 'cinema.webp',
    couleur: Colors.purple,
  ),
  ProduitProvider(
    id: 2,
    nom: 'Bowling',
    prixAdulte: 15,
    prixEnfant: 7,
    disponible: true,
    photo: 'cinema.webp',
    couleur: Colors.red,
  ),
  ProduitProvider(
    id: 3,
    nom: 'Parc attraction',
    prixAdulte: 18,
    prixEnfant: 8,
    disponible: true,
    photo: 'cinema.webp',
    couleur: Colors.orange,
  ),
  ProduitProvider(
    id: 4,
    nom: 'Carting',
    prixAdulte: 21,
    prixEnfant: 10,
    disponible: true,
    photo: 'cinema.webp',
    couleur: Colors.amber,
  ),
  ProduitProvider(
    id: 5,
    nom: 'Théatre',
    prixAdulte: 22.5,
    prixEnfant: 11,
    disponible: true,
    photo: 'cinema.webp',
    couleur: Colors.blue,
  ),
  ProduitProvider(
    id: 6,
    nom: 'Concert',
    prixAdulte: 25,
    prixEnfant: 12.5,
    disponible: true,
    photo: 'cinema.webp',
    couleur: Colors.green,
  ),
];

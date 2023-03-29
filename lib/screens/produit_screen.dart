import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert'; //besoin de cet import pour la méthode jsonDecode().
// import 'dart:math';

import '../widgets/produit_item.dart';
import '../providers/panier_provider.dart';
import '../providers/produits_provider.dart';
//import '../providers/produit.dart';
import '../widgets/main_drawer.dart';
import '../widgets/mon_badge.dart';
import '../screens/panier_screen.dart';

enum OptionsFiltrage { produitsFavoris, tousLesProduits, connexionDjango }

class ProduitScreen extends StatefulWidget {
  const ProduitScreen({super.key});

  @override
  State<ProduitScreen> createState() => _ProduitScreenState();
}

class _ProduitScreenState extends State<ProduitScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProduitsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) {
        print(' Dans catch de fetchAndSetproduit de Produit_screen $error');
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Une erreur est advenue !'),
            content: const Text('Veuillez réessayer ultérieurement.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('OK'))
            ],
          ),
        ).then((_) {
          Navigator.of(context).pop();
        });
      });
    }
    _isInit = false; //évite l'excution intempestive de cette fonction
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final produitsData = Provider.of<ProduitsProvider>(context);
    final lesProduits =
        _showOnlyFavorites ? produitsData.favoriteProduct : produitsData.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Billeterie'),
        actions: <Widget>[
          PopupMenuButton(
            //optioFiltrage en param est le type enum ci-dessus définit
            onSelected: (OptionsFiltrage seletedValue) {
              setState(() {
                if (seletedValue == OptionsFiltrage.produitsFavoris) {
                  _showOnlyFavorites = true;
                } else if (seletedValue == OptionsFiltrage.connexionDjango) {
                  print('Connexion avec django');
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: OptionsFiltrage.produitsFavoris,
                child: Text('Produits favoris'),
              ),
              const PopupMenuItem(
                value: OptionsFiltrage.tousLesProduits,
                child: Text('Tous les produits'),
              ),
              const PopupMenuItem(
                value: OptionsFiltrage.connexionDjango,
                child: Text('Connexion Django'),
              ),
            ],
          ),
          //Utilisation de Consumer() sur seulement le badge qui est celui qui est concerné par les données. On vient donc au plus près avec ce widget pour éviter le rechargement entier la page en utilisant le widget Privider
          Consumer<PanierProvider>(
            builder: (_, panier, ch) => MonBadge(
              value: panier.itemCount.toString(),
              child:
                  ch!, // le point d'exclamation certifie à dart qu'on sait que ch peut être null
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(PanierScreen.routeName);
              },
              //color: Colors.white,
            ),
          ),
        ],
      ),
      //Menu hamburger
      drawer: const MainDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView(
              padding: const EdgeInsets.all(25),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children: lesProduits
                  .map<Widget>(
                    (prodData) => ChangeNotifierProvider.value(
                      value: prodData,
                      child: const ProduitItem(),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

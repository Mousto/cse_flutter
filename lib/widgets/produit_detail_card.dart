import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/produit.dart';
import '../providers/panier_provider.dart';
import 'badge.dart';

// ignore: use_key_in_widget_constructors
class ProduitDetailCard extends StatelessWidget {
  static const IconData euroSymbol =
      IconData(0xe23c, fontFamily: 'MaterialIcons');
  static const IconData enStock = IconData(0xf5ae, fontFamily: 'MaterialIcons');
  static const IconData enRupture =
      IconData(0xf0788, fontFamily: 'MaterialIcons');
  static const IconData localisation =
      IconData(0xe3ab, fontFamily: 'MaterialIcons');

  const ProduitDetailCard({super.key});

//Produit disponible ou pas
  String getDispo(bool dispo) {
    var res = '';
    switch (dispo) {
      case true:
        res = 'Disponible';
        break;
      case false:
        res = 'En rupture';
        break;
      default:
        res = '';
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final leProduit = Provider.of<Produit>(context);
    final lePanier = Provider.of<PanierProvider>(context);

    return InkWell(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            GridTileBar(
              backgroundColor: Colors.black54,
              leading: IconButton(
                icon: Icon(leProduit.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  leProduit.toggleIsFavorite();
                },
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                leProduit.nom,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
              trailing: Consumer(
                builder: (_, value, ch) => Badge(
                  value: lePanier.itemCountByName(leProduit.nom).toString(),
                  child: ch!,
                ),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    lePanier.addItem(
                      leProduit.id,
                      leProduit.prixAdulte,
                      leProduit.prixEnfant,
                      leProduit.nom,
                      leProduit.billetAdulte,
                      leProduit.billetEnfant,
                      leProduit.sommeTotale,
                    );
                  },

                  // ignore: deprecated_member_use
                  color: Colors.white,
                ),
              ),
            ),
            //Stack est un widget qui permet la supperposition d'??l??ment
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    'http://192.168.1.48:8000${leProduit.photo}',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                //Il y'avait un widget ici Posiotioned() et ses attribut au besoin voir la doc pour l'utilisation du widget Stack()
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: [
                      const Text(
                        'Prix Adulte :',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Icon(
                          //Icons.schedule,
                          euroSymbol),
                      Text(
                        '${leProduit.prixAdulte}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Prix Enfant :',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Icon(
                          //Icons.schedule,
                          euroSymbol),
                      Text(
                        '${leProduit.prixEnfant}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Stock :',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      getDispo(leProduit.disponible) == 'En rupture'
                          ? const Icon(
                              semanticLabel:
                                  'Icone de disponibilit?? ou non de stock de cet article',
                              enRupture)
                          : const Icon(
                              semanticLabel:
                                  'Icone de disponibilit?? ou non de stock de cet article',
                              enStock),
                      Text(
                        getDispo(leProduit.disponible),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Lieu Retrait : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                          //Icons.schedule,
                          localisation),
                      Text(
                        'Talant/Valmy',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

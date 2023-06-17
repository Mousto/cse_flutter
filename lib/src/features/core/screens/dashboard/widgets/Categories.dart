import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/commande_provider.dart';
import '../../../../../constants/colors.dart';
import '../../../models/dashboard/categories_model.dart';
import '../../commande_produits/panier_produits.dart';

class Categories extends StatefulWidget {
  const Categories({
    super.key,
    required this.txtTheme,
  });

  final TextTheme txtTheme;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<CommandeProvider>(context, listen: false)
          .fetchAndSetCommandes();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final list = DashboardCategories.list;
    final lesCommandes = Provider.of<CommandeProvider>(context);

    return SizedBox(
      height: 45,
      child: ListView.builder(
        itemCount: lesCommandes.paniers.length,
        shrinkWrap: true, //permet de ne charger que les éléments visibles.
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, int index) => Container(
          margin: const EdgeInsets.only(right: 15),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(width: 4),
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Get.to(
                () => const PanierProduitScreen(),
                arguments: lesCommandes.paniers[index],
              ); //pas besoin de context avec Getx pour la navigation
              print('Vers Panier ${index + 1}');
            }, //list[index].onPress,
            child: SizedBox(
              width: 170,
              height: 45,
              child: Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: tDarkColor,
                    ),
                    child: Center(
                      child: Text('${index + 1}', //list[index].title,
                          style: widget.txtTheme.titleSmall
                              ?.apply(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Flexible(
                    //Flexible pour permettre de rajouter la propiété overflow aux textes du Column
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Panier ${index + 1}',
                          //list[index].heading,
                          style: widget.txtTheme.titleMedium?.apply(
                            color: Colors.black,
                          ),
                          overflow: TextOverflow
                              .ellipsis, //Permet de rajouter des pointillets à la fin des textes longs pour eviter de faire crasher l'app.
                        ),
                        Text(
                          lesCommandes.paniers[index].commandes.length == 1
                              ? '${lesCommandes.paniers[index].commandes.length} Produit'
                              : '${lesCommandes.paniers[index].commandes.length} Produits',
                          //list[index].subHeading,
                          style: widget.txtTheme.bodyMedium
                              ?.apply(color: tSudLinda),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../providers/produits_provider.dart';
import '../widgets/user_product_item.dart';
import '../screens/edit_product_screen.dart';
import '../providers/produit.dart';

class UserProductsScreen extends StatelessWidget {
  static const String routeName = '/user_products';
  const UserProductsScreen({super.key});

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<ProduitsProvider>(context, listen: false)
        .fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProduitsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des produits'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      drawer: const MainDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, index) => Column(children: [
              ChangeNotifierProvider.value(
                value: ProduitProvider(
                  id: productsData.items[index].id,
                  nom: productsData.items[index].nom,
                  photo: productsData.items[index].photo,
                  prixAdulte: productsData.items[index].prixAdulte,
                  prixEnfant: productsData.items[index].prixEnfant,
                  billetAdulte: productsData.items[index].billetAdulte,
                  billetEnfant: productsData.items[index].billetEnfant,
                  disponible: productsData.items[index].disponible,
                ),
                child: UserProductItem(
                  id: productsData.items[index].id,
                  title: productsData.items[index].nom,
                  imageUrl: productsData.items[index].photo,
                  prixAdulte: productsData.items[index].prixAdulte,
                  prixEnfant: productsData.items[index].prixEnfant,
                  disponible: productsData.items[index].disponible,
                ),
              ),
              const Divider(color: Colors.grey),
            ]),
          ),
        ),
      ),
    );
  }
}

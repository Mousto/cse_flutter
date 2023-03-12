import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/produit_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/home_screen.dart';
import 'screens/user_products_screen.dart';
import './screens/panier_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/commandes_screen.dart';
import './providers/produits_provider.dart';
import './providers/panier_provider.dart';
import './providers/commande_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //create: (context) => ProduitsProvider(),
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProduitsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PanierProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CommandeProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'CSE_TALANT_VALMY',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          //colorScheme: ThemeData().colorScheme.copyWith(secondary: Colors.amber),
          //canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyLarge: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyMedium: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                titleLarge: const TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        //home: const ProduitScreen(),
        initialRoute: '/', // default is '/'
        routes: {
          // '/': (ctx) => const ProduitScreen(),
          //'/': (ctx) => const TabsScreen(),
          '/': (ctx) => const HomeScreen(),
          '/produit-detail-screen': ((context) => const ProduitDetailScreen()),
          UserProductsScreen.routeName: ((context) =>
              const UserProductsScreen()),
          PanierScreen.routeName: ((context) => const PanierScreen()),
          EditProductScreen.routeName: ((context) => const EditProductScreen()),
          TabsScreen.routeName: ((context) => const TabsScreen()),
          CommandesScreen.routeName: ((context) => const CommandesScreen()),
        },
      ),
    );
  }
}

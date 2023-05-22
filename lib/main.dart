import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Je fais un as riverpod car il ya clash avec le package provider concernant la class ChangeNotifierProvider dans la méthode build ci-dessou
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/produit_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/home_screen.dart';
import 'screens/user_products_screen.dart';
import './screens/panier_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/commandes_screen.dart';
import './screens/doleances_screen.dart';
import './providers/produits_provider.dart';
import './providers/panier_provider.dart';
import './providers/commande_provider.dart';

void main() {
  //ProviderScope permet de rendre disponible riverpod et les providers qu'on crée disponible dans notre app
  runApp(
    const riverpod.ProviderScope(
      child: MyApp(),
    ),
  );
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
        //Internationnalisation de l'app avec les 2 propriétés suivantes
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        supportedLocales: const [Locale('en'), Locale('fr')],

        title: 'CSE_TALANT_VALMY',
        theme: ThemeData(
          primarySwatch: Colors.purple,
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
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange),
          // colorScheme: ColorScheme.fromSeed(
          //   brightness: Brightness.dark,
          //   seedColor: const Color.fromARGB(255, 131, 57, 0),
          // ),
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
          DoleancesScreen.routeName: ((context) => const DoleancesScreen()),
        },
      ),
    );
  }
}

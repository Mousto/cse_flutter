import 'package:cse_talant_valmy/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      child: GetMaterialApp(
        //GetMaterialApp au lieu de MaterialApp est nécessaire ici à cause de l'utilisation de la navigation Getx entre autre.

        //Internationnalisation de l'app avec les 2 propriétés suivantes
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        supportedLocales: const [Locale('en'), Locale('fr')],

        title: 'CSE_TALANT_VALMY',
        defaultTransition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(microseconds: 500),
        debugShowCheckedModeBanner: false,
        theme: MonAppTheme.ligthTheme, //représente le ligth mode.
        darkTheme: MonAppTheme
            .darkTheme, //Sinon par defaut: ThemeData(brightness: Brightness.dark),
        themeMode: ThemeMode.system, //options: ligth, dark, system.
        //home: const ProduitScreen(),

        initialRoute: '/', // default is '/'
        routes: {
          // '/': (ctx) => const ProduitScreen(),
          //'/': (ctx) => const TabsScreen(),
          '/': (ctx) => const HomeScreen(),
          //'/': (ctx) => const SignUpScreen(),
          //'/welcome': ((context) => const WelcomeScreen()),
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

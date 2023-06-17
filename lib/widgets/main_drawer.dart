import 'package:cse_talant_valmy/src/constants/image_string.dart';
import 'package:flutter/material.dart';

import '../screens/tabs_screen.dart';
import '../screens/user_products_screen.dart';
import '../screens/commandes_screen.dart';
import '../screens/doleances_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Salut collègue !'),
            automaticallyImplyLeading:
                false, //permets de pas ajouter de btn retour
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('commandes'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CommandesScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Gestion produits'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.question_mark),
            title: const Text('Mes questions'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(DoleancesScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Image(
              image: AssetImage(tTicket),
              width: 24,
              height: 24,
            ), //const Icon(Icons.online_prediction_sharp),
            title: const Text('Billeterie'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
            },
          ),
          /* Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Navigation',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ), */
          /* const SizedBox(
            height: 20,
          ),
          buildListTile('Billeterie', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Espace réservé', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }), */
        ],
      ),
    );
  }
}

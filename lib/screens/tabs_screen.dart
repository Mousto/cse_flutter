import 'package:flutter/material.dart';

import 'produit_screen.dart';
import 'commandes_screen.dart';
//import './home_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tab_screen';
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pages = [
    //{'page': const HomeScreen(), 'title': 'Accueil'},
    {'page': const ProduitScreen(), 'title': 'Produits en billeterie'},
    {'page': const CommandesScreen(), 'title': 'Vos commandes'},
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Les produits',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              IconData(
                0xee93,
                fontFamily: 'MaterialIcons',
              ),
            ),
            label: 'Vos commandes',
          ),
        ],
      ),
    );
  }
}

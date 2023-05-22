import 'package:cse_talant_valmy/screens/add_doleance.dart';
import 'package:flutter/material.dart';

import '../widgets/doleances_list.dart';
import '../widgets/main_drawer.dart';

class DoleancesScreen extends StatelessWidget {
  const DoleancesScreen({super.key});
  //route
  static const routeName = '/doleances';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tes Doléances'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddDoleanceScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: DoleancesList(
        doleances: [],
      ),
    );
  }
}

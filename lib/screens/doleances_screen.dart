import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/add_doleance.dart';
import '../widgets/doleances_list.dart';
import '../widgets/main_drawer.dart';
import '../providers/user_doleances_provider.dart';

class DoleancesScreen extends ConsumerWidget {
  const DoleancesScreen({super.key});
  //route
  static const routeName = '/doleances';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDoleances = ref.watch(userDoleancesProviderNotifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tes questions aux élu(e)s'),
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
        doleances: userDoleances,
      ),
    );
  }
}

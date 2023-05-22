import 'package:flutter/material.dart';

import '../models/doleance.dart';

class DoleancesList extends StatelessWidget {
  const DoleancesList({super.key, required this.doleances});

  final List<Doleance> doleances;

  @override
  Widget build(BuildContext context) {
    if (doleances.isEmpty) {
      return const Center(
        child: Text("Tu n'as aucune question en cours"),
      );
    }
    return ListView.builder(
      itemCount: doleances.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(
          doleances[index].titre,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}

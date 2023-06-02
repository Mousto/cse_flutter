import 'package:cse_talant_valmy/screens/doleance_detail_screen.dart';
import 'package:flutter/material.dart';

import '../models/doleance.dart';

class DoleancesList extends StatefulWidget {
  const DoleancesList({super.key, required this.doleances});

  final List<Doleance> doleances;

  @override
  State<DoleancesList> createState() => _DoleancesListState();
}

class _DoleancesListState extends State<DoleancesList> {
  void _removeDoleance(Doleance item) {
    setState(() {
      widget.doleances.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.doleances.isEmpty) {
      return const Center(
        child: Text("Tu n'as aucune question en cours"),
      );
    }
    return ListView.builder(
      itemCount: widget.doleances.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(widget.doleances[index].id),
        onDismissed: (direction) {
          _removeDoleance(widget.doleances[index]);
        },
        child: ListTile(
          title: Text(
            widget.doleances[index].objet,
            // style: Theme.of(context)
            //     .textTheme
            //     .titleMedium!
            //     .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          onTap: () {
            //Charger un autre écran
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DoleanceDetailScreen(
                  doleance: widget.doleances[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

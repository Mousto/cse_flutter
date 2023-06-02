import 'package:flutter/material.dart';

import '../models/doleance.dart';

class DoleanceDetailScreen extends StatelessWidget {
  final Doleance doleance;

  const DoleanceDetailScreen({super.key, required this.doleance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doleance.objet),
      ),
      body: Center(
        child: Text('${doleance.contenu} pour ${doleance.recepteur}'),
      ),
    );
  }
}

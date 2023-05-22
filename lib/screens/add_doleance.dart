import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user_doleances_provider.dart';

//ConsumerStatefulWidget permet d'acceder à riverpod et aux providers par conséquant
class AddDoleanceScreen extends ConsumerStatefulWidget {
  const AddDoleanceScreen({super.key});

  //Et donc createState retourne ConsumerState en lieu et place de State
  @override
  ConsumerState<AddDoleanceScreen> createState() {
    return _AddDoleanceScreenState();
  }
}

//conséquance de l'utilisation de ConsumerStatefulWidget on utilise ConsumerState en lieu et place de State
class _AddDoleanceScreenState extends ConsumerState<AddDoleanceScreen> {
  final _titreController = TextEditingController();

  void _saveDoleance() {
    final textSaisi = _titreController.text;

    if (textSaisi.isEmpty) {
      return;
    }
  }

  @override
  void dispose() {
    _titreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une question'),
      ),
      //SingleChildScrollView permet de s'assurer que quelque soit la longueur du contenu ou l'orientation du device et sa taille, ce dernier sera visible par scroll
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        //on peut utiliser ici un formulaire dans la suite...
        child: Column(
          //...On utilise pour l'instant un champ de saisi text
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Titre',
              ),
              controller: _titreController,
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              label: const Text('Ajouter une question'),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

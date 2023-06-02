import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

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
  final _formKey = GlobalKey<FormState>();
  final _objetController = TextEditingController();
  final _questionController = TextEditingController();

  var _enteredObjet = '';
  var _enteredQuestion = '';

  var _selectedElu = '';
  final Map<int, String> elus = {
    1: 'Diallo Linda',
    2: 'Recouvrot Martine',
    3: 'Grojean Letitia',
    4: 'Fruito orangeade',
  };

  void _saveDoleance() {
    //Permet d'exécuter les conditions de validation du formulaire via la propriété validator des TextFormFields.
    //_formKey.currentState!.validate() retourne true si le form est correct
    if (_formKey.currentState!.validate()) {
      //L'appel de la fonction save ci-dessous exécute les callback function onSaved situés dans les TextFormFileds permettant de récupérer les valeurs pour _enteredObjet et _enteredQuestion.
      _formKey.currentState!.save();
      ref
          .read(userDoleancesProviderNotifier.notifier)
          .addDoleance(_enteredObjet, _enteredQuestion, _selectedElu);
      Navigator.of(context).pop(); //On quitte l'écran actuel pour le précédent
    }
  }

  @override
  void dispose() {
    _objetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter Une Question'),
      ),
      //SingleChildScrollView permet de s'assurer que quelque soit la longueur du contenu ou l'orientation du device et sa taille, ce dernier sera visible par scroll
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        //on peut utiliser ici un formulaire dans la suite...
        child: Form(
          key: _formKey,
          child: Column(
            //...On utilise pour l'instant un champ de saisi text
            children: [
              //TextFormField au lieu de TextField pour le Widget Form
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  labelText: 'Objet de la question',
                ),
                controller: _objetController,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Doit être entre 1 et 50 caractères.';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _enteredObjet = newValue!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                maxLength: 300,
                controller: _questionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Saisir la question 😏.';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _enteredQuestion = newValue!;
                },
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "Saisir la question",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.purple),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Sélectionner un destinataire',
                ),
                items: [
                  for (final elu in elus.entries)
                    DropdownMenuItem(
                      value: elu.value,
                      child: Row(children: [
                        Container(
                          width: 16,
                          height: 16,
                          color: Colors.primaries[
                              //Couleur par randomisation avec la package math importé
                              Random().nextInt(Colors.primaries.length)],
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          elu.value,
                        )
                      ]),
                    ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedElu = value!;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: const Text('Réinitialiser le formulaire'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _saveDoleance,
                    label: const Text('Ajouter une question'),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

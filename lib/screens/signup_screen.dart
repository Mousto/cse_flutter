import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import '../screens/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _telController = TextEditingController();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  final _pwdConfirmController = TextEditingController();

  final _civiliteFocusNode = FocusNode();
  final _nomFocusNode = FocusNode();
  final _prenomFocusNode = FocusNode();
  final _telFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _pwdFocusNode = FocusNode();
  final _pwdConfirmFocusNode = FocusNode();
  final _cliniqueFocusNode = FocusNode();
  final _serviceFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    _telController.dispose();
    _emailController.dispose();
    _pwdController.dispose();
    _pwdConfirmController.dispose();
  }

  var _enteredNom = '';
  var _enteredPrenom = '';
  var _enteredTel = '';
  var _enteredEmail = '';
  var _enteredPwd = '';
  var _enteredPwdConfirm = '';

  var _selectedClinique = '';
  var _selectedService = '';
  var _selectedCivilite = '';
  final Map<int, String> _cliniques = {
    1: 'Clinique Talant',
    2: 'SSR Valmy',
  };
  final Map<int, String> _civilites = {
    1: 'Madame',
    2: 'Monsieur',
  };
  final Map<int, String> _services = {
    1: 'Pneumo',
    2: 'Cardio',
    3: 'Urologie',
    4: 'Gériatrie',
    5: 'Soins intensifs',
  };

  void _saveUser() {
    //Permet d'exécuter les conditions de validation du formulaire via la propriété validator des TextFormFields.
    //_formKey.currentState!.validate() retourne true si le form est correct

    if (_formKey.currentState!.validate()) {
      //L'appel de la fonction save ci-dessous exécute les callback function onSaved situés dans les TextFormFileds permettant de récupérer les valeurs pour _enteredObjet et _enteredQuestion.

      _formKey.currentState!.save();
      print(_selectedCivilite);
      print(_enteredNom);
      print(_enteredPrenom);
      print(_enteredTel);
      print(_enteredEmail);
      print(_enteredPwd);
      print(_enteredPwdConfirm);
      print(_selectedClinique);
      print(_selectedService);
      // ref
      //     .read(userDoleancesProviderNotifier.notifier)
      //     .addDoleance(_enteredObjet, _enteredQuestion, _selectedElu);
      //Navigator.of(context).pop(); //On quitte l'écran actuel pour le précédent
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/welcome_screen/bienvenu.jpg',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text('Embarque à bord.'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text('Crée ton compte et rejoins nous.'),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Form(
                      key: _formKey, //Pour la validation du formulaire
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField(
                            focusNode: _civiliteFocusNode,
                            decoration: const InputDecoration(
                              labelText: 'Civilité',
                            ),
                            items: [
                              for (final civilite in _civilites.entries)
                                DropdownMenuItem(
                                  value: civilite.value,
                                  child: Row(children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      color: Colors.primaries[
                                          //Couleur par randomisation avec la package math importé
                                          Random().nextInt(
                                              Colors.primaries.length)],
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      civilite.value,
                                    )
                                  ]),
                                ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedCivilite = value!;
                              });
                            },
                            onSaved: (newValue) {
                              _selectedCivilite = newValue!;
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length <= 1) {
                                return 'Saisir la civilité.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            focusNode: _nomFocusNode,
                            controller: _nomController,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length <= 1) {
                                return 'Saisir un nom.';
                              }
                              return null;
                            },
                            //Fonction de Exécutée après l'appel de save() dans _formKey.currentState!.save(); pour initialiser les variables définies ci-dessus.
                            onSaved: (newValue) {
                              _enteredNom = newValue!;
                            },
                            decoration: const InputDecoration(
                              label: Text('Nom'),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.person_outline_rounded,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            focusNode: _prenomFocusNode,
                            controller: _prenomController,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length <= 1) {
                                return 'Saisir un Prénom.';
                              }
                              return null;
                            },
                            //Fonction de Exécutée après l'appel de save() dans _formKey.currentState!.save(); pour initialiser les variables définies ci-dessus.
                            onSaved: (newValue) {
                              _enteredPrenom = newValue!;
                            },
                            decoration: const InputDecoration(
                              label: Text('Prénom'),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.person_outline_rounded,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            focusNode: _telFocusNode,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            controller: _telController,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length <= 1) {
                                return 'Saisir un numéro de téléphone.';
                              }
                              return null;
                            },
                            //Fonction de Exécutée après l'appel de save() dans _formKey.currentState!.save(); pour initialiser les variables définies ci-dessus.
                            onSaved: (newValue) {
                              _enteredTel = newValue!;
                            },
                            decoration: const InputDecoration(
                              label: Text('Téléphone'),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.phone_outlined,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            focusNode: _emailFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Saisir un Email.';
                              }
                              return null;
                            },
                            //Fonction de Exécutée après l'appel de save() dans _formKey.currentState!.save(); pour initialiser les variables définies ci-dessus.
                            onSaved: (newValue) {
                              _enteredEmail = newValue!;
                            },
                            decoration: const InputDecoration(
                              label: Text('Email'),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            focusNode: _pwdFocusNode,
                            controller: _pwdController,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length <= 1) {
                                return 'Saisir un mot de passe valide.';
                              }
                              return null;
                            },
                            //Fonction de onSaved Exécutée après l'appel de save() dans _formKey.currentState!.save(); pour initialiser les variables définies ci-dessus.
                            onSaved: (newValue) {
                              _enteredPwd = newValue!;
                            },
                            decoration: const InputDecoration(
                              label: Text('Mot De Passe'),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            focusNode: _pwdConfirmFocusNode,
                            controller: _pwdConfirmController,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length <= 1) {
                                return 'Ne correspond pas au mot de passe.';
                              }
                              return null;
                            },
                            //Fonction de onSaved Exécutée après l'appel de save() dans _formKey.currentState!.save(); pour initialiser les variables définies ci-dessus.
                            onSaved: (newValue) {
                              _enteredPwdConfirm = newValue!;
                            },
                            decoration: const InputDecoration(
                              label: Text('Confirmation Passe'),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.password_outlined,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField(
                                  focusNode: _cliniqueFocusNode,
                                  decoration: const InputDecoration(
                                    labelText: 'Ta Clinique',
                                  ),
                                  items: [
                                    for (final clinique in _cliniques.entries)
                                      DropdownMenuItem(
                                        value: clinique.value,
                                        child: Row(children: [
                                          Container(
                                            width: 16,
                                            height: 16,
                                            color: Colors.primaries[
                                                //Couleur par randomisation avec la package math importé
                                                Random().nextInt(
                                                    Colors.primaries.length)],
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            clinique.value,
                                          )
                                        ]),
                                      ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedClinique = value!;
                                    });
                                  },
                                  onSaved: (newValue) {
                                    _selectedClinique = newValue!;
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().length <= 1) {
                                      return 'Sélectionner la clinique.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField(
                                  focusNode: _serviceFocusNode,
                                  decoration: const InputDecoration(
                                    labelText: 'Ton Service',
                                  ),
                                  items: [
                                    for (final service in _services.entries)
                                      DropdownMenuItem(
                                        value: service.value,
                                        child: Row(children: [
                                          Container(
                                            width: 16,
                                            height: 16,
                                            color: Colors.primaries[
                                                //Couleur par randomisation avec la package math importé
                                                Random().nextInt(
                                                    Colors.primaries.length)],
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            service.value,
                                          )
                                        ]),
                                      ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedService = value!;
                                    });
                                  },
                                  onSaved: (newValue) {
                                    _selectedService = newValue!;
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().length <= 1) {
                                      return 'Sélectionner le service.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                _formKey.currentState!.reset();
                              },
                              child: Text(
                                  'Réinitialiser le formulaire'.toUpperCase()),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _saveUser,
                              label: Text('Je vous rejoins'.toUpperCase()),
                              icon: const Icon(Icons.approval),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              },
                              child: Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text: "Vous avez un compte ?".toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  TextSpan(
                                    text: " Se connecter".toUpperCase(),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
//import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert'; //besoin de cet import pour la méthode jsonDecode().

import '../providers/produit.dart';
import '../providers/produits_provider.dart';

enum ImageSourceType { gallery, camera }

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  //Le focus
  //final _imageUrlFocusNode = FocusNode();

  //L'utilisation de FocusNode() impose de les détruire quant on quitte l'écran concerné au risque de retenir les objets en mémoire d'où la methode dispose() ci-dessous
  final _prixAdulteFocusNode = FocusNode();
  final _prixEnfantFocusNode = FocusNode();

  //Utilisation d'un GlobalKey pour accéder aux données du formulaire``
  final _form = GlobalKey<FormState>();
  //On créer artificiellement une instance de produit vide dans l'optique de la remplacer par des valeurs concrète saisies dans le formulaire car les champs de la class Produit sont finaux(une fois le produit créer on ne peux le modifier). Le procédé s'effectue dans chaque champ du formulaire
  var _editedProduct = Produit(
    id: 0,
    nom: '',
    prixAdulte: 0,
    prixEnfant: 0,
    photo: '',
    disponible: false,
  );

  var _initValues = {
    'id': 0,
    'nom': '',
    'prix_adulte': '',
    'prix_enfant': '',
    'photo': ''
  };

  //titrePage
  var titrePage = '';
  //Pour la roue du chargement
  var _isLoading = false;

  //Variable temoin pour ne pas executer plusieures fois le code situé dans la fonction didChangeDependencies() qui est appélée plusieures fois avec la build méthode
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      //Récupération de l'id renvoyé dans la méthode pushNamed() de l'icone edit du widget UserProductItem. ModalRoute.of(context) ne marchant pas dans la méthode initState(), on utilise didChangeDependencies().

      if (ModalRoute.of(context)!.settings.arguments != null) {
        titrePage = 'Modification Produit';
        final productId = ModalRoute.of(context)?.settings.arguments as int;

        //On récupère le produit concerné dans la liste de produit.
        _editedProduct = Provider.of<ProduitsProvider>(context, listen: false)
            .findById(productId);

        //Valeures initiales des champs de saisie du formulaire de Ajout/modification. En locurrence ici la modification
        _initValues = {
          'nom': _editedProduct.nom,
          'prix_adulte': _editedProduct.prixAdulte.toString(),
          'prix_enfant': _editedProduct.prixEnfant.toString(),
          'photo': _editedProduct.photo,
          //'photo': ''
        };
        //l'initialisation du champ de formulaire image se fera donc ici
        //_imageUrlController.text = _editedProduct.photo;
      } else {
        titrePage = 'Ajout Produit';
      }
    }
    //_isInit à false pour ne plus executer le code ci-dessus.
    _isInit = false;
    super.didChangeDependencies();
  }

  // @override
  // void initState() {
  //   _imageUrlFocusNode.addListener(_updateImageUrl);
  //   super.initState();
  // }

  @override
  void dispose() {
    //_imageUrlFocusNode.removeListener(_updateImageUrl);
    _prixAdulteFocusNode.dispose();
    _prixEnfantFocusNode.dispose();

    super.dispose();
  }

  //Enregistrement du formulaire
  Future<void> _saveForm() async {
    //isValidForm contient le boolean résultat de tous les validators des champs du formulaire. s'ils sont tous ok sa valeur est true sinon false.
    final isValidForm = _form.currentState!.validate(); // ! == null check
    if (!isValidForm) {
      return;
    }
    //Avec _form on peut accéder au state du formulaire et l'enregister
    _form.currentState?.save();
    // setState(() {
    //   _isLoading = true;
    // });
    if (_editedProduct.id != 0) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProduitsProvider>(context, listen: false)
          .updateProduit(_editedProduct.id, _editedProduct);
      // setState(() {
      //   _isLoading = false;
      // });
      // //retourne à la page précédente
      // Navigator.of(context).pop();
    } else {
      setState(() {
        _isLoading = true;
      });
      //await ici car addProduit retourne un Future qu'il faut attendre on ne stock pas ici le retour dans une variable car le retour est Future<void>
      try {
        await Provider.of<ProduitsProvider>(context, listen: false)
            .addProduit(_editedProduct, file);
      } catch (error) {
        //Encore await car showDialog retourne par defaut un Future qui sera resolu dès que le user clic le bouton OK
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Une erreur est advenue !'),
            content: const Text('Veuillez réessayer plus tard.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('OK'))
            ],
          ),
        );
      }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   //retourne à la page précédente
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = false;
    });
    //retourne à la page précédente
    Navigator.of(context).pop();
  }

  String? imagePath; //Chemin du fichier Image
  late File file;
  Future<void> getImage(String originePhoto) async {
    final ImagePicker picker = ImagePicker();
    var origine = originePhoto;
    late ImageSource sourceImage;
    //var origin = ImageSource.gallery;
    if (origine == 'caméra') {
      sourceImage = ImageSource.camera;
    }
    if (origine == 'galérie') {
      sourceImage = ImageSource.gallery;
    }
    // Pick an image
    final XFile? image = await picker.pickImage(
        source: sourceImage,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);
    if (image != null) {
      imagePath = image.path;
      //print(imagePath);
      //TO convert Xfile into file
      file = File(image.path);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titrePage),
        actions: <Widget>[
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                //Avec cette key(GlobalKey instanciée plus haut, on peut interagir avec le state gérer par le form widget)
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      //controller: _nomController,

                      //On peut introduire la propriété initialValue en se servant de la variable Map _initValues initiée plus haut.
                      initialValue: _initValues['nom'].toString(),
                      decoration:
                          const InputDecoration(labelText: 'Nom produit'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_prixAdulteFocusNode);
                      },
                      //onSaved est appeler et fourni en param la valeur saisie du champ
                      onSaved: (newValue) {
                        _editedProduct = Produit(
                          id: _editedProduct.id,
                          nom: newValue.toString(),
                          prixAdulte: _editedProduct.prixAdulte,
                          prixEnfant: _editedProduct.prixEnfant,
                          photo: _editedProduct.photo,
                          isFavorite: _editedProduct.isFavorite,
                          disponible: _editedProduct.disponible,
                        );
                      },
                      validator: (value) {
                        //validator prend une fonction qui retourne null si notre logique implémenté est bonne sinon on retourne un String qui sera utilisé dans le message d'erreur à renvoyer au user. ici on va dire que la logique consiste simplement à vérifier que le champ n'est pa vide.
                        if (value!.isEmpty) {
                          return 'Saisir un nom.';
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                            color: Colors.grey.shade900,
                          ),
                          child: imagePath ==
                                  null //_imageUrlController.text.isEmpty
                              ? const Text(
                                  "Prévisuliser ici l'image sélectionnée.",
                                  style: TextStyle(color: Colors.white),
                                )
                              : FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.file(
                                    File(imagePath!),
                                    //fit: BoxFit.cover,
                                  ),
                                  // Image.network(
                                  //   _imageUrlController.text,
                                  //   fit: BoxFit.fill,
                                  // ),
                                ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  shadowColor: Colors.grey[800],
                                ),
                                onPressed: () {
                                  //print('Sélectionner dans la galérie photo');
                                  getImage('galérie');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(Icons.image),
                                    Text(
                                      'Sélectionner Photo',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  shadowColor: Colors.grey[800],
                                ),
                                onPressed: () {
                                  //print('Prendre une photo');
                                  getImage('caméra');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(Icons.camera_alt),
                                    Text(
                                      'Prendre une Photo',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      //controller: _prixAdulteController,

                      //On peut introduire la propriété initialValue en se servant de la variable Map _initValues initiée plus haut.
                      initialValue: _initValues['prix_adulte'].toString(),
                      decoration: const InputDecoration(
                          labelText: 'Prix billet adulte'),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: _prixAdulteFocusNode,
                      //onFieldSubmitted attend une fonction avec un param String. On en a pas avec _saveForm() on remplace donc le param fourni par onFieldSubmitted par (_) car ici nous n'en avons pas besoin et on utilise un callback pour exécuter _saveForm() à la soumission du form par appuie du btn OK.
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      //onSaved est appeler et fourni en param la valeur saisie du champ
                      onSaved: (newValue) {
                        _editedProduct = Produit(
                          id: _editedProduct.id,
                          nom: _editedProduct.nom,
                          prixAdulte: double.parse(newValue!),
                          prixEnfant: _editedProduct.prixEnfant,
                          photo: _editedProduct.photo,
                          isFavorite: _editedProduct.isFavorite,
                          disponible: _editedProduct.disponible,
                        );
                      },
                      validator: (value) {
                        //validator prend une fonction qui retourne null si notre logique implémenté est bonne sinon on retourne un String qui sera utilisé dans le message d'erreur à renvoyer au user. ici on va dire que la logique consiste simplement à vérifier que le champ n'est pas vide.
                        if (value!.isEmpty) {
                          return 'Saisir un prix.';
                        }
                        if (double.tryParse(value) == null) {
                          // tryParse() est comme parse() à l'exception qu'elle retourne null si la saisie n'est pas valide au lieu de retourner une exception comme le fait parse()
                          return 'Saisir un nombre valide.';
                        }
                        if (double.parse(value) <= 0) {
                          //ici on peut utiliser parse() car la condition précédente est remplie et nous avons un nombre.
                          return 'Saisir une valeur supérieure à zéro.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      //controller: _prixEnfantController,

                      //On peut introduire la propriété initialValue en se servant de la variable Map _initValues initiée plus haut.
                      initialValue: _initValues['prix_enfant'].toString(),
                      decoration: const InputDecoration(
                          labelText: 'Prix billet enfant'),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction
                          .done, //.done permet d'afficher le btn ok  d'envoie formulaire au clavier, une fois dans ce champ.
                      focusNode: _prixEnfantFocusNode,
                      //onFieldSubmitted attend une fonction avec un param String. On en a pas avec _saveForm() on remplace donc le param fourni par onFieldSubmitted par (_) car ici nous n'en avons pas besoin et on utilise un callback pour exécuter _saveForm() à la soumission du form par appuie du btn OK.
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      //onSaved est appeler et fourni en param la valeur saisie du champ
                      onSaved: (newValue) {
                        _editedProduct = Produit(
                          id: _editedProduct.id,
                          nom: _editedProduct.nom,
                          prixEnfant: double.parse(newValue!),
                          prixAdulte: _editedProduct.prixAdulte,
                          photo: _editedProduct.photo,
                          isFavorite: _editedProduct.isFavorite,
                          disponible: _editedProduct.disponible,
                        );
                      },
                      validator: (value) {
                        //validator prend une fonction qui retourne null si notre logique implémenté est bonne sinon on retourne un String qui sera utilisé dans le message d'erreur à renvoyer au user. ici on va dire que la logique consiste simplement à vérifier que le champ n'est pa vide.
                        if (value!.isEmpty) {
                          return 'Saisir un prix.';
                        }
                        if (double.tryParse(value) == null) {
                          // tryParse() est comme parse() à l'exception qu'elle retourne null si la saisie n'est pas valide au lieu de retourner une exception comme le fait parse()
                          return 'Saisir un nombre valide.';
                        }
                        if (double.parse(value) <= 0) {
                          //ici on peut utiliser parse() car la condition précédente est remplie et nous avons un nombre.
                          return 'Saisir une valeur supérieure à zéro.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          _saveForm();
                        },
                        child: const Text(
                          'Enregistrer',
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

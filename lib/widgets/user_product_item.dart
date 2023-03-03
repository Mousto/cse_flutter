import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'dart:io'; // Pour File()
//import 'package:path_provider/path_provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/produits_provider.dart';
import '../providers/produit.dart';

class UserProductItem extends StatefulWidget {
  final int id;
  final String title;
  final String imageUrl;
  final double prixAdulte;
  final double prixEnfant;
  final bool disponible;
  const UserProductItem({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.prixAdulte,
    required this.prixEnfant,
    required this.disponible,
  });

  @override
  State<UserProductItem> createState() => _UserProductItemState();
}

class _UserProductItemState extends State<UserProductItem> {
  var prodDispo;
  var msgDispo;
  //var txtDispo;

  @override
  void initState() {
    msgDispo = 'Produit ${widget.title} marqué indisponible';
    //prodDispo = widget.disponible; //false;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      prodDispo = widget.disponible;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final produit = Provider.of<Produit>(context, listen: false);
    final produitProvider =
        Provider.of<ProduitsProvider>(context, listen: false);
    // print(
    //     '§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§ ${widget.title},${widget.disponible}');

    //On définit cette variable ici car le context de BuildContext ne marche pas dans async où la variable est utilisé. On consigne donc un context dans cette variable ci-dessous
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    //Suppression
    Future<void> deleteProd() async {
      try {
        await produitProvider.deleteProduit(widget.id);
      } catch (error) {
        rethrow;
      }
    }

    return ListTile(
      title: Text(widget.title),
      leading: CircleAvatar(
        backgroundImage:
            NetworkImage('http://192.168.1.48:8000${widget.imageUrl}'),

        //FileImage(File(imageUrl)),
        // AssetImage('assets/images/$imageUrl'),
      ),
      trailing: FittedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          //You should discover that the Row have unlimited width. Therefore you need to //fit it into the available size of a given device.
          // donc ceci : mainAxisSize: MainAxisSize.min, ou wrapper le Row dans un fittedBox par exemple
          children: [
            Consumer<ProduitsProvider>(
              //revoir la partie consumer pour en particulier connaitre le role du 3ieme argument de builder ci-dessous. Il permet succintement de rajouter un child dans le consumer qu'on aimerait ne pas rebuilder.
              builder: (context, produitProvider, _) => IconButton(
                onPressed: () async {
                  try {
                    produit.isDisponible();
                  } catch (error) {
                    print(error);
                  }
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: prodDispo
                          ? Text(
                              msgDispo,
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              msgDispo,
                              textAlign: TextAlign.center,
                            ),
                    ),
                  );
                  setState(() {
                    prodDispo = !prodDispo;
                    if (!prodDispo) {
                      // La phrase contraire est nécéssaire dans ce cas
                      msgDispo = 'Produit ${widget.title} marqué disponible';
                      //txtDispo = 'Indisponible';
                    } else {
                      msgDispo = 'Produit ${widget.title} marqué indisponible';
                      //txtDispo = 'Disponible';
                    }
                  });
                },
                icon: prodDispo
                    ? const Icon(
                        Icons.toggle_on,
                        color: Color.fromARGB(234, 100, 212, 20),
                        size: 40,
                      )
                    : Icon(
                        Icons.toggle_off,
                        color: Theme.of(context).primaryColor,
                        size: 40,
                      ),
              ),
            ),
            //   ],
            // ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName,
                    arguments: widget.id);
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              onPressed: () async {
                try {
                  await deleteProd();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Produit supprimé',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } catch (error) {
                  await showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Une erreur est advenue !'),
                      content: const Text('Suppression non effectuée'),
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
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:uuid/uuid.dart';

// Uuid() étant const, on peut logiquement créer une variable const uuid
const uuid = Uuid();

class Doleance {
  final String id;
  final String objet;
  final String contenu;
  final String recepteur;
  final DateTime dateQuestion;

  Doleance({
    required this.objet,
    required this.contenu,
    required this.recepteur,
    required this.dateQuestion,
  }) : id = uuid.v4();
}

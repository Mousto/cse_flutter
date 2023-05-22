import 'package:uuid/uuid.dart';

// Uuid() étant const, on peut logiquement créer une variable const uuid
const uuid = Uuid();

class Doleance {
  final String id;
  final String titre;

  Doleance({required this.titre}) : id = uuid.v4();
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/doleance.dart';

class UserDoleancesProviderNotifier extends StateNotifier<List<Doleance>> {
  UserDoleancesProviderNotifier() : super(const []);

  void addDoleance(String leTitre) {
    final newDoleance = Doleance(titre: leTitre);
    //state est fourni par la class StateNotifier qui gére ce state qui est const et fourni à super en paramètre. Le param étant une liste const, le nouveau state s'obtient avec une nouvelle liste avec la nouvelle doléance en tête de list et un spread de l'ancienne list ou state
    state = [newDoleance, ...state];
  }

  final userDoleancesProviderNotifier = StateNotifierProvider(
    (ref) => UserDoleancesProviderNotifier(),
  );
}

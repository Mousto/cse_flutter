import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/doleance.dart';

class UserDoleancesProviderNotifier extends StateNotifier<List<Doleance>> {
  UserDoleancesProviderNotifier() : super(const []);

  void addDoleance(String objDemande, String contenu, String recepteur) {
    final newDoleance = Doleance(
      objet: objDemande,
      contenu: contenu,
      dateQuestion: DateTime.now(),
      recepteur: recepteur,
    );
    //state est fourni par la class StateNotifier qui gére ce state qui est const et fourni à super en paramètre. Le param étant une liste const, le nouveau state s'obtient avec une nouvelle liste avec la nouvelle doléance en tête de list et un spread de l'ancienne list ou state
    state = [newDoleance, ...state];
  }
}

final userDoleancesProviderNotifier =
    StateNotifierProvider<UserDoleancesProviderNotifier, List<Doleance>>(
  (ref) => UserDoleancesProviderNotifier(),
);

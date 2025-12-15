import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super({});

  void toggle(String eventId) {
    final copy = {...state};
    if (copy.contains(eventId)) {
      copy.remove(eventId);
    } else {
      copy.add(eventId);
    }
    state = copy;
  }

  bool isFavorite(String id) => state.contains(id);
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) => FavoritesNotifier());

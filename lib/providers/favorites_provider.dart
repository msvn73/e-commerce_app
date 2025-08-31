import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/product.dart';

part 'favorites_provider.g.dart';

@riverpod
class Favorites extends _$Favorites {
  static const String _storageKey = 'favorites';

  @override
  List<Product> build() {
    _loadFavorites();
    return [];
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getStringList(_storageKey) ?? [];
      
      final favorites = favoritesJson
          .map((json) => Product.fromJson(jsonDecode(json)))
          .toList();
      
      state = favorites;
    } catch (e) {
      print('Favoriler yüklenirken hata: $e');
      state = [];
    }
  }

  Future<void> _saveFavorites(List<Product> favorites) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = favorites
          .map((product) => jsonEncode(product.toJson()))
          .toList();
      
      await prefs.setStringList(_storageKey, favoritesJson);
    } catch (e) {
      print('Favoriler kaydedilirken hata: $e');
    }
  }

  void toggleFavorite(Product product) {
    final isFavorite = state.any((p) => p.id == product.id);
    
    if (isFavorite) {
      // Remove from favorites
      state = state.where((p) => p.id != product.id).toList();
    } else {
      // Add to favorites
      state = [...state, product.copyWith(isFavorite: true)];
    }
    
    // Persist to storage
    _saveFavorites(state);
  }

  bool isFavorite(String productId) {
    return state.any((product) => product.id == productId);
  }

  void clearFavorites() {
    state = [];
    _saveFavorites(state);
  }
}

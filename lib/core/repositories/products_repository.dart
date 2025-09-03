import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product_model.dart';
import '../models/category_model.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  return ProductsRepository();
});

class ProductsRepository {
  final SupabaseClient _client = Supabase.instance.client;

  // Get all categories
  Future<List<CategoryModel>> getCategories() async {
    final response = await _client
        .from('categories')
        .select()
        .eq('is_active', true)
        .eq('is_deleted', false)
        .order('sort_order');

    return (response as List)
        .map((json) => CategoryModel.fromJson(json))
        .toList();
  }

  // Get all products
  Future<List<ProductModel>> getProducts({
    String? categoryId,
    String? searchQuery,
  }) async {
    var query = _client
        .from('products')
        .select()
        .eq('is_active', true)
        .eq('is_deleted', false);

    if (categoryId != null) {
      query = query.eq('category_id', categoryId);
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query = query.or('name.ilike.%$searchQuery%,description.ilike.%$searchQuery%');
    }

    final response = await query.order('created_at', ascending: false);

    return (response as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }

  // Get product by ID
  Future<ProductModel?> getProductById(String productId) async {
    try {
      final response = await _client
          .from('products')
          .select()
          .eq('id', productId)
          .eq('is_active', true)
          .eq('is_deleted', false)
          .single();

      return ProductModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  // Get featured products
  Future<List<ProductModel>> getFeaturedProducts({int limit = 10}) async {
    final response = await _client
        .from('products')
        .select()
        .eq('is_active', true)
        .eq('is_deleted', false)
        .order('created_at', ascending: false)
        .limit(limit);

    return (response as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }

  // Get products by category
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    final response = await _client
        .from('products')
        .select()
        .eq('category_id', categoryId)
        .eq('is_active', true)
        .eq('is_deleted', false)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }

  // Search products
  Future<List<ProductModel>> searchProducts(String query) async {
    final response = await _client
        .from('products')
        .select()
        .eq('is_active', true)
        .eq('is_deleted', false)
        .or('name.ilike.%$query%,description.ilike.%$query%')
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }

  // Add product to favorites
  Future<void> addToFavorites(String productId) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    await _client.from('favorites').insert({
      'user_id': user.id,
      'product_id': productId,
    });
  }

  // Remove product from favorites
  Future<void> removeFromFavorites(String productId) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    await _client
        .from('favorites')
        .delete()
        .eq('user_id', user.id)
        .eq('product_id', productId);
  }

  // Get user favorites
  Future<List<ProductModel>> getUserFavorites() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final response = await _client
        .from('favorites')
        .select('''
          product_id,
          products (
            id,
            name,
            description,
            price,
            original_price,
            discount_percent,
            category_id,
            image_urls,
            stock_quantity,
            is_active,
            tags,
            specifications,
            created_at,
            updated_at,
            is_deleted
          )
        ''')
        .eq('user_id', user.id);

    return (response as List)
        .map((json) => ProductModel.fromJson(json['products']))
        .toList();
  }

  // Check if product is in favorites
  Future<bool> isProductInFavorites(String productId) async {
    final user = _client.auth.currentUser;
    if (user == null) return false;

    try {
      await _client
          .from('favorites')
          .select('id')
          .eq('user_id', user.id)
          .eq('product_id', productId)
          .single();

      return true;
    } catch (e) {
      return false;
    }
  }
}
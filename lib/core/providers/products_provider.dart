import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/product_model.dart';
import '../services/demo_service.dart';
import '../../config/app_config.dart';

class ProductsState {
  final List<ProductModel> products;
  final bool isLoading;
  final String? error;

  const ProductsState({
    this.products = const [],
    this.isLoading = false,
    this.error,
  });

  ProductsState copyWith({
    List<ProductModel>? products,
    bool? isLoading,
    String? error,
  }) {
    return ProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ProductsNotifier extends StateNotifier<ProductsState> {
  ProductsNotifier() : super(const ProductsState());

  final SupabaseClient _client = Supabase.instance.client;

  // Load products
  Future<void> loadProducts() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Check if Supabase is properly configured
      if (AppConfig.supabaseUrl.contains('your-project')) {
        // Use demo service
        final products = await DemoService.getProducts();
        state = state.copyWith(
          products: products,
          isLoading: false,
        );
        return;
      }

      final response = await _client
          .from('products')
          .select('''
            *,
            categories (
              id,
              name
            )
          ''')
          .eq('is_deleted', false)
          .eq('is_active', true)
          .order('created_at', ascending: false);

      final products = (response as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();

      state = state.copyWith(
        products: products,
        isLoading: false,
      );
    } catch (e) {
      // Fallback to demo service
      try {
        final products = await DemoService.getProducts();
        state = state.copyWith(
          products: products,
          isLoading: false,
        );
      } catch (demoError) {
        state = state.copyWith(
          isLoading: false,
          error: e.toString(),
        );
      }
    }
  }

  // Add product
  Future<void> addProduct(ProductFormData formData) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Check if Supabase is properly configured
      if (AppConfig.supabaseUrl.contains('your-project')) {
        // Use demo service
        await DemoService.addProduct(formData);
        final updatedProducts = await DemoService.getProducts();
        state = state.copyWith(
          products: updatedProducts,
          isLoading: false,
        );
        return;
      }

      final response = await _client.from('products').insert({
        'name': formData.name,
        'description': formData.description,
        'price': formData.price,
        'stock': formData.stock,
        'category_id': formData.categoryId.isEmpty ? null : formData.categoryId,
        'images': formData.images,
        'videos': formData.videos,
        'is_active': formData.isActive,
        'is_deleted': false,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      }).select('''
            *,
            categories (
              id,
              name
            )
          ''').single();

      final newProduct = ProductModel.fromJson(response);
      state = state.copyWith(
        products: [
          newProduct,
          ...state.products
        ], // Add to beginning for newest first
        isLoading: false,
      );
    } catch (e) {
      // Fallback to demo service
      try {
        await DemoService.addProduct(formData);
        final updatedProducts = await DemoService.getProducts();
        state = state.copyWith(
          products: updatedProducts,
          isLoading: false,
        );
      } catch (demoError) {
        state = state.copyWith(
          isLoading: false,
          error: e.toString(),
        );
        rethrow;
      }
    }
  }

  // Update product
  Future<void> updateProduct(String productId, ProductFormData formData) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _client.from('products').update({
        'name': formData.name,
        'description': formData.description,
        'price': formData.price,
        'stock': formData.stock,
        'category_id': formData.categoryId.isEmpty ? null : formData.categoryId,
        'images': formData.images,
        'videos': formData.videos,
        'is_active': formData.isActive,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', productId);

      final updatedProducts = state.products.map((product) {
        if (product.id == productId) {
          return product.copyWith(
            name: formData.name,
            description: formData.description,
            price: formData.price,
            stock: formData.stock,
            categoryId:
                formData.categoryId.isEmpty ? null : formData.categoryId,
            images: formData.images,
            videos: formData.videos,
            isActive: formData.isActive,
            updatedAt: DateTime.now(),
          );
        }
        return product;
      }).toList();

      state = state.copyWith(
        products: updatedProducts,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Delete product
  Future<void> deleteProduct(String productId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Check if Supabase is properly configured
      if (AppConfig.supabaseUrl.contains('your-project')) {
        // Use demo service
        await DemoService.deleteProduct(productId);
        final updatedProducts = await DemoService.getProducts();
        state = state.copyWith(
          products: updatedProducts,
          isLoading: false,
        );
        return;
      }

      await _client.from('products').update({
        'is_deleted': true,
        'is_active': false,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', productId);

      final updatedProducts =
          state.products.where((product) => product.id != productId).toList();

      state = state.copyWith(
        products: updatedProducts,
        isLoading: false,
      );
    } catch (e) {
      // Fallback to demo service
      try {
        await DemoService.deleteProduct(productId);
        final updatedProducts = await DemoService.getProducts();
        state = state.copyWith(
          products: updatedProducts,
          isLoading: false,
        );
      } catch (demoError) {
        state = state.copyWith(
          isLoading: false,
          error: e.toString(),
        );
      }
    }
  }

  // Get product by ID
  ProductModel? getProductById(String productId) {
    try {
      return state.products.firstWhere((product) => product.id == productId);
    } catch (e) {
      return null;
    }
  }
}

final productsProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  return ProductsNotifier();
});

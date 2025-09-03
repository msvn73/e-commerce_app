import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category_model.dart';
import '../services/demo_service.dart';
import '../../config/app_config.dart';

class CategoriesState {
  final List<CategoryModel> categories;
  final bool isLoading;
  final String? error;

  const CategoriesState({
    this.categories = const [],
    this.isLoading = false,
    this.error,
  });

  CategoriesState copyWith({
    List<CategoryModel>? categories,
    bool? isLoading,
    String? error,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class CategoriesNotifier extends StateNotifier<CategoriesState> {
  CategoriesNotifier() : super(const CategoriesState());

  final SupabaseClient _client = Supabase.instance.client;

  // Load categories
  Future<void> loadCategories() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Check if Supabase is properly configured
      if (AppConfig.supabaseUrl.contains('your-project')) {
        // Use demo service
        final categories = await DemoService.getCategories();
        state = state.copyWith(
          categories: categories,
          isLoading: false,
        );
        return;
      }

      final response = await _client
          .from('categories')
          .select()
          .eq('is_deleted', false)
          .eq('is_active', true)
          .order('created_at', ascending: false);

      final categories = (response as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();

      state = state.copyWith(
        categories: categories,
        isLoading: false,
      );
    } catch (e) {
      // Fallback to demo service
      try {
        final categories = await DemoService.getCategories();
        state = state.copyWith(
          categories: categories,
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

  // Add category
  Future<void> addCategory(CategoryModel category) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Check if Supabase is properly configured
      if (AppConfig.supabaseUrl.contains('your-project')) {
        // Use demo service
        await DemoService.addCategory(category);
        final updatedCategories = await DemoService.getCategories();
        state = state.copyWith(
          categories: updatedCategories,
          isLoading: false,
        );
        return;
      }

      final response = await _client
          .from('categories')
          .insert({
            'name': category.name,
            'description': category.description,
            'icon': category.icon ?? 'category',
            'color': category.color ?? 'FF6B35',
            'is_active': category.isActive,
            'is_deleted': false,
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      final newCategory = CategoryModel.fromJson(response);
      final updatedCategories = [newCategory, ...state.categories];

      state = state.copyWith(
        categories: updatedCategories,
        isLoading: false,
      );
    } catch (e) {
      // Fallback to demo service
      try {
        await DemoService.addCategory(category);
        final updatedCategories = await DemoService.getCategories();
        state = state.copyWith(
          categories: updatedCategories,
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

  // Update category
  Future<void> updateCategory(String categoryId, CategoryModel category) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _client.from('categories').update({
        'name': category.name,
        'description': category.description,
        'icon': category.icon ?? 'category',
        'color': category.color ?? 'FF6B35',
        'is_active': category.isActive,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', categoryId);

      final updatedCategories = state.categories.map((cat) {
        if (cat.id == categoryId) {
          return category.copyWith(
            id: categoryId,
            updatedAt: DateTime.now(),
          );
        }
        return cat;
      }).toList();

      state = state.copyWith(
        categories: updatedCategories,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Delete category
  Future<void> deleteCategory(String categoryId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Check if Supabase is properly configured
      if (AppConfig.supabaseUrl.contains('your-project')) {
        // Use demo service
        await DemoService.deleteCategory(categoryId);
        final updatedCategories = await DemoService.getCategories();
        state = state.copyWith(
          categories: updatedCategories,
          isLoading: false,
        );
        return;
      }

      await _client.from('categories').update({
        'is_deleted': true,
        'is_active': false,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', categoryId);

      final updatedCategories =
          state.categories.where((cat) => cat.id != categoryId).toList();

      state = state.copyWith(
        categories: updatedCategories,
        isLoading: false,
      );
    } catch (e) {
      // Fallback to demo service
      try {
        await DemoService.deleteCategory(categoryId);
        final updatedCategories = await DemoService.getCategories();
        state = state.copyWith(
          categories: updatedCategories,
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

  // Get category by ID
  CategoryModel? getCategoryById(String categoryId) {
    try {
      return state.categories.firstWhere((cat) => cat.id == categoryId);
    } catch (e) {
      return null;
    }
  }
}

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, CategoriesState>((ref) {
  return CategoriesNotifier();
});

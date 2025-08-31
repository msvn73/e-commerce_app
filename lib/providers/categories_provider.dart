import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/category.dart';

part 'categories_provider.g.dart';

@riverpod
class Categories extends _$Categories {
  @override
  List<Category> build() {
    return CategoryData.categories;
  }

  void selectCategory(String categoryId) {
    state = state.map((category) {
      return category.copyWith(isSelected: category.id == categoryId);
    }).toList();
  }

  Category get selectedCategory {
    return state.firstWhere(
      (category) => category.isSelected,
      orElse: () => state.first,
    );
  }

  Category getCategoryById(String id) {
    return state.firstWhere((category) => category.id == id);
  }

  List<Category> get mainCategories {
    return state;
  }
}

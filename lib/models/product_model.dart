import 'package:freezed_annotation/freezed_annotation.dart';
import 'category_model.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    String? description,
    required double price,
    double? originalPrice,
    @Default(0) int discountPercent,
    String? categoryId,
    @Default([]) List<String> imageUrls,
    @Default(0) int stockQuantity,
    @Default(true) bool isActive,
    @Default([]) List<String> tags,
    Map<String, dynamic>? specifications,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isDeleted,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@freezed
class ProductWithCategory with _$ProductWithCategory {
  const factory ProductWithCategory({
    required Product product,
    Category? category,
  }) = _ProductWithCategory;

  factory ProductWithCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductWithCategoryFromJson(json);
}

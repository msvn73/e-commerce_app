import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    required String name,
    String? description,
    required double price,
    double? originalPrice,
    @Default(0) int discountPercent,
    String? categoryId,
    @Default([]) List<String> images,
    @Default([]) List<String> videos,
    @Default(0) int stock,
    @Default(true) bool isActive,
    @Default([]) List<String> tags,
    Map<String, dynamic>? specifications,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isDeleted,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

@freezed
class ProductFormData with _$ProductFormData {
  const factory ProductFormData({
    @Default('') String name,
    @Default('') String description,
    @Default(0.0) double price,
    @Default(0) int stock,
    @Default('') String categoryId,
    @Default([]) List<String> images,
    @Default([]) List<String> videos,
    @Default(true) bool isActive,
  }) = _ProductFormData;

  factory ProductFormData.fromJson(Map<String, dynamic> json) =>
      _$ProductFormDataFromJson(json);
}

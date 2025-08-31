// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      originalPrice: (json['originalPrice'] as num?)?.toDouble(),
      discountPercent: (json['discountPercent'] as num?)?.toInt() ?? 0,
      categoryId: json['categoryId'] as String?,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      stockQuantity: (json['stockQuantity'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      specifications: json['specifications'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'originalPrice': instance.originalPrice,
      'discountPercent': instance.discountPercent,
      'categoryId': instance.categoryId,
      'imageUrls': instance.imageUrls,
      'stockQuantity': instance.stockQuantity,
      'isActive': instance.isActive,
      'tags': instance.tags,
      'specifications': instance.specifications,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isDeleted': instance.isDeleted,
    };

_$ProductWithCategoryImpl _$$ProductWithCategoryImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductWithCategoryImpl(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProductWithCategoryImplToJson(
        _$ProductWithCategoryImpl instance) =>
    <String, dynamic>{
      'product': instance.product,
      'category': instance.category,
    };

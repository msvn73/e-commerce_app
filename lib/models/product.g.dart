// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      availableSizes: (json['availableSizes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      availableColors: (json['availableColors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isFavorite: json['isFavorite'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 4.5,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
      'availableSizes': instance.availableSizes,
      'availableColors': instance.availableColors,
      'isFavorite': instance.isFavorite,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
    };

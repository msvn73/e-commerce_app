// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartItemImpl _$$CartItemImplFromJson(Map<String, dynamic> json) =>
    _$CartItemImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CartItemImplToJson(_$CartItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$CartItemWithProductImpl _$$CartItemWithProductImplFromJson(
        Map<String, dynamic> json) =>
    _$CartItemWithProductImpl(
      cartItem: CartItem.fromJson(json['cartItem'] as Map<String, dynamic>),
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CartItemWithProductImplToJson(
        _$CartItemWithProductImpl instance) =>
    <String, dynamic>{
      'cartItem': instance.cartItem,
      'product': instance.product,
    };

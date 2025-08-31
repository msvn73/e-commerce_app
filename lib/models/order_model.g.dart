// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      orderNumber: json['orderNumber'] as String,
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      shippingFee: (json['shippingFee'] as num?)?.toDouble() ?? 0.0,
      discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0.0,
      finalAmount: (json['finalAmount'] as num).toDouble(),
      paymentMethodId: json['paymentMethodId'] as String?,
      deliveryAddressId: json['deliveryAddressId'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'orderNumber': instance.orderNumber,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'totalAmount': instance.totalAmount,
      'shippingFee': instance.shippingFee,
      'discountAmount': instance.discountAmount,
      'finalAmount': instance.finalAmount,
      'paymentMethodId': instance.paymentMethodId,
      'deliveryAddressId': instance.deliveryAddressId,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isDeleted': instance.isDeleted,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.confirmed: 'confirmed',
  OrderStatus.processing: 'processing',
  OrderStatus.shipped: 'shipped',
  OrderStatus.delivered: 'delivered',
  OrderStatus.cancelled: 'cancelled',
  OrderStatus.refunded: 'refunded',
};

_$OrderItemImpl _$$OrderItemImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemImpl(
      id: json['id'] as String,
      orderId: json['orderId'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$OrderItemImplToJson(_$OrderItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'productId': instance.productId,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
      'quantity': instance.quantity,
      'totalPrice': instance.totalPrice,
      'createdAt': instance.createdAt.toIso8601String(),
      'isDeleted': instance.isDeleted,
    };

_$OrderWithItemsImpl _$$OrderWithItemsImplFromJson(Map<String, dynamic> json) =>
    _$OrderWithItemsImpl(
      order: Order.fromJson(json['order'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$OrderWithItemsImplToJson(
        _$OrderWithItemsImpl instance) =>
    <String, dynamic>{
      'order': instance.order,
      'items': instance.items,
    };

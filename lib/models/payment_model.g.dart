// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentMethodImpl _$$PaymentMethodImplFromJson(Map<String, dynamic> json) =>
    _$PaymentMethodImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      cardType: json['cardType'] as String,
      cardNumber: json['cardNumber'] as String,
      cardHolder: json['cardHolder'] as String,
      expiryMonth: json['expiryMonth'] as String,
      expiryYear: json['expiryYear'] as String,
      cvvHash: json['cvvHash'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$PaymentMethodImplToJson(_$PaymentMethodImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'cardType': instance.cardType,
      'cardNumber': instance.cardNumber,
      'cardHolder': instance.cardHolder,
      'expiryMonth': instance.expiryMonth,
      'expiryYear': instance.expiryYear,
      'cvvHash': instance.cvvHash,
      'isDefault': instance.isDefault,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isDeleted': instance.isDeleted,
    };

_$DeliveryAddressImpl _$$DeliveryAddressImplFromJson(
        Map<String, dynamic> json) =>
    _$DeliveryAddressImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      fullName: json['fullName'] as String,
      phone: json['phone'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
      neighborhood: json['neighborhood'] as String,
      street: json['street'] as String,
      buildingNo: json['buildingNo'] as String,
      apartmentNo: json['apartmentNo'] as String,
      postalCode: json['postalCode'] as String,
      addressNote: json['addressNote'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$DeliveryAddressImplToJson(
        _$DeliveryAddressImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'city': instance.city,
      'district': instance.district,
      'neighborhood': instance.neighborhood,
      'street': instance.street,
      'buildingNo': instance.buildingNo,
      'apartmentNo': instance.apartmentNo,
      'postalCode': instance.postalCode,
      'addressNote': instance.addressNote,
      'isDefault': instance.isDefault,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isDeleted': instance.isDeleted,
    };

_$PaymentIntentImpl _$$PaymentIntentImplFromJson(Map<String, dynamic> json) =>
    _$PaymentIntentImpl(
      id: json['id'] as String,
      clientSecret: json['clientSecret'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      paymentMethodId: json['paymentMethodId'] as String?,
    );

Map<String, dynamic> _$$PaymentIntentImplToJson(_$PaymentIntentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientSecret': instance.clientSecret,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': instance.status,
      'paymentMethodId': instance.paymentMethodId,
    };

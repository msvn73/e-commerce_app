import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_model.freezed.dart';
part 'payment_model.g.dart';

@freezed
class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod({
    required String id,
    required String userId,
    required String cardType,
    required String cardNumber,
    required String cardHolder,
    required String expiryMonth,
    required String expiryYear,
    String? cvvHash,
    @Default(false) bool isDefault,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isDeleted,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);
}

@freezed
class DeliveryAddress with _$DeliveryAddress {
  const factory DeliveryAddress({
    required String id,
    required String userId,
    required String fullName,
    required String phone,
    required String city,
    required String district,
    required String neighborhood,
    required String street,
    required String buildingNo,
    required String apartmentNo,
    required String postalCode,
    String? addressNote,
    @Default(false) bool isDefault,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isDeleted,
  }) = _DeliveryAddress;

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      _$DeliveryAddressFromJson(json);
}

@freezed
class PaymentIntent with _$PaymentIntent {
  const factory PaymentIntent({
    required String id,
    required String clientSecret,
    required double amount,
    required String currency,
    required String status,
    String? paymentMethodId,
  }) = _PaymentIntent;

  factory PaymentIntent.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentFromJson(json);
}

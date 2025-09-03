import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  const factory OrderModel({
    required String id,
    required String userId,
    required String orderNumber,
    required String status,
    required double totalAmount,
    @Default(0.0) double shippingFee,
    @Default(0.0) double discountAmount,
    required double finalAmount,
    String? paymentMethodId,
    String? deliveryAddressId,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isDeleted,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}

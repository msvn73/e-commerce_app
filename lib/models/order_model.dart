import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

enum OrderStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('processing')
  processing,
  @JsonValue('shipped')
  shipped,
  @JsonValue('delivered')
  delivered,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('refunded')
  refunded,
}

@freezed
class Order with _$Order {
  const factory Order({
    required String id,
    required String userId,
    required String orderNumber,
    required OrderStatus status,
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
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    required String id,
    required String orderId,
    required String productId,
    required String productName,
    required double productPrice,
    required int quantity,
    required double totalPrice,
    required DateTime createdAt,
    @Default(false) bool isDeleted,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}

@freezed
class OrderWithItems with _$OrderWithItems {
  const factory OrderWithItems({
    required Order order,
    @Default([]) List<OrderItem> items,
  }) = _OrderWithItems;

  factory OrderWithItems.fromJson(Map<String, dynamic> json) =>
      _$OrderWithItemsFromJson(json);
}

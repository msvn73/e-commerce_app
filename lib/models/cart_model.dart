import 'package:freezed_annotation/freezed_annotation.dart';
import 'product_model.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required String id,
    required String userId,
    required String productId,
    required int quantity,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}

@freezed
class CartItemWithProduct with _$CartItemWithProduct {
  const factory CartItemWithProduct({
    required CartItem cartItem,
    required Product product,
  }) = _CartItemWithProduct;

  factory CartItemWithProduct.fromJson(Map<String, dynamic> json) =>
      _$CartItemWithProductFromJson(json);
}

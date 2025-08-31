import 'package:freezed_annotation/freezed_annotation.dart';
import 'product.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required String id,
    required Product product,
    required int quantity,
    required String selectedSize,
    required String selectedColor,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}

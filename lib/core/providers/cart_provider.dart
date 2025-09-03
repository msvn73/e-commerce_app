import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_item_model.dart';
import '../repositories/cart_repository.dart';

// Cart repository provider
final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository();
});

// Cart items provider
final cartItemsProvider = FutureProvider<List<CartItemModel>>((ref) async {
  final repository = ref.watch(cartRepositoryProvider);
  return await repository.getCartItems();
});

// Cart items with products provider
final cartItemsWithProductsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final repository = ref.watch(cartRepositoryProvider);
  return await repository.getCartItemsWithProducts();
});

// Cart item count provider
final cartItemCountProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(cartRepositoryProvider);
  return await repository.getCartItemCount();
});

// Cart total provider
final cartTotalProvider = FutureProvider<double>((ref) async {
  final repository = ref.watch(cartRepositoryProvider);
  return await repository.getCartTotal();
});

// Add to cart provider
final addToCartProvider = FutureProvider.family<void, AddToCartParams>((ref, params) async {
  final repository = ref.watch(cartRepositoryProvider);
  await repository.addToCart(params.productId, quantity: params.quantity);
});

// Update cart item quantity provider
final updateCartItemQuantityProvider = FutureProvider.family<void, UpdateCartItemParams>((ref, params) async {
  final repository = ref.watch(cartRepositoryProvider);
  await repository.updateCartItemQuantity(params.cartItemId, params.quantity);
});

// Remove from cart provider
final removeFromCartProvider = FutureProvider.family<void, String>((ref, cartItemId) async {
  final repository = ref.watch(cartRepositoryProvider);
  await repository.removeFromCart(cartItemId);
});

// Clear cart provider
final clearCartProvider = FutureProvider<void>((ref) async {
  final repository = ref.watch(cartRepositoryProvider);
  await repository.clearCart();
});

// Check if product is in cart provider
final isProductInCartProvider = FutureProvider.family<bool, String>((ref, productId) async {
  final repository = ref.watch(cartRepositoryProvider);
  return await repository.isProductInCart(productId);
});

// Get product quantity in cart provider
final productQuantityInCartProvider = FutureProvider.family<int, String>((ref, productId) async {
  final repository = ref.watch(cartRepositoryProvider);
  return await repository.getProductQuantityInCart(productId);
});

// Parameter classes
class AddToCartParams {
  final String productId;
  final int quantity;

  AddToCartParams({
    required this.productId,
    this.quantity = 1,
  });
}

class UpdateCartItemParams {
  final String cartItemId;
  final int quantity;

  UpdateCartItemParams({
    required this.cartItemId,
    required this.quantity,
  });
}

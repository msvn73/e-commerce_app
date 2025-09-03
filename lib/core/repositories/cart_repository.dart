import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_item_model.dart';

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository();
});

class CartRepository {
  final SupabaseClient _client = Supabase.instance.client;

  // Get user cart items
  Future<List<CartItemModel>> getCartItems() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final response = await _client
        .from('cart_items')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => CartItemModel.fromJson(json))
        .toList();
  }

  // Get cart items with product details
  Future<List<Map<String, dynamic>>> getCartItemsWithProducts() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final response = await _client
        .from('cart_items')
        .select('''
          id,
          user_id,
          product_id,
          quantity,
          created_at,
          updated_at,
          products (
            id,
            name,
            description,
            price,
            stock,
            category_id,
            images,
            is_active,
            created_at,
            updated_at
          )
        ''')
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return (response as List).cast<Map<String, dynamic>>();
  }

  // Add product to cart
  Future<void> addToCart(String productId, {int quantity = 1}) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    // Check if product already exists in cart
    try {
      final existingItem = await _client
          .from('cart_items')
          .select('id, quantity')
          .eq('user_id', user.id)
          .eq('product_id', productId)
          .single();

      // Update quantity if item exists
      await _client
          .from('cart_items')
          .update({'quantity': existingItem['quantity'] + quantity})
          .eq('id', existingItem['id']);
    } catch (e) {
      // Insert new item if doesn't exist
      await _client.from('cart_items').insert({
        'user_id': user.id,
        'product_id': productId,
        'quantity': quantity,
      });
    }
  }

  // Update cart item quantity
  Future<void> updateCartItemQuantity(String cartItemId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(cartItemId);
      return;
    }

    await _client
        .from('cart')
        .update({'quantity': quantity})
        .eq('id', cartItemId);
  }

  // Remove item from cart
  Future<void> removeFromCart(String cartItemId) async {
    await _client.from('cart').delete().eq('id', cartItemId);
  }

  // Remove product from cart by product ID
  Future<void> removeProductFromCart(String productId) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    await _client
        .from('cart')
        .delete()
        .eq('user_id', user.id)
        .eq('product_id', productId);
  }

  // Clear entire cart
  Future<void> clearCart() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    await _client.from('cart').delete().eq('user_id', user.id);
  }

  // Get cart item count
  Future<int> getCartItemCount() async {
    final user = _client.auth.currentUser;
    if (user == null) return 0;

    try {
      final response = await _client
          .from('cart')
          .select('id')
          .eq('user_id', user.id);

      return (response as List).length;
    } catch (e) {
      return 0;
    }
  }

  // Get cart total
  Future<double> getCartTotal() async {
    final cartItems = await getCartItemsWithProducts();
    double total = 0.0;

    for (final item in cartItems) {
      final product = item['products'] as Map<String, dynamic>;
      final price = (product['price'] as num).toDouble();
      final quantity = (item['quantity'] as num).toInt();
      total += price * quantity;
    }

    return total;
  }

  // Check if product is in cart
  Future<bool> isProductInCart(String productId) async {
    final user = _client.auth.currentUser;
    if (user == null) return false;

    try {
      await _client
          .from('cart')
          .select('id')
          .eq('user_id', user.id)
          .eq('product_id', productId)
          .single();

      return true;
    } catch (e) {
      return false;
    }
  }

  // Get cart item quantity for a product
  Future<int> getProductQuantityInCart(String productId) async {
    final user = _client.auth.currentUser;
    if (user == null) return 0;

    try {
      final response = await _client
          .from('cart')
          .select('quantity')
          .eq('user_id', user.id)
          .eq('product_id', productId)
          .single();

      return response['quantity'] as int;
    } catch (e) {
      return 0;
    }
  }
}
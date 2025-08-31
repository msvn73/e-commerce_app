import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/product.dart';

part 'cart_provider.g.dart';

class CartItem {
  final String id;
  final Product product;
  final int quantity;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'product': product.toJson(),
    'quantity': quantity,
  };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json['id'],
    product: Product.fromJson(json['product']),
    quantity: json['quantity'],
  );

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}

@riverpod
class Cart extends _$Cart {
  static const String _storageKey = 'cart';

  @override
  List<CartItem> build() {
    _loadCart();
    return [];
  }

  Future<void> _loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getStringList(_storageKey) ?? [];
      
      final cart = cartJson
          .map((json) => CartItem.fromJson(jsonDecode(json)))
          .toList();
      
      state = cart;
    } catch (e) {
      print('Sepet yüklenirken hata: $e');
      state = [];
    }
  }

  Future<void> _saveCart(List<CartItem> cart) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = cart
          .map((item) => jsonEncode(item.toJson()))
          .toList();
      
      await prefs.setStringList(_storageKey, cartJson);
    } catch (e) {
      print('Sepet kaydedilirken hata: $e');
    }
  }

  void addToCart(Product product, {int quantity = 1}) {
    final existingIndex = state.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex != -1) {
      // Update existing item quantity
      final existingItem = state[existingIndex];
      final newQuantity = existingItem.quantity + quantity;
      
      state = [
        ...state.sublist(0, existingIndex),
        existingItem.copyWith(quantity: newQuantity),
        ...state.sublist(existingIndex + 1),
      ];
    } else {
      // Add new item
      final newItem = CartItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        product: product,
        quantity: quantity,
      );
      
      state = [...state, newItem];
    }
    
    // Persist to storage
    _saveCart(state);
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(itemId);
      return;
    }
    
    final index = state.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      final item = state[index];
      state = [
        ...state.sublist(0, index),
        item.copyWith(quantity: quantity),
        ...state.sublist(index + 1),
      ];
      
      // Persist to storage
      _saveCart(state);
    }
  }

  void removeFromCart(String itemId) {
    state = state.where((item) => item.id != itemId).toList();
    _saveCart(state);
  }

  void clearCart() {
    state = [];
    _saveCart(state);
  }

  int get itemCount => state.fold(0, (sum, item) => sum + item.quantity);
  
  double get totalPrice => state.fold(
    0.0, 
    (sum, item) => sum + (item.product.price * item.quantity)
  );
}

@riverpod
double cartTotal(CartTotalRef ref) {
  final cartItems = ref.watch(cartProvider);
  return cartItems.fold(
    0.0,
    (sum, item) => sum + (item.product.price * item.quantity),
  );
}

@riverpod
int cartItemCount(CartItemCountRef ref) {
  final cartItems = ref.watch(cartProvider);
  return cartItems.fold(0, (sum, item) => sum + item.quantity);
}

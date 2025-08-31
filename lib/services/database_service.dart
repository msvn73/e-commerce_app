import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/cart_model.dart';
import '../models/order_model.dart';
import '../models/user_model.dart' as app_user;

class DatabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Kategori işlemleri
  Future<List<Category>> getCategories() async {
    try {
      final response = await _supabase
          .from('categories')
          .select()
          .eq('is_active', true)
          .eq('is_deleted', false)
          .order('sort_order');

      return (response as List).map((json) => Category.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  Future<Category?> getCategoryById(String id) async {
    try {
      final response = await _supabase
          .from('categories')
          .select()
          .eq('id', id)
          .eq('is_active', true)
          .eq('is_deleted', false)
          .single();

      return Category.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  // Ürün işlemleri
  Future<List<Product>> getProducts({
    String? categoryId,
    String? searchQuery,
    int? limit,
    int? offset,
  }) async {
    try {
      dynamic query = _supabase
          .from('products')
          .select()
          .eq('is_active', true)
          .eq('is_deleted', false);

      if (categoryId != null) {
        query = query.eq('category_id', categoryId);
      }

      if (searchQuery != null && searchQuery.isNotEmpty) {
        query = query.ilike('name', '%$searchQuery%');
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      if (offset != null) {
        query = query.range(offset, offset + (limit ?? 10) - 1);
      }

      final response = await query.order('created_at', ascending: false);
      return (response as List).map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<Product?> getProductById(String id) async {
    try {
      final response = await _supabase
          .from('products')
          .select()
          .eq('id', id)
          .eq('is_active', true)
          .eq('is_deleted', false)
          .single();

      return Product.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  // Sepet işlemleri
  Future<List<CartItem>> getCartItems(String userId) async {
    try {
      final response = await _supabase
          .from('cart_items')
          .select()
          .eq('user_id', userId)
          .eq('is_deleted', false);

      return (response as List).map((json) => CartItem.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch cart items: $e');
    }
  }

  Future<void> addToCart(CartItem cartItem) async {
    try {
      await _supabase.from('cart_items').insert(cartItem.toJson());
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  Future<void> updateCartItem(CartItem cartItem) async {
    try {
      await _supabase
          .from('cart_items')
          .update(cartItem.toJson())
          .eq('id', cartItem.id);
    } catch (e) {
      throw Exception('Failed to update cart item: $e');
    }
  }

  Future<void> removeFromCart(String cartItemId) async {
    try {
      await _supabase
          .from('cart_items')
          .update({'is_deleted': true}).eq('id', cartItemId);
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  // Sipariş işlemleri
  Future<List<Order>> getOrders(String userId) async {
    try {
      final response = await _supabase
          .from('orders')
          .select()
          .eq('user_id', userId)
          .eq('is_deleted', false)
          .order('created_at', ascending: false);

      return (response as List).map((json) => Order.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch orders: $e');
    }
  }

  Future<Order?> getOrderById(String orderId) async {
    try {
      final response = await _supabase
          .from('orders')
          .select()
          .eq('id', orderId)
          .eq('is_deleted', false)
          .single();

      return Order.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<void> createOrder(Order order) async {
    try {
      await _supabase.from('orders').insert(order.toJson());
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  // Kullanıcı işlemleri
  Future<app_user.User?> getUserById(String userId) async {
    try {
      final response = await _supabase
          .from('users')
          .select()
          .eq('id', userId)
          .eq('is_deleted', false)
          .single();

      return app_user.User.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateUser(app_user.User user) async {
    try {
      await _supabase.from('users').update(user.toJson()).eq('id', user.id);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }
}

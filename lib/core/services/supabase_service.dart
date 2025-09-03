import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient _client = Supabase.instance.client;

  // Users
  static Future<void> createUser({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'phone': phone,
        },
      );

      if (response.user != null) {
        // Create user profile
        await _client.from('profiles').insert({
          'id': response.user!.id,
          'full_name': fullName,
          'email': email,
          'phone': phone,
          'is_admin': false,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      throw Exception('Kullanıcı oluşturulamadı: $e');
    }
  }

  static Future<AuthResponse> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      return await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Giriş yapılamadı: $e');
    }
  }

  static Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw Exception('Çıkış yapılamadı: $e');
    }
  }

  // Categories
  static Future<List<Map<String, dynamic>>> getCategories() async {
    try {
      final response = await _client.from('categories').select().order('name');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Kategoriler alınamadı: $e');
    }
  }

  static Future<void> createCategory({
    required String name,
    required String description,
    required String icon,
    required String color,
  }) async {
    try {
      await _client.from('categories').insert({
        'name': name,
        'description': description,
        'icon': icon,
        'color': color,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Kategori oluşturulamadı: $e');
    }
  }

  static Future<void> updateCategory({
    required String id,
    required String name,
    required String description,
    required String icon,
    required String color,
  }) async {
    try {
      await _client.from('categories').update({
        'name': name,
        'description': description,
        'icon': icon,
        'color': color,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', id);
    } catch (e) {
      throw Exception('Kategori güncellenemedi: $e');
    }
  }

  static Future<void> deleteCategory(String id) async {
    try {
      await _client.from('categories').delete().eq('id', id);
    } catch (e) {
      throw Exception('Kategori silinemedi: $e');
    }
  }

  // Products
  static Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      final response = await _client.from('products').select('''
            *,
            categories(name)
          ''').order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Ürünler alınamadı: $e');
    }
  }

  static Future<void> createProduct({
    required String name,
    required String description,
    required double price,
    required int stock,
    required String categoryId,
    required List<String> images,
  }) async {
    try {
      await _client.from('products').insert({
        'name': name,
        'description': description,
        'price': price,
        'stock': stock,
        'category_id': categoryId,
        'images': images,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Ürün oluşturulamadı: $e');
    }
  }

  static Future<void> updateProduct({
    required String id,
    required String name,
    required String description,
    required double price,
    required int stock,
    required String categoryId,
    required List<String> images,
  }) async {
    try {
      await _client.from('products').update({
        'name': name,
        'description': description,
        'price': price,
        'stock': stock,
        'category_id': categoryId,
        'images': images,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', id);
    } catch (e) {
      throw Exception('Ürün güncellenemedi: $e');
    }
  }

  static Future<void> deleteProduct(String id) async {
    try {
      await _client.from('products').delete().eq('id', id);
    } catch (e) {
      throw Exception('Ürün silinemedi: $e');
    }
  }

  // Orders
  static Future<List<Map<String, dynamic>>> getOrders() async {
    try {
      final response = await _client.from('orders').select('''
            *,
            profiles(full_name, email),
            order_items(
              *,
              products(name, price)
            )
          ''').order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Siparişler alınamadı: $e');
    }
  }

  static Future<void> updateOrderStatus({
    required String id,
    required String status,
  }) async {
    try {
      await _client.from('orders').update({
        'status': status,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', id);
    } catch (e) {
      throw Exception('Sipariş durumu güncellenemedi: $e');
    }
  }

  // Cart
  static Future<List<Map<String, dynamic>>> getCartItems(String userId) async {
    try {
      final response = await _client.from('cart_items').select('''
            *,
            products(name, price, images)
          ''').eq('user_id', userId);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Sepet öğeleri alınamadı: $e');
    }
  }

  static Future<void> addToCart({
    required String userId,
    required String productId,
    required int quantity,
  }) async {
    try {
      // Check if item already exists in cart
      final existing = await _client
          .from('cart_items')
          .select()
          .eq('user_id', userId)
          .eq('product_id', productId)
          .single();

      if (existing.isNotEmpty) {
        // Update quantity
        await _client
            .from('cart_items')
            .update({
              'quantity': existing['quantity'] + quantity,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('user_id', userId)
            .eq('product_id', productId);
      } else {
        // Add new item
        await _client.from('cart_items').insert({
          'user_id': userId,
          'product_id': productId,
          'quantity': quantity,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      throw Exception('Sepete eklenemedi: $e');
    }
  }

  static Future<void> removeFromCart({
    required String userId,
    required String productId,
  }) async {
    try {
      await _client
          .from('cart_items')
          .delete()
          .eq('user_id', userId)
          .eq('product_id', productId);
    } catch (e) {
      throw Exception('Sepetten çıkarılamadı: $e');
    }
  }

  static Future<void> clearCart(String userId) async {
    try {
      await _client.from('cart_items').delete().eq('user_id', userId);
    } catch (e) {
      throw Exception('Sepet temizlenemedi: $e');
    }
  }
}

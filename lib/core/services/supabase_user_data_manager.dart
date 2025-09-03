import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseUserDataManager {
  static final SupabaseClient _client = Supabase.instance.client;

  // Get current user ID
  static String? get _currentUserId => _client.auth.currentUser?.id;

  // Cart Management
  static Future<List<Map<String, dynamic>>> getCartItems() async {
    if (_currentUserId == null) return [];

    try {
      final response = await _client.from('cart_items').select('''
            *,
            products (
              id,
              name,
              price,
              images,
              stock
            )
          ''').eq('user_id', _currentUserId!).eq('is_deleted', false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  static Future<void> addToCart(String productId, int quantity) async {
    if (_currentUserId == null) return;

    try {
      // Check if item already exists in cart
      final existing = await _client
          .from('cart_items')
          .select()
          .eq('user_id', _currentUserId!)
          .eq('product_id', productId)
          .eq('is_deleted', false)
          .maybeSingle();

      if (existing != null) {
        // Update quantity
        await _client.from('cart_items').update({
          'quantity': existing['quantity'] + quantity,
          'updated_at': DateTime.now().toIso8601String(),
        }).eq('id', existing['id']);
      } else {
        // Add new item
        await _client.from('cart_items').insert({
          'user_id': _currentUserId!,
          'product_id': productId,
          'quantity': quantity,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      throw Exception('Sepete ekleme hatası: $e');
    }
  }

  static Future<void> updateCartItemQuantity(
      String cartItemId, int quantity) async {
    if (_currentUserId == null) return;

    try {
      if (quantity <= 0) {
        await _client
            .from('cart_items')
            .update({
              'is_deleted': true,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('id', cartItemId)
            .eq('user_id', _currentUserId!);
      } else {
        await _client
            .from('cart_items')
            .update({
              'quantity': quantity,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('id', cartItemId)
            .eq('user_id', _currentUserId!);
      }
    } catch (e) {
      throw Exception('Sepet güncelleme hatası: $e');
    }
  }

  static Future<void> removeFromCart(String cartItemId) async {
    if (_currentUserId == null) return;

    try {
      await _client
          .from('cart_items')
          .update({
            'is_deleted': true,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', cartItemId)
          .eq('user_id', _currentUserId!);
    } catch (e) {
      throw Exception('Sepetten çıkarma hatası: $e');
    }
  }

  static Future<void> clearCart() async {
    if (_currentUserId == null) return;

    try {
      await _client.from('cart_items').update({
        'is_deleted': true,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('user_id', _currentUserId!);
    } catch (e) {
      throw Exception('Sepet temizleme hatası: $e');
    }
  }

  // Wishlist Management
  static Future<List<Map<String, dynamic>>> getWishlistItems() async {
    if (_currentUserId == null) return [];

    try {
      final response = await _client.from('wishlist').select('''
            *,
            products (
              id,
              name,
              price,
              images,
              stock
            )
          ''').eq('user_id', _currentUserId!).eq('is_deleted', false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  static Future<void> addToWishlist(String productId) async {
    if (_currentUserId == null) return;

    try {
      // Check if already in wishlist
      final existing = await _client
          .from('wishlist')
          .select()
          .eq('user_id', _currentUserId!)
          .eq('product_id', productId)
          .eq('is_deleted', false)
          .maybeSingle();

      if (existing == null) {
        await _client.from('wishlist').insert({
          'user_id': _currentUserId!,
          'product_id': productId,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      throw Exception('Favorilere ekleme hatası: $e');
    }
  }

  static Future<void> removeFromWishlist(String wishlistItemId) async {
    if (_currentUserId == null) return;

    try {
      await _client
          .from('wishlist')
          .update({
            'is_deleted': true,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', wishlistItemId)
          .eq('user_id', _currentUserId!);
    } catch (e) {
      throw Exception('Favorilerden çıkarma hatası: $e');
    }
  }

  static Future<void> clearWishlist() async {
    if (_currentUserId == null) return;

    try {
      await _client.from('wishlist').update({
        'is_deleted': true,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('user_id', _currentUserId!);
    } catch (e) {
      throw Exception('Favori listesi temizleme hatası: $e');
    }
  }

  // Address Management
  static Future<List<Map<String, dynamic>>> getAddresses() async {
    if (_currentUserId == null) return [];

    try {
      final response = await _client
          .from('addresses')
          .select()
          .eq('user_id', _currentUserId!)
          .eq('is_deleted', false)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  static Future<String> addAddress(Map<String, dynamic> addressData) async {
    if (_currentUserId == null) throw Exception('Kullanıcı oturumu bulunamadı');

    try {
      final response = await _client
          .from('addresses')
          .insert({
            'user_id': _currentUserId!,
            'title': addressData['title'],
            'full_name': addressData['fullName'],
            'phone': addressData['phone'],
            'address_line_1': addressData['addressLine1'],
            'address_line_2': addressData['addressLine2'],
            'city': addressData['city'],
            'state': addressData['state'],
            'postal_code': addressData['postalCode'],
            'country': addressData['country'],
            'is_default': addressData['isDefault'] ?? false,
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      return response['id'];
    } catch (e) {
      throw Exception('Adres ekleme hatası: $e');
    }
  }

  static Future<void> updateAddress(
      String addressId, Map<String, dynamic> addressData) async {
    if (_currentUserId == null) return;

    try {
      await _client
          .from('addresses')
          .update({
            'title': addressData['title'],
            'full_name': addressData['fullName'],
            'phone': addressData['phone'],
            'address_line_1': addressData['addressLine1'],
            'address_line_2': addressData['addressLine2'],
            'city': addressData['city'],
            'state': addressData['state'],
            'postal_code': addressData['postalCode'],
            'country': addressData['country'],
            'is_default': addressData['isDefault'] ?? false,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', addressId)
          .eq('user_id', _currentUserId!);
    } catch (e) {
      throw Exception('Adres güncelleme hatası: $e');
    }
  }

  static Future<void> deleteAddress(String addressId) async {
    if (_currentUserId == null) return;

    try {
      await _client
          .from('addresses')
          .update({
            'is_deleted': true,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', addressId)
          .eq('user_id', _currentUserId!);
    } catch (e) {
      throw Exception('Adres silme hatası: $e');
    }
  }

  // Payment Methods Management
  static Future<List<Map<String, dynamic>>> getPaymentMethods() async {
    if (_currentUserId == null) return [];

    try {
      final response = await _client
          .from('payment_methods')
          .select()
          .eq('user_id', _currentUserId!)
          .eq('is_deleted', false)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  static Future<String> addPaymentMethod(
      Map<String, dynamic> paymentData) async {
    if (_currentUserId == null) throw Exception('Kullanıcı oturumu bulunamadı');

    try {
      final response = await _client
          .from('payment_methods')
          .insert({
            'user_id': _currentUserId!,
            'type': paymentData[
                'type'], // 'credit_card', 'debit_card', 'paypal', etc.
            'card_number': paymentData['cardNumber'],
            'card_holder_name': paymentData['cardHolderName'],
            'expiry_month': paymentData['expiryMonth'],
            'expiry_year': paymentData['expiryYear'],
            'cvv': paymentData['cvv'],
            'is_default': paymentData['isDefault'] ?? false,
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      return response['id'];
    } catch (e) {
      throw Exception('Ödeme yöntemi ekleme hatası: $e');
    }
  }

  static Future<void> updatePaymentMethod(
      String paymentMethodId, Map<String, dynamic> paymentData) async {
    if (_currentUserId == null) return;

    try {
      await _client
          .from('payment_methods')
          .update({
            'type': paymentData['type'],
            'card_number': paymentData['cardNumber'],
            'card_holder_name': paymentData['cardHolderName'],
            'expiry_month': paymentData['expiryMonth'],
            'expiry_year': paymentData['expiryYear'],
            'cvv': paymentData['cvv'],
            'is_default': paymentData['isDefault'] ?? false,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', paymentMethodId)
          .eq('user_id', _currentUserId!);
    } catch (e) {
      throw Exception('Ödeme yöntemi güncelleme hatası: $e');
    }
  }

  static Future<void> deletePaymentMethod(String paymentMethodId) async {
    if (_currentUserId == null) return;

    try {
      await _client
          .from('payment_methods')
          .update({
            'is_deleted': true,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', paymentMethodId)
          .eq('user_id', _currentUserId!);
    } catch (e) {
      throw Exception('Ödeme yöntemi silme hatası: $e');
    }
  }

  // Orders Management
  static Future<List<Map<String, dynamic>>> getOrders() async {
    if (_currentUserId == null) return [];

    try {
      final response = await _client
          .from('orders')
          .select('''
            *,
            order_items (
              *,
              products (
                id,
                name,
                price,
                images
              )
            )
          ''')
          .eq('user_id', _currentUserId!)
          .eq('is_deleted', false)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  static Future<String> createOrder({
    required List<Map<String, dynamic>> cartItems,
    required String shippingAddressId,
    required String paymentMethodId,
    required double totalAmount,
    String? notes,
  }) async {
    if (_currentUserId == null) throw Exception('Kullanıcı oturumu bulunamadı');

    try {
      // Create order
      final orderResponse = await _client
          .from('orders')
          .insert({
            'user_id': _currentUserId!,
            'shipping_address_id': shippingAddressId,
            'payment_method_id': paymentMethodId,
            'total_amount': totalAmount,
            'status': 'pending',
            'notes': notes,
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      final orderId = orderResponse['id'];

      // Create order items
      for (final item in cartItems) {
        await _client.from('order_items').insert({
          'order_id': orderId,
          'product_id': item['product_id'],
          'quantity': item['quantity'],
          'price': item['price'],
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
      }

      // Clear cart after successful order
      await clearCart();

      return orderId;
    } catch (e) {
      throw Exception('Sipariş oluşturma hatası: $e');
    }
  }

  static Future<void> updateOrderStatus(String orderId, String status) async {
    if (_currentUserId == null) return;

    try {
      await _client
          .from('orders')
          .update({
            'status': status,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', orderId)
          .eq('user_id', _currentUserId!);
    } catch (e) {
      throw Exception('Sipariş durumu güncelleme hatası: $e');
    }
  }

  // Get order status history
  static Future<List<Map<String, dynamic>>> getOrderStatusHistory(
      String orderId) async {
    if (_currentUserId == null) return [];

    try {
      final response = await _client
          .from('order_status_history')
          .select()
          .eq('order_id', orderId)
          .eq('user_id', _currentUserId!)
          .order('created_at', ascending: true);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  // Notifications Management
  static Future<Map<String, dynamic>> getNotificationSettings() async {
    if (_currentUserId == null) return {};

    try {
      final response = await _client
          .from('user_notifications')
          .select()
          .eq('user_id', _currentUserId!)
          .maybeSingle();

      return response ?? {};
    } catch (e) {
      return {};
    }
  }

  static Future<void> saveNotificationSettings(
      Map<String, dynamic> settings) async {
    if (_currentUserId == null) return;

    try {
      await _client.from('user_notifications').upsert({
        'user_id': _currentUserId!,
        'daily_notifications_enabled':
            settings['dailyNotificationsEnabled'] ?? false,
        'notification_time': settings['notificationTime'] ?? '14:00',
        'order_notifications': settings['orderNotifications'] ?? true,
        'promotion_notifications': settings['promotionNotifications'] ?? true,
        'stock_notifications': settings['stockNotifications'] ?? true,
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Bildirim ayarları kaydetme hatası: $e');
    }
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserDataManager {
  static const String _cartKey = 'user_cart';
  static const String _wishlistKey = 'user_wishlist';
  static const String _addressesKey = 'user_addresses';
  static const String _paymentMethodsKey = 'user_payment_methods';
  static const String _ordersKey = 'user_orders';
  static const String _notificationsKey = 'user_notifications';

  // Cart Management
  static Future<List<Map<String, dynamic>>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString(_cartKey);
    if (cartJson != null) {
      final List<dynamic> cartList = json.decode(cartJson);
      return cartList.cast<Map<String, dynamic>>();
    }
    return [];
  }

  static Future<void> saveCartItems(List<Map<String, dynamic>> items) async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = json.encode(items);
    await prefs.setString(_cartKey, cartJson);
  }

  static Future<void> addToCart(Map<String, dynamic> item) async {
    final items = await getCartItems();
    final existingIndex = items.indexWhere((i) => i['id'] == item['id']);

    if (existingIndex != -1) {
      items[existingIndex]['quantity'] =
          (items[existingIndex]['quantity'] ?? 1) + 1;
    } else {
      items.add({...item, 'quantity': 1});
    }

    await saveCartItems(items);
  }

  static Future<void> removeFromCart(String itemId) async {
    final items = await getCartItems();
    items.removeWhere((item) => item['id'] == itemId);
    await saveCartItems(items);
  }

  static Future<void> updateCartItemQuantity(
      String itemId, int quantity) async {
    final items = await getCartItems();
    final index = items.indexWhere((item) => item['id'] == itemId);

    if (index != -1) {
      if (quantity <= 0) {
        items.removeAt(index);
      } else {
        items[index]['quantity'] = quantity;
      }
      await saveCartItems(items);
    }
  }

  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }

  // Wishlist Management
  static Future<List<Map<String, dynamic>>> getWishlistItems() async {
    final prefs = await SharedPreferences.getInstance();
    final wishlistJson = prefs.getString(_wishlistKey);
    if (wishlistJson != null) {
      final List<dynamic> wishlistList = json.decode(wishlistJson);
      return wishlistList.cast<Map<String, dynamic>>();
    }
    return [];
  }

  static Future<void> saveWishlistItems(
      List<Map<String, dynamic>> items) async {
    final prefs = await SharedPreferences.getInstance();
    final wishlistJson = json.encode(items);
    await prefs.setString(_wishlistKey, wishlistJson);
  }

  static Future<void> addToWishlist(Map<String, dynamic> item) async {
    final items = await getWishlistItems();
    if (!items.any((i) => i['id'] == item['id'])) {
      items.add(item);
      await saveWishlistItems(items);
    }
  }

  static Future<void> removeFromWishlist(String itemId) async {
    final items = await getWishlistItems();
    items.removeWhere((item) => item['id'] == itemId);
    await saveWishlistItems(items);
  }

  static Future<void> clearWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_wishlistKey);
  }

  // Addresses Management
  static Future<List<Map<String, dynamic>>> getAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final addressesJson = prefs.getString(_addressesKey);
    if (addressesJson != null) {
      final List<dynamic> addressesList = json.decode(addressesJson);
      return addressesList.cast<Map<String, dynamic>>();
    }
    return [];
  }

  static Future<void> saveAddresses(
      List<Map<String, dynamic>> addresses) async {
    final prefs = await SharedPreferences.getInstance();
    final addressesJson = json.encode(addresses);
    await prefs.setString(_addressesKey, addressesJson);
  }

  static Future<void> addAddress(Map<String, dynamic> address) async {
    final addresses = await getAddresses();
    addresses.add(address);
    await saveAddresses(addresses);
  }

  static Future<void> updateAddress(
      String addressId, Map<String, dynamic> address) async {
    final addresses = await getAddresses();
    final index = addresses.indexWhere((a) => a['id'] == addressId);
    if (index != -1) {
      addresses[index] = address;
      await saveAddresses(addresses);
    }
  }

  static Future<void> deleteAddress(String addressId) async {
    final addresses = await getAddresses();
    addresses.removeWhere((address) => address['id'] == addressId);
    await saveAddresses(addresses);
  }

  // Payment Methods Management
  static Future<List<Map<String, dynamic>>> getPaymentMethods() async {
    final prefs = await SharedPreferences.getInstance();
    final paymentMethodsJson = prefs.getString(_paymentMethodsKey);
    if (paymentMethodsJson != null) {
      final List<dynamic> paymentMethodsList = json.decode(paymentMethodsJson);
      return paymentMethodsList.cast<Map<String, dynamic>>();
    }
    return [];
  }

  static Future<void> savePaymentMethods(
      List<Map<String, dynamic>> methods) async {
    final prefs = await SharedPreferences.getInstance();
    final paymentMethodsJson = json.encode(methods);
    await prefs.setString(_paymentMethodsKey, paymentMethodsJson);
  }

  static Future<void> addPaymentMethod(Map<String, dynamic> method) async {
    final methods = await getPaymentMethods();
    methods.add(method);
    await savePaymentMethods(methods);
  }

  static Future<void> updatePaymentMethod(
      String methodId, Map<String, dynamic> method) async {
    final methods = await getPaymentMethods();
    final index = methods.indexWhere((m) => m['id'] == methodId);
    if (index != -1) {
      methods[index] = method;
      await savePaymentMethods(methods);
    }
  }

  static Future<void> deletePaymentMethod(String methodId) async {
    final methods = await getPaymentMethods();
    methods.removeWhere((method) => method['id'] == methodId);
    await savePaymentMethods(methods);
  }

  // Orders Management
  static Future<List<Map<String, dynamic>>> getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getString(_ordersKey);
    if (ordersJson != null) {
      final List<dynamic> ordersList = json.decode(ordersJson);
      return ordersList.cast<Map<String, dynamic>>();
    }
    return [];
  }

  static Future<void> saveOrders(List<Map<String, dynamic>> orders) async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = json.encode(orders);
    await prefs.setString(_ordersKey, ordersJson);
  }

  static Future<void> addOrder(Map<String, dynamic> order) async {
    final orders = await getOrders();
    orders.insert(0, order); // Add to beginning
    await saveOrders(orders);
  }

  // Notifications Management
  static Future<Map<String, dynamic>> getNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final notificationsJson = prefs.getString(_notificationsKey);
    if (notificationsJson != null) {
      return json.decode(notificationsJson);
    }
    return {
      'dailyNotificationsEnabled': false,
      'notificationTime': '14:00',
      'orderNotifications': true,
      'promotionNotifications': true,
      'stockNotifications': true,
    };
  }

  static Future<void> saveNotificationSettings(
      Map<String, dynamic> settings) async {
    final prefs = await SharedPreferences.getInstance();
    final notificationsJson = json.encode(settings);
    await prefs.setString(_notificationsKey, notificationsJson);
  }

  // Clear All User Data
  static Future<void> clearAllUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
    await prefs.remove(_wishlistKey);
    await prefs.remove(_addressesKey);
    await prefs.remove(_paymentMethodsKey);
    await prefs.remove(_ordersKey);
    await prefs.remove(_notificationsKey);
  }

  // Export User Data (for backup)
  static Future<Map<String, dynamic>> exportUserData() async {
    return {
      'cart': await getCartItems(),
      'wishlist': await getWishlistItems(),
      'addresses': await getAddresses(),
      'paymentMethods': await getPaymentMethods(),
      'orders': await getOrders(),
      'notifications': await getNotificationSettings(),
    };
  }

  // Import User Data (for restore)
  static Future<void> importUserData(Map<String, dynamic> data) async {
    if (data['cart'] != null) {
      await saveCartItems(List<Map<String, dynamic>>.from(data['cart']));
    }
    if (data['wishlist'] != null) {
      await saveWishlistItems(
          List<Map<String, dynamic>>.from(data['wishlist']));
    }
    if (data['addresses'] != null) {
      await saveAddresses(List<Map<String, dynamic>>.from(data['addresses']));
    }
    if (data['paymentMethods'] != null) {
      await savePaymentMethods(
          List<Map<String, dynamic>>.from(data['paymentMethods']));
    }
    if (data['orders'] != null) {
      await saveOrders(List<Map<String, dynamic>>.from(data['orders']));
    }
    if (data['notifications'] != null) {
      await saveNotificationSettings(
          Map<String, dynamic>.from(data['notifications']));
    }
  }
}

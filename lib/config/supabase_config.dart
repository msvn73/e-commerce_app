class SupabaseConfig {
  static const String url = 'YOUR_SUPABASE_URL';
  static const String anonKey = 'YOUR_SUPABASE_ANON_KEY';
  
  // Storage bucket names
  static const String productImagesBucket = 'product-images';
  static const String userAvatarsBucket = 'user-avatars';
  
  // Database table names
  static const String usersTable = 'users';
  static const String categoriesTable = 'categories';
  static const String productsTable = 'products';
  static const String cartTable = 'cart';
  static const String favoritesTable = 'favorites';
  static const String ordersTable = 'orders';
  static const String orderItemsTable = 'order_items';
  static const String paymentMethodsTable = 'payment_methods';
  static const String deliveryAddressesTable = 'delivery_addresses';
}

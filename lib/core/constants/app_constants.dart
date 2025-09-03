class AppConstants {
  // API Endpoints
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = 'v1';
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  
  // Database Table Names
  static const String usersTable = 'users';
  static const String productsTable = 'products';
  static const String categoriesTable = 'categories';
  static const String cartTable = 'cart';
  static const String ordersTable = 'orders';
  static const String orderItemsTable = 'order_items';
  
  // Storage Buckets
  static const String productImagesBucket = 'product-images';
  static const String userAvatarsBucket = 'user-avatars';
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int maxNameLength = 50;
  static const int maxDescriptionLength = 500;
  
  // Image Constraints
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = [
    'jpg',
    'jpeg',
    'png',
    'webp',
  ];
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Debounce Duration
  static const Duration searchDebounce = Duration(milliseconds: 500);
  
  // Cache Duration
  static const Duration cacheExpiration = Duration(hours: 24);
}

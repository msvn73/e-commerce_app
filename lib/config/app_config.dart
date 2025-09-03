class AppConfig {
  // Supabase Configuration
  // TODO: Replace with your actual Supabase project URL and anon key
  static const String supabaseUrl = 'https://your-project.supabase.co';
  static const String supabaseAnonKey = 'your-anon-key';

  // Note: To get your Supabase credentials:
  // 1. Go to your Supabase project dashboard
  // 2. Navigate to Settings > API
  // 3. Copy the Project URL and anon public key
  // 4. Replace the values above

  // App Configuration
  static const String appName = 'E-Commerce App';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int maxRetryAttempts = 3;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Image Configuration
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = [
    'jpg',
    'jpeg',
    'png',
    'webp',
  ];

  // Cache Configuration
  static const Duration cacheExpiration = Duration(hours: 24);
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB
}

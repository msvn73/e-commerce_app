class AppConstants {
  // App info
  static const String appName = 'Drawnprint';
  static const String appVersion = '1.0.0';

  // Default location
  static const String defaultLocation = 'İstanbul, Türkiye';

  // Categories
  static const List<String> categories = [
    'T-Shirt',
    'Pantolon',
    'Ayakkabı',
    'Çanta',
    'İndirimli',
    'Tümü',
    'Alışveriş',
    'Popüler',
    'Erkek',
    'Kadın',
  ];

  // Sizes
  static const List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  // Colors
  static const List<String> colors = [
    'Kahverengi',
    'Siyah',
    'Beyaz',
    'Kırmızı',
    'Mavi',
    'Yeşil',
    'Gri',
    'Pembe',
  ];

  // Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);

  // Padding and margins
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Border radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
}

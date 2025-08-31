class StripeConfig {
  // Stripe publishable key (Flutter uygulamasında kullanılır)
  static const String publishableKey = 'YOUR_STRIPE_PUBLISHABLE_KEY';
  
  // Stripe secret key (Backend'de kullanılır - güvenlik için)
  static const String secretKey = 'YOUR_STRIPE_SECRET_KEY';
  
  // Webhook endpoint secret
  static const String webhookSecret = 'YOUR_STRIPE_WEBHOOK_SECRET';
  
  // Currency settings
  static const String currency = 'TRY';
  static const String currencySymbol = '₺';
  
  // Payment method types
  static const List<String> supportedPaymentMethods = [
    'card',
    'ideal',
    'sofort',
  ];
  
  // Shipping options
  static const Map<String, double> shippingOptions = {
    'Standard': 15.0,
    'Express': 25.0,
    'Premium': 35.0,
  };
}

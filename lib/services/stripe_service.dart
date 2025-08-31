import 'package:http/http.dart' as http;
import 'dart:convert';

class StripeService {
  static const String _publishableKey = 'pk_test_your_publishable_key_here';
  static const String _secretKey = 'sk_test_your_secret_key_here';
  static const String _baseUrl = 'https://api.stripe.com/v1';

  static Future<void> initialize() async {
    // Stripe başlatma işlemi burada yapılacak
    print('Stripe başlatıldı: $_publishableKey');
  }

  static Future<Map<String, dynamic>> createPaymentIntent({
    required double amount,
    required String currency,
    required String description,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/payment_intents'),
        headers: {
          'Authorization': 'Bearer $_secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': (amount * 100).round().toString(), // Stripe uses cents
          'currency': currency.toLowerCase(),
          'description': description,
          'automatic_payment_methods[enabled]': 'true',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Ödeme niyeti oluşturulamadı: ${response.body}');
      }
    } catch (e) {
      throw Exception('Stripe bağlantı hatası: $e');
    }
  }

  static Future<bool> processPayment({
    required double amount,
    required String currency,
    required String description,
  }) async {
    try {
      // Simüle edilmiş ödeme işlemi
      await Future.delayed(const Duration(seconds: 2));
      
      // Başarılı ödeme simülasyonu
      print('Ödeme başarılı: $amount $currency');
      return true;
    } catch (e) {
      print('Ödeme hatası: $e');
      return false;
    }
  }
}

class BillingDetails {
  final String? name;
  final String? email;
  final String? phone;
  final Address? address;

  BillingDetails({
    this.name,
    this.email,
    this.phone,
    this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address?.toJson(),
    };
  }
}

class Address {
  final String? city;
  final String? country;
  final String? line1;
  final String? line2;
  final String? postalCode;
  final String? state;

  Address({
    this.city,
    this.country,
    this.line1,
    this.line2,
    this.postalCode,
    this.state,
  });

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'country': country,
      'line1': line1,
      'line2': line2,
      'postal_code': postalCode,
      'state': state,
    };
  }
}

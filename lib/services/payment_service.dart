import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/payment_model.dart';
import '../config/stripe_config.dart';

class PaymentService {
  // Payment Intent oluştur
  Future<StripePaymentIntent> createPaymentIntent({
    required double amount,
    required String currency,
    String? paymentMethodId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${StripeConfig.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': (amount * 100).round().toString(),
          'currency': currency,
          'payment_method': paymentMethodId,
          'automatic_payment_methods[enabled]': 'true',
          'confirm': 'true',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return StripePaymentIntent(
          id: data['id'],
          clientSecret: data['client_secret'],
          amount: amount,
          currency: currency,
          status: data['status'],
          paymentMethodId: paymentMethodId,
        );
      } else {
        throw Exception('Failed to create payment intent: ${response.body}');
      }
    } catch (e) {
      throw Exception('Payment intent creation failed: $e');
    }
  }

  // Diğer metodlar...
}

// Yardımcı sınıflar
class StripePaymentIntent {
  final String id;
  final String clientSecret;
  final double amount;
  final String currency;
  final String status;
  final String? paymentMethodId;

  StripePaymentIntent({
    required this.id,
    required this.clientSecret,
    required this.amount,
    required this.currency,
    required this.status,
    this.paymentMethodId,
  });
}

class PaymentResult {
  final bool success;
  final String? paymentIntentId;
  final String message;

  PaymentResult({
    required this.success,
    this.paymentIntentId,
    required this.message,
  });
}

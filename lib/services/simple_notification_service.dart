import 'package:flutter/material.dart';

class SimpleNotificationService {
  static final GlobalKey<ScaffoldMessengerState> _messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static GlobalKey<ScaffoldMessengerState> get messengerKey => _messengerKey;

  static void showNotification({
    required String title,
    required String body,
    Duration duration = const Duration(seconds: 4),
  }) {
    _messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              body,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        duration: duration,
        backgroundColor: Colors.blue.shade700,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        action: SnackBarAction(
          label: 'Tamam',
          textColor: Colors.white,
          onPressed: () {
            _messengerKey.currentState?.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static void showWelcomeNotification() {
    showNotification(
      title: 'Hoş Geldiniz! 🎉',
      body: 'E-ticaret uygulamasına hoş geldiniz. Yeni ürünleri keşfedin!',
    );
  }

  static void showProductNotification({
    required String productName,
    required String message,
  }) {
    showNotification(
      title: 'Yeni Ürün! 🆕',
      body: '$productName: $message',
    );
  }

  static void showDiscountNotification({
    required String categoryName,
    required int discountPercent,
  }) {
    showNotification(
      title: 'İndirim Fırsatı! 💰',
      body: '$categoryName kategorisinde %$discountPercent indirim!',
    );
  }

  static void showOrderNotification({
    required String orderNumber,
    required String status,
  }) {
    showNotification(
      title: 'Sipariş Güncellemesi 📦',
      body: 'Sipariş #$orderNumber: $status',
    );
  }

  static void showTestNotification() {
    showNotification(
      title: 'Test Bildirimi! 🔔',
      body: 'Bildirim sistemi başarıyla çalışıyor!',
    );
  }
}

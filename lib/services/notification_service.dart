import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // Bildirim servisini başlat
  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    await _requestPermissions();
  }

  static void _onNotificationTapped(NotificationResponse response) {
    print('Notification tapped: ${response.payload}');
  }

  static Future<void> _requestPermissions() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  // Bildirim kanalı oluştur
  static Future<void> createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'e_commerce_channel',
      'E-Commerce Notifications',
      description: 'E-commerce uygulaması bildirimleri',
      importance: Importance.high,
    );

    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        _notifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation != null) {
      await androidImplementation.createNotificationChannel(channel);
    }
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'e_commerce_channel',
      'E-Commerce Notifications',
      channelDescription: 'E-commerce uygulaması bildirimleri',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }

  // Günlük alışveriş hatırlatması
  static Future<void> showDailyShoppingReminderNotification() async {
    await showNotification(
      id: 1,
      title: '🛍️ Alışveriş Zamanı!',
      body: 'Günlük alışveriş listenizi kontrol etmeyi unutmayın.',
    );
  }

  // Haftalık alışveriş özeti
  static Future<void> showWeeklyShoppingSummaryNotification() async {
    await showNotification(
      id: 2,
      title: '📊 Haftalık Özet',
      body: 'Bu haftaki alışveriş alışkanlıklarınızı görüntüleyin.',
    );
  }

  // Aylık alışveriş raporu
  static Future<void> showMonthlyShoppingReportNotification() async {
    await showNotification(
      id: 3,
      title: '📈 Aylık Rapor',
      body: 'Bu ayki alışveriş istatistiklerinizi inceleyin.',
    );
  }

  // Tüm bildirimleri temizle
  static Future<void> clearAllNotifications() async {
    await _notifications.cancelAll();
  }

  // Belirli bir bildirimi iptal et
  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }
}

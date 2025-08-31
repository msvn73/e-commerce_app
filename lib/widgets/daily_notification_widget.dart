import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/notification_service.dart';

class DailyNotificationWidget extends ConsumerStatefulWidget {
  const DailyNotificationWidget({super.key});

  @override
  ConsumerState<DailyNotificationWidget> createState() =>
      _DailyNotificationWidgetState();
}

class _DailyNotificationWidgetState
    extends ConsumerState<DailyNotificationWidget> {
  bool _isNotificationSent = false;
  String _lastNotificationDate = '';

  @override
  void initState() {
    super.initState();
    _checkNotificationStatus();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    try {
      await NotificationService.initialize();
      await NotificationService.createNotificationChannel();
    } catch (e) {
      print('Notification initialization error: $e');
    }
  }

  Future<void> _checkNotificationStatus() async {
    final today = DateTime.now().toIso8601String().split('T')[0];

    if (_lastNotificationDate != today) {
      setState(() {
        _lastNotificationDate = today;
        _isNotificationSent = false;
      });
    }
  }

  Future<void> _sendDailyNotification() async {
    try {
      await NotificationService.showDailyShoppingReminderNotification();

      setState(() {
        _isNotificationSent = true;
        _lastNotificationDate = DateTime.now().toIso8601String().split('T')[0];
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Günlük alışveriş hatırlatması gönderildi! 🛍️'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bildirim gönderilemedi: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.notifications_active, color: Colors.blue),
                const SizedBox(width: 8),
                const Text(
                  'Günlük Hatırlatma',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Günlük alışveriş hatırlatması almak ister misiniz?',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Son gönderim: ${_lastNotificationDate.isEmpty ? 'Henüz gönderilmedi' : _lastNotificationDate}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                ElevatedButton(
                  onPressed:
                      _isNotificationSent ? null : _sendDailyNotification,
                  child: Text(_isNotificationSent ? 'Gönderildi' : 'Hatırlat'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

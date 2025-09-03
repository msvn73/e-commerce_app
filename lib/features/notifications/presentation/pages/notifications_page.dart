import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/user_data_manager.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  bool _dailyNotificationsEnabled = false;
  TimeOfDay _notificationTime = const TimeOfDay(hour: 14, minute: 0);
  bool _orderNotifications = true;
  bool _promotionNotifications = true;
  bool _stockNotifications = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotificationSettings();
  }

  Future<void> _loadNotificationSettings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final settings = await UserDataManager.getNotificationSettings();
      setState(() {
        _dailyNotificationsEnabled =
            settings['dailyNotificationsEnabled'] ?? false;
        _orderNotifications = settings['orderNotifications'] ?? true;
        _promotionNotifications = settings['promotionNotifications'] ?? true;
        _stockNotifications = settings['stockNotifications'] ?? true;

        final timeString = settings['notificationTime'] ?? '14:00';
        final timeParts = timeString.split(':');
        _notificationTime = TimeOfDay(
          hour: int.parse(timeParts[0]),
          minute: int.parse(timeParts[1]),
        );

        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bildirim ayarları yüklenirken hata: $e')),
        );
      }
    }
  }

  Future<void> _saveNotificationSettings() async {
    final settings = {
      'dailyNotificationsEnabled': _dailyNotificationsEnabled,
      'notificationTime':
          '${_notificationTime.hour.toString().padLeft(2, '0')}:${_notificationTime.minute.toString().padLeft(2, '0')}',
      'orderNotifications': _orderNotifications,
      'promotionNotifications': _promotionNotifications,
      'stockNotifications': _stockNotifications,
    };

    await UserDataManager.saveNotificationSettings(settings);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Bildirimler'),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/profile'),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Bildirimler'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Daily Notifications
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: _dailyNotificationsEnabled
                            ? Colors.red
                            : Colors.grey,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Günlük Bildirimler',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Her gün ${_notificationTime.format(context)} saatinde bildirim alın',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _dailyNotificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            _dailyNotificationsEnabled = value;
                          });
                          _saveNotificationSettings();
                          if (value) {
                            _requestNotificationPermission();
                          }
                        },
                        activeColor: Colors.red,
                      ),
                    ],
                  ),
                  if (_dailyNotificationsEnabled) ...[
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.access_time),
                      title: const Text('Bildirim Saati'),
                      subtitle: Text(_notificationTime.format(context)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: _selectNotificationTime,
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Notification Types
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bildirim Türleri',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildNotificationOption(
                    icon: Icons.shopping_bag,
                    title: 'Sipariş Bildirimleri',
                    subtitle: 'Sipariş durumu değişiklikleri',
                    value: _orderNotifications,
                    onChanged: (value) {
                      setState(() {
                        _orderNotifications = value;
                      });
                      _saveNotificationSettings();
                    },
                  ),
                  _buildNotificationOption(
                    icon: Icons.local_offer,
                    title: 'Kampanya Bildirimleri',
                    subtitle: 'Özel indirimler ve kampanyalar',
                    value: _promotionNotifications,
                    onChanged: (value) {
                      setState(() {
                        _promotionNotifications = value;
                      });
                      _saveNotificationSettings();
                    },
                  ),
                  _buildNotificationOption(
                    icon: Icons.inventory,
                    title: 'Stok Bildirimleri',
                    subtitle: 'Favori ürünlerin stok durumu',
                    value: _stockNotifications,
                    onChanged: (value) {
                      setState(() {
                        _stockNotifications = value;
                      });
                      _saveNotificationSettings();
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Recent Notifications
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Son Bildirimler',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildNotificationItem(
                    icon: Icons.shopping_bag,
                    title: 'Siparişiniz Kargoya Verildi',
                    subtitle:
                        'ORD-001 numaralı siparişiniz kargoya verilmiştir.',
                    time: '2 saat önce',
                    isRead: false,
                  ),
                  _buildNotificationItem(
                    icon: Icons.local_offer,
                    title: 'Özel İndirim Fırsatı',
                    subtitle: 'Seçili ürünlerde %30 indirim!',
                    time: '1 gün önce',
                    isRead: true,
                  ),
                  _buildNotificationItem(
                    icon: Icons.inventory,
                    title: 'Favori Ürününüz Stokta',
                    subtitle: 'Şık Ceket tekrar stokta!',
                    time: '3 gün önce',
                    isRead: true,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Clear All Notifications
          Card(
            child: ListTile(
              leading: const Icon(Icons.clear_all, color: Colors.red),
              title: const Text(
                'Tüm Bildirimleri Temizle',
                style: TextStyle(color: Colors.red),
              ),
              subtitle: const Text('Okunmuş bildirimleri sil'),
              onTap: _clearAllNotifications,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: value ? Colors.red : Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required bool isRead,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isRead
                  ? Colors.grey.shade200
                  : Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: isRead ? Colors.grey : Colors.red,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                    fontSize: 14,
                    color: isRead ? Colors.grey.shade700 : Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          if (!isRead)
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _selectNotificationTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _notificationTime,
    );

    if (picked != null && picked != _notificationTime) {
      setState(() {
        _notificationTime = picked;
      });
      _saveNotificationSettings();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Bildirim saati ${picked.format(context)} olarak güncellendi'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _requestNotificationPermission() async {
    // Simulate permission request
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bildirim İzni'),
        content: const Text(
          'Günlük bildirimler alabilmek için bildirim izni gereklidir. '
          'Bu izni vermek istiyor musunuz?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _dailyNotificationsEnabled = false;
              });
            },
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bildirim izni verildi'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('İzin Ver'),
          ),
        ],
      ),
    );
  }

  void _clearAllNotifications() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bildirimleri Temizle'),
        content: const Text(
            'Tüm okunmuş bildirimleri silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => context.go('/profile'),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bildirimler temizlendi'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Temizle'),
          ),
        ],
      ),
    );
  }
}

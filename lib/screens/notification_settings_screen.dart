import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/daily_notification_provider.dart';

class NotificationSettingsScreen extends HookConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationState = ref.watch(dailyNotificationProvider);
    final notifier = ref.read(dailyNotificationProvider.notifier);

    // Time picker için state
    final selectedTime = useState(notificationState.dailyTime);

    // Switch'ler için state
    final dailyEnabled = useState(notificationState.dailyEnabled);
    final weeklyEnabled = useState(notificationState.weeklyEnabled);
    final monthlyEnabled = useState(notificationState.monthlyEnabled);

    // Ekran yüklendiğinde ayarları yükle
    useEffect(() {
      notifier.loadNotificationSettings();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildirim Ayarları'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Günlük Bildirimler
              _buildNotificationSection(
                title: '📅 Günlük Alışveriş Hatırlatmaları',
                subtitle:
                    'Her gün farklı teşvik mesajları ile alışveriş motivasyonu',
                enabled: dailyEnabled.value,
                onChanged: (value) {
                  dailyEnabled.value = value;
                  _updateSettings(
                      notifier,
                      dailyEnabled.value,
                      weeklyEnabled.value,
                      monthlyEnabled.value,
                      selectedTime.value);
                },
              ),

              if (dailyEnabled.value) ...[
                const SizedBox(height: 16),
                _buildTimePicker(
                  label: 'Bildirim Saati',
                  time: selectedTime.value,
                  onTimeChanged: (time) {
                    selectedTime.value = time;
                    _updateSettings(notifier, dailyEnabled.value,
                        weeklyEnabled.value, monthlyEnabled.value, time);
                  },
                ),
              ],

              const SizedBox(height: 24),

              // Haftalık Bildirimler
              _buildNotificationSection(
                title: '📊 Haftalık Alışveriş Özeti',
                subtitle: 'Haftalık alışveriş istatistikleri ve öneriler',
                enabled: weeklyEnabled.value,
                onChanged: (value) {
                  weeklyEnabled.value = value;
                  _updateSettings(
                      notifier,
                      dailyEnabled.value,
                      weeklyEnabled.value,
                      monthlyEnabled.value,
                      selectedTime.value);
                },
              ),

              const SizedBox(height: 24),

              // Aylık Bildirimler
              _buildNotificationSection(
                title: '📈 Aylık Alışveriş Raporu',
                subtitle: 'Aylık alışveriş analizi ve trendler',
                enabled: monthlyEnabled.value,
                onChanged: (value) {
                  monthlyEnabled.value = value;
                  _updateSettings(
                      notifier,
                      dailyEnabled.value,
                      weeklyEnabled.value,
                      monthlyEnabled.value,
                      selectedTime.value);
                },
              ),

              const SizedBox(height: 24),

              // Test Bildirimleri
              _buildTestNotificationsSection(notifier, notificationState),

              const SizedBox(height: 24),

              // Bildirim İstatistikleri
              if (notificationState.isInitialized)
                _buildNotificationStats(notificationState),

              // Hata mesajı
              if (notificationState.error != null &&
                  notificationState.error!.isNotEmpty)
                _buildErrorMessage(notificationState.error!, notifier),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationSection({
    required String title,
    required String subtitle,
    required bool enabled,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: enabled,
              onChanged: onChanged,
              activeThumbColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker({
    required String label,
    required String time,
    required ValueChanged<String> onTimeChanged,
  }) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: navigatorKey.currentContext!,
                  initialTime: _parseTimeString(time),
                );
                if (picked != null) {
                  final newTime =
                      '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                  onTimeChanged(newTime);
                }
              },
              icon: const Icon(Icons.access_time),
              label: Text(
                time,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestNotificationsSection(
      DailyNotificationNotifier notifier, DailyNotificationState state) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🧪 Test Bildirimleri',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: state.isLoading
                        ? null
                        : () => notifier.sendDailyNotification(),
                    icon: const Icon(Icons.notifications),
                    label: const Text('Günlük Bildirim'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: state.isLoading
                        ? null
                        : () => notifier.sendWeeklyNotification(),
                    icon: const Icon(Icons.weekend),
                    label: const Text('Haftalık Bildirim'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: state.isLoading
                    ? null
                    : () => notifier.sendMonthlyNotification(),
                icon: const Icon(Icons.calendar_month),
                label: const Text('Aylık Bildirim'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationStats(DailyNotificationState state) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📊 Bildirim İstatistikleri',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.notifications,
                    label: 'Günlük',
                    value: state.notificationCount.toString(),
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.weekend,
                    label: 'Haftalık',
                    value: state.weeklyNotificationCount.toString(),
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.calendar_month,
                    label: 'Aylık',
                    value: state.monthlyNotificationCount.toString(),
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            if (state.lastNotificationDate != null) ...[
              const SizedBox(height: 16),
              Text(
                'Son Bildirim: ${_formatDate(state.lastNotificationDate!)}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage(String error, DailyNotificationNotifier notifier) {
    return Card(
      color: Colors.red[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red[700],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                error,
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 14,
                ),
              ),
            ),
            IconButton(
              onPressed: () => notifier.clearError(),
              icon: Icon(
                Icons.close,
                color: Colors.red[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateSettings(
    DailyNotificationNotifier notifier,
    bool dailyEnabled,
    bool weeklyEnabled,
    bool monthlyEnabled,
    String dailyTime,
  ) {
    notifier.updateNotificationSettings(
      dailyEnabled: dailyEnabled,
      weeklyEnabled: weeklyEnabled,
      monthlyEnabled: monthlyEnabled,
      dailyTime: dailyTime,
    );
  }

  TimeOfDay _parseTimeString(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return '${date.day}/${date.month}/${date.year}';
  }
}

// Global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

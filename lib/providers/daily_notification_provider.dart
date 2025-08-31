import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/notification_service.dart';

part 'daily_notification_provider.freezed.dart';
part 'daily_notification_provider.g.dart'; // .g.dart dosyasını ekleyin

final dailyNotificationProvider =
    StateNotifierProvider<DailyNotificationNotifier, DailyNotificationState>(
        (ref) {
  return DailyNotificationNotifier();
});

class DailyNotificationNotifier extends StateNotifier<DailyNotificationState> {
  DailyNotificationNotifier() : super(const DailyNotificationState()) {
    _initializeNotifications();
  }

  // Bildirimleri başlat
  Future<void> _initializeNotifications() async {
    try {
      await NotificationService.initialize();
      await NotificationService.createNotificationChannel();

      // Günlük bildirimleri kontrol et
      await _checkAndScheduleDailyNotifications();

      state = state.copyWith(isInitialized: true);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // Günlük bildirimleri kontrol et ve planla
  Future<void> _checkAndScheduleDailyNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastNotificationDate =
          prefs.getString('last_daily_notification_date');
      final today =
          DateTime.now().toIso8601String().split('T')[0]; // YYYY-MM-DD formatı

      // Bugün bildirim gönderilmemişse
      if (lastNotificationDate != today) {
        // Günlük bildirimi gönder
        await NotificationService.showDailyShoppingReminderNotification();

        // Son bildirim tarihini güncelle
        await prefs.setString('last_daily_notification_date', today);

        state = state.copyWith(
          lastNotificationDate: today,
          notificationCount: state.notificationCount + 1,
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // Günlük bildirimi manuel olarak gönder
  Future<void> sendDailyNotification() async {
    try {
      state = state.copyWith(isLoading: true);

      await NotificationService.showDailyShoppingReminderNotification();

      final prefs = await SharedPreferences.getInstance();
      final today = DateTime.now().toIso8601String().split('T')[0];
      await prefs.setString('last_daily_notification_date', today);

      state = state.copyWith(
        lastNotificationDate: today,
        notificationCount: state.notificationCount + 1,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  // Haftalık bildirimi gönder
  Future<void> sendWeeklyNotification() async {
    try {
      state = state.copyWith(isLoading: true);

      await NotificationService.showWeeklyShoppingSummaryNotification();

      state = state.copyWith(
        weeklyNotificationCount: state.weeklyNotificationCount + 1,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  // Aylık bildirimi gönder
  Future<void> sendMonthlyNotification() async {
    try {
      state = state.copyWith(isLoading: true);

      await NotificationService.showMonthlyShoppingReportNotification();

      state = state.copyWith(
        monthlyNotificationCount: state.monthlyNotificationCount + 1,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  // Bildirim ayarlarını güncelle
  Future<void> updateNotificationSettings({
    required bool dailyEnabled,
    required bool weeklyEnabled,
    required bool monthlyEnabled,
    required String dailyTime,
  }) async {
    try {
      state = state.copyWith(isLoading: true);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('daily_notifications_enabled', dailyEnabled);
      await prefs.setBool('weekly_notifications_enabled', weeklyEnabled);
      await prefs.setBool('monthly_notifications_enabled', monthlyEnabled);
      await prefs.setString('daily_notification_time', dailyTime);

      state = state.copyWith(
        dailyEnabled: dailyEnabled,
        weeklyEnabled: weeklyEnabled,
        monthlyEnabled: monthlyEnabled,
        dailyTime: dailyTime,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  // Bildirim ayarlarını yükle
  Future<void> loadNotificationSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final dailyEnabled = prefs.getBool('daily_notifications_enabled') ?? true;
      final weeklyEnabled =
          prefs.getBool('weekly_notifications_enabled') ?? true;
      final monthlyEnabled =
          prefs.getBool('monthly_notifications_enabled') ?? true;
      final dailyTime = prefs.getString('daily_notification_time') ?? '09:00';
      final lastNotificationDate =
          prefs.getString('last_daily_notification_date');
      final notificationCount = prefs.getInt('daily_notification_count') ?? 0;
      final weeklyNotificationCount =
          prefs.getInt('weekly_notification_count') ?? 0;
      final monthlyNotificationCount =
          prefs.getInt('monthly_notification_count') ?? 0;

      state = state.copyWith(
        dailyEnabled: dailyEnabled,
        weeklyEnabled: weeklyEnabled,
        monthlyEnabled: monthlyEnabled,
        dailyTime: dailyTime,
        lastNotificationDate: lastNotificationDate,
        notificationCount: notificationCount,
        weeklyNotificationCount: weeklyNotificationCount,
        monthlyNotificationCount: monthlyNotificationCount,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // Bildirimleri temizle
  Future<void> clearAllNotifications() async {
    try {
      await NotificationService.clearAllNotifications();
      state = state.copyWith(
        notificationCount: 0,
        weeklyNotificationCount: 0,
        monthlyNotificationCount: 0,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // Hata durumunu temizle
  void clearError() {
    state = state.copyWith(error: null);
  }

  // Durumu sıfırla
  void resetState() {
    state = const DailyNotificationState();
  }
}

@freezed
class DailyNotificationState with _$DailyNotificationState {
  const factory DailyNotificationState({
    @Default(false) bool isInitialized,
    @Default(false) bool isLoading,
    @Default(true) bool dailyEnabled,
    @Default(true) bool weeklyEnabled,
    @Default(true) bool monthlyEnabled,
    @Default('09:00') String dailyTime,
    String? lastNotificationDate,
    @Default(0) int notificationCount,
    @Default(0) int weeklyNotificationCount,
    @Default(0) int monthlyNotificationCount,
    String? error,
  }) = _DailyNotificationState;

  factory DailyNotificationState.fromJson(Map<String, dynamic> json) =>
      _$DailyNotificationStateFromJson(json);
}

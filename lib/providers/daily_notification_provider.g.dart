// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_notification_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyNotificationStateImpl _$$DailyNotificationStateImplFromJson(
        Map<String, dynamic> json) =>
    _$DailyNotificationStateImpl(
      isInitialized: json['isInitialized'] as bool? ?? false,
      isLoading: json['isLoading'] as bool? ?? false,
      dailyEnabled: json['dailyEnabled'] as bool? ?? true,
      weeklyEnabled: json['weeklyEnabled'] as bool? ?? true,
      monthlyEnabled: json['monthlyEnabled'] as bool? ?? true,
      dailyTime: json['dailyTime'] as String? ?? '09:00',
      lastNotificationDate: json['lastNotificationDate'] as String?,
      notificationCount: (json['notificationCount'] as num?)?.toInt() ?? 0,
      weeklyNotificationCount:
          (json['weeklyNotificationCount'] as num?)?.toInt() ?? 0,
      monthlyNotificationCount:
          (json['monthlyNotificationCount'] as num?)?.toInt() ?? 0,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$DailyNotificationStateImplToJson(
        _$DailyNotificationStateImpl instance) =>
    <String, dynamic>{
      'isInitialized': instance.isInitialized,
      'isLoading': instance.isLoading,
      'dailyEnabled': instance.dailyEnabled,
      'weeklyEnabled': instance.weeklyEnabled,
      'monthlyEnabled': instance.monthlyEnabled,
      'dailyTime': instance.dailyTime,
      'lastNotificationDate': instance.lastNotificationDate,
      'notificationCount': instance.notificationCount,
      'weeklyNotificationCount': instance.weeklyNotificationCount,
      'monthlyNotificationCount': instance.monthlyNotificationCount,
      'error': instance.error,
    };

import 'package:freezed_annotation/freezed_annotation.dart';
import 'payment_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String fullName,
    String? phone,
    String? avatarUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isDeleted,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String email,
    required String fullName,
    String? phone,
    String? avatarUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isDeleted,
    @Default([]) List<DeliveryAddress> addresses,
    @Default([]) List<PaymentMethod> paymentMethods,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) {
  return _PaymentMethod.fromJson(json);
}

/// @nodoc
mixin _$PaymentMethod {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get cardType => throw _privateConstructorUsedError;
  String get cardNumber => throw _privateConstructorUsedError;
  String get cardHolder => throw _privateConstructorUsedError;
  String get expiryMonth => throw _privateConstructorUsedError;
  String get expiryYear => throw _privateConstructorUsedError;
  String? get cvvHash => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this PaymentMethod to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentMethodCopyWith<PaymentMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentMethodCopyWith<$Res> {
  factory $PaymentMethodCopyWith(
          PaymentMethod value, $Res Function(PaymentMethod) then) =
      _$PaymentMethodCopyWithImpl<$Res, PaymentMethod>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String cardType,
      String cardNumber,
      String cardHolder,
      String expiryMonth,
      String expiryYear,
      String? cvvHash,
      bool isDefault,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt,
      bool isDeleted});
}

/// @nodoc
class _$PaymentMethodCopyWithImpl<$Res, $Val extends PaymentMethod>
    implements $PaymentMethodCopyWith<$Res> {
  _$PaymentMethodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? cardType = null,
    Object? cardNumber = null,
    Object? cardHolder = null,
    Object? expiryMonth = null,
    Object? expiryYear = null,
    Object? cvvHash = freezed,
    Object? isDefault = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      cardType: null == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as String,
      cardNumber: null == cardNumber
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String,
      cardHolder: null == cardHolder
          ? _value.cardHolder
          : cardHolder // ignore: cast_nullable_to_non_nullable
              as String,
      expiryMonth: null == expiryMonth
          ? _value.expiryMonth
          : expiryMonth // ignore: cast_nullable_to_non_nullable
              as String,
      expiryYear: null == expiryYear
          ? _value.expiryYear
          : expiryYear // ignore: cast_nullable_to_non_nullable
              as String,
      cvvHash: freezed == cvvHash
          ? _value.cvvHash
          : cvvHash // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentMethodImplCopyWith<$Res>
    implements $PaymentMethodCopyWith<$Res> {
  factory _$$PaymentMethodImplCopyWith(
          _$PaymentMethodImpl value, $Res Function(_$PaymentMethodImpl) then) =
      __$$PaymentMethodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String cardType,
      String cardNumber,
      String cardHolder,
      String expiryMonth,
      String expiryYear,
      String? cvvHash,
      bool isDefault,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt,
      bool isDeleted});
}

/// @nodoc
class __$$PaymentMethodImplCopyWithImpl<$Res>
    extends _$PaymentMethodCopyWithImpl<$Res, _$PaymentMethodImpl>
    implements _$$PaymentMethodImplCopyWith<$Res> {
  __$$PaymentMethodImplCopyWithImpl(
      _$PaymentMethodImpl _value, $Res Function(_$PaymentMethodImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? cardType = null,
    Object? cardNumber = null,
    Object? cardHolder = null,
    Object? expiryMonth = null,
    Object? expiryYear = null,
    Object? cvvHash = freezed,
    Object? isDefault = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_$PaymentMethodImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      cardType: null == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as String,
      cardNumber: null == cardNumber
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String,
      cardHolder: null == cardHolder
          ? _value.cardHolder
          : cardHolder // ignore: cast_nullable_to_non_nullable
              as String,
      expiryMonth: null == expiryMonth
          ? _value.expiryMonth
          : expiryMonth // ignore: cast_nullable_to_non_nullable
              as String,
      expiryYear: null == expiryYear
          ? _value.expiryYear
          : expiryYear // ignore: cast_nullable_to_non_nullable
              as String,
      cvvHash: freezed == cvvHash
          ? _value.cvvHash
          : cvvHash // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentMethodImpl implements _PaymentMethod {
  const _$PaymentMethodImpl(
      {required this.id,
      required this.userId,
      required this.cardType,
      required this.cardNumber,
      required this.cardHolder,
      required this.expiryMonth,
      required this.expiryYear,
      this.cvvHash,
      this.isDefault = false,
      this.isActive = true,
      required this.createdAt,
      required this.updatedAt,
      this.isDeleted = false});

  factory _$PaymentMethodImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentMethodImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String cardType;
  @override
  final String cardNumber;
  @override
  final String cardHolder;
  @override
  final String expiryMonth;
  @override
  final String expiryYear;
  @override
  final String? cvvHash;
  @override
  @JsonKey()
  final bool isDefault;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'PaymentMethod(id: $id, userId: $userId, cardType: $cardType, cardNumber: $cardNumber, cardHolder: $cardHolder, expiryMonth: $expiryMonth, expiryYear: $expiryYear, cvvHash: $cvvHash, isDefault: $isDefault, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentMethodImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.cardType, cardType) ||
                other.cardType == cardType) &&
            (identical(other.cardNumber, cardNumber) ||
                other.cardNumber == cardNumber) &&
            (identical(other.cardHolder, cardHolder) ||
                other.cardHolder == cardHolder) &&
            (identical(other.expiryMonth, expiryMonth) ||
                other.expiryMonth == expiryMonth) &&
            (identical(other.expiryYear, expiryYear) ||
                other.expiryYear == expiryYear) &&
            (identical(other.cvvHash, cvvHash) || other.cvvHash == cvvHash) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      cardType,
      cardNumber,
      cardHolder,
      expiryMonth,
      expiryYear,
      cvvHash,
      isDefault,
      isActive,
      createdAt,
      updatedAt,
      isDeleted);

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentMethodImplCopyWith<_$PaymentMethodImpl> get copyWith =>
      __$$PaymentMethodImplCopyWithImpl<_$PaymentMethodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentMethodImplToJson(
      this,
    );
  }
}

abstract class _PaymentMethod implements PaymentMethod {
  const factory _PaymentMethod(
      {required final String id,
      required final String userId,
      required final String cardType,
      required final String cardNumber,
      required final String cardHolder,
      required final String expiryMonth,
      required final String expiryYear,
      final String? cvvHash,
      final bool isDefault,
      final bool isActive,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final bool isDeleted}) = _$PaymentMethodImpl;

  factory _PaymentMethod.fromJson(Map<String, dynamic> json) =
      _$PaymentMethodImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get cardType;
  @override
  String get cardNumber;
  @override
  String get cardHolder;
  @override
  String get expiryMonth;
  @override
  String get expiryYear;
  @override
  String? get cvvHash;
  @override
  bool get isDefault;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  bool get isDeleted;

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentMethodImplCopyWith<_$PaymentMethodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeliveryAddress _$DeliveryAddressFromJson(Map<String, dynamic> json) {
  return _DeliveryAddress.fromJson(json);
}

/// @nodoc
mixin _$DeliveryAddress {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get district => throw _privateConstructorUsedError;
  String get neighborhood => throw _privateConstructorUsedError;
  String get street => throw _privateConstructorUsedError;
  String get buildingNo => throw _privateConstructorUsedError;
  String get apartmentNo => throw _privateConstructorUsedError;
  String get postalCode => throw _privateConstructorUsedError;
  String? get addressNote => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this DeliveryAddress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeliveryAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeliveryAddressCopyWith<DeliveryAddress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliveryAddressCopyWith<$Res> {
  factory $DeliveryAddressCopyWith(
          DeliveryAddress value, $Res Function(DeliveryAddress) then) =
      _$DeliveryAddressCopyWithImpl<$Res, DeliveryAddress>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String fullName,
      String phone,
      String city,
      String district,
      String neighborhood,
      String street,
      String buildingNo,
      String apartmentNo,
      String postalCode,
      String? addressNote,
      bool isDefault,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt,
      bool isDeleted});
}

/// @nodoc
class _$DeliveryAddressCopyWithImpl<$Res, $Val extends DeliveryAddress>
    implements $DeliveryAddressCopyWith<$Res> {
  _$DeliveryAddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeliveryAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? fullName = null,
    Object? phone = null,
    Object? city = null,
    Object? district = null,
    Object? neighborhood = null,
    Object? street = null,
    Object? buildingNo = null,
    Object? apartmentNo = null,
    Object? postalCode = null,
    Object? addressNote = freezed,
    Object? isDefault = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      district: null == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String,
      neighborhood: null == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String,
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      buildingNo: null == buildingNo
          ? _value.buildingNo
          : buildingNo // ignore: cast_nullable_to_non_nullable
              as String,
      apartmentNo: null == apartmentNo
          ? _value.apartmentNo
          : apartmentNo // ignore: cast_nullable_to_non_nullable
              as String,
      postalCode: null == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
      addressNote: freezed == addressNote
          ? _value.addressNote
          : addressNote // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeliveryAddressImplCopyWith<$Res>
    implements $DeliveryAddressCopyWith<$Res> {
  factory _$$DeliveryAddressImplCopyWith(_$DeliveryAddressImpl value,
          $Res Function(_$DeliveryAddressImpl) then) =
      __$$DeliveryAddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String fullName,
      String phone,
      String city,
      String district,
      String neighborhood,
      String street,
      String buildingNo,
      String apartmentNo,
      String postalCode,
      String? addressNote,
      bool isDefault,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt,
      bool isDeleted});
}

/// @nodoc
class __$$DeliveryAddressImplCopyWithImpl<$Res>
    extends _$DeliveryAddressCopyWithImpl<$Res, _$DeliveryAddressImpl>
    implements _$$DeliveryAddressImplCopyWith<$Res> {
  __$$DeliveryAddressImplCopyWithImpl(
      _$DeliveryAddressImpl _value, $Res Function(_$DeliveryAddressImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeliveryAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? fullName = null,
    Object? phone = null,
    Object? city = null,
    Object? district = null,
    Object? neighborhood = null,
    Object? street = null,
    Object? buildingNo = null,
    Object? apartmentNo = null,
    Object? postalCode = null,
    Object? addressNote = freezed,
    Object? isDefault = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_$DeliveryAddressImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      district: null == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String,
      neighborhood: null == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String,
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      buildingNo: null == buildingNo
          ? _value.buildingNo
          : buildingNo // ignore: cast_nullable_to_non_nullable
              as String,
      apartmentNo: null == apartmentNo
          ? _value.apartmentNo
          : apartmentNo // ignore: cast_nullable_to_non_nullable
              as String,
      postalCode: null == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
      addressNote: freezed == addressNote
          ? _value.addressNote
          : addressNote // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeliveryAddressImpl implements _DeliveryAddress {
  const _$DeliveryAddressImpl(
      {required this.id,
      required this.userId,
      required this.fullName,
      required this.phone,
      required this.city,
      required this.district,
      required this.neighborhood,
      required this.street,
      required this.buildingNo,
      required this.apartmentNo,
      required this.postalCode,
      this.addressNote,
      this.isDefault = false,
      this.isActive = true,
      required this.createdAt,
      required this.updatedAt,
      this.isDeleted = false});

  factory _$DeliveryAddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeliveryAddressImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String fullName;
  @override
  final String phone;
  @override
  final String city;
  @override
  final String district;
  @override
  final String neighborhood;
  @override
  final String street;
  @override
  final String buildingNo;
  @override
  final String apartmentNo;
  @override
  final String postalCode;
  @override
  final String? addressNote;
  @override
  @JsonKey()
  final bool isDefault;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'DeliveryAddress(id: $id, userId: $userId, fullName: $fullName, phone: $phone, city: $city, district: $district, neighborhood: $neighborhood, street: $street, buildingNo: $buildingNo, apartmentNo: $apartmentNo, postalCode: $postalCode, addressNote: $addressNote, isDefault: $isDefault, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliveryAddressImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.neighborhood, neighborhood) ||
                other.neighborhood == neighborhood) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.buildingNo, buildingNo) ||
                other.buildingNo == buildingNo) &&
            (identical(other.apartmentNo, apartmentNo) ||
                other.apartmentNo == apartmentNo) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.addressNote, addressNote) ||
                other.addressNote == addressNote) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      fullName,
      phone,
      city,
      district,
      neighborhood,
      street,
      buildingNo,
      apartmentNo,
      postalCode,
      addressNote,
      isDefault,
      isActive,
      createdAt,
      updatedAt,
      isDeleted);

  /// Create a copy of DeliveryAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliveryAddressImplCopyWith<_$DeliveryAddressImpl> get copyWith =>
      __$$DeliveryAddressImplCopyWithImpl<_$DeliveryAddressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeliveryAddressImplToJson(
      this,
    );
  }
}

abstract class _DeliveryAddress implements DeliveryAddress {
  const factory _DeliveryAddress(
      {required final String id,
      required final String userId,
      required final String fullName,
      required final String phone,
      required final String city,
      required final String district,
      required final String neighborhood,
      required final String street,
      required final String buildingNo,
      required final String apartmentNo,
      required final String postalCode,
      final String? addressNote,
      final bool isDefault,
      final bool isActive,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final bool isDeleted}) = _$DeliveryAddressImpl;

  factory _DeliveryAddress.fromJson(Map<String, dynamic> json) =
      _$DeliveryAddressImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get fullName;
  @override
  String get phone;
  @override
  String get city;
  @override
  String get district;
  @override
  String get neighborhood;
  @override
  String get street;
  @override
  String get buildingNo;
  @override
  String get apartmentNo;
  @override
  String get postalCode;
  @override
  String? get addressNote;
  @override
  bool get isDefault;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  bool get isDeleted;

  /// Create a copy of DeliveryAddress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliveryAddressImplCopyWith<_$DeliveryAddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentIntent _$PaymentIntentFromJson(Map<String, dynamic> json) {
  return _PaymentIntent.fromJson(json);
}

/// @nodoc
mixin _$PaymentIntent {
  String get id => throw _privateConstructorUsedError;
  String get clientSecret => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get paymentMethodId => throw _privateConstructorUsedError;

  /// Serializes this PaymentIntent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentIntent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentIntentCopyWith<PaymentIntent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentIntentCopyWith<$Res> {
  factory $PaymentIntentCopyWith(
          PaymentIntent value, $Res Function(PaymentIntent) then) =
      _$PaymentIntentCopyWithImpl<$Res, PaymentIntent>;
  @useResult
  $Res call(
      {String id,
      String clientSecret,
      double amount,
      String currency,
      String status,
      String? paymentMethodId});
}

/// @nodoc
class _$PaymentIntentCopyWithImpl<$Res, $Val extends PaymentIntent>
    implements $PaymentIntentCopyWith<$Res> {
  _$PaymentIntentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentIntent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientSecret = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? paymentMethodId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientSecret: null == clientSecret
          ? _value.clientSecret
          : clientSecret // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethodId: freezed == paymentMethodId
          ? _value.paymentMethodId
          : paymentMethodId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentIntentImplCopyWith<$Res>
    implements $PaymentIntentCopyWith<$Res> {
  factory _$$PaymentIntentImplCopyWith(
          _$PaymentIntentImpl value, $Res Function(_$PaymentIntentImpl) then) =
      __$$PaymentIntentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String clientSecret,
      double amount,
      String currency,
      String status,
      String? paymentMethodId});
}

/// @nodoc
class __$$PaymentIntentImplCopyWithImpl<$Res>
    extends _$PaymentIntentCopyWithImpl<$Res, _$PaymentIntentImpl>
    implements _$$PaymentIntentImplCopyWith<$Res> {
  __$$PaymentIntentImplCopyWithImpl(
      _$PaymentIntentImpl _value, $Res Function(_$PaymentIntentImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentIntent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientSecret = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? paymentMethodId = freezed,
  }) {
    return _then(_$PaymentIntentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientSecret: null == clientSecret
          ? _value.clientSecret
          : clientSecret // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethodId: freezed == paymentMethodId
          ? _value.paymentMethodId
          : paymentMethodId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentIntentImpl implements _PaymentIntent {
  const _$PaymentIntentImpl(
      {required this.id,
      required this.clientSecret,
      required this.amount,
      required this.currency,
      required this.status,
      this.paymentMethodId});

  factory _$PaymentIntentImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentIntentImplFromJson(json);

  @override
  final String id;
  @override
  final String clientSecret;
  @override
  final double amount;
  @override
  final String currency;
  @override
  final String status;
  @override
  final String? paymentMethodId;

  @override
  String toString() {
    return 'PaymentIntent(id: $id, clientSecret: $clientSecret, amount: $amount, currency: $currency, status: $status, paymentMethodId: $paymentMethodId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentIntentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientSecret, clientSecret) ||
                other.clientSecret == clientSecret) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentMethodId, paymentMethodId) ||
                other.paymentMethodId == paymentMethodId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, clientSecret, amount, currency, status, paymentMethodId);

  /// Create a copy of PaymentIntent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentIntentImplCopyWith<_$PaymentIntentImpl> get copyWith =>
      __$$PaymentIntentImplCopyWithImpl<_$PaymentIntentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentIntentImplToJson(
      this,
    );
  }
}

abstract class _PaymentIntent implements PaymentIntent {
  const factory _PaymentIntent(
      {required final String id,
      required final String clientSecret,
      required final double amount,
      required final String currency,
      required final String status,
      final String? paymentMethodId}) = _$PaymentIntentImpl;

  factory _PaymentIntent.fromJson(Map<String, dynamic> json) =
      _$PaymentIntentImpl.fromJson;

  @override
  String get id;
  @override
  String get clientSecret;
  @override
  double get amount;
  @override
  String get currency;
  @override
  String get status;
  @override
  String? get paymentMethodId;

  /// Create a copy of PaymentIntent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentIntentImplCopyWith<_$PaymentIntentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

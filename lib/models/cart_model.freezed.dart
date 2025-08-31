// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CartItem _$CartItemFromJson(Map<String, dynamic> json) {
  return _CartItem.fromJson(json);
}

/// @nodoc
mixin _$CartItem {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this CartItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CartItemCopyWith<CartItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartItemCopyWith<$Res> {
  factory $CartItemCopyWith(CartItem value, $Res Function(CartItem) then) =
      _$CartItemCopyWithImpl<$Res, CartItem>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String productId,
      int quantity,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$CartItemCopyWithImpl<$Res, $Val extends CartItem>
    implements $CartItemCopyWith<$Res> {
  _$CartItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CartItemImplCopyWith<$Res>
    implements $CartItemCopyWith<$Res> {
  factory _$$CartItemImplCopyWith(
          _$CartItemImpl value, $Res Function(_$CartItemImpl) then) =
      __$$CartItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String productId,
      int quantity,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$CartItemImplCopyWithImpl<$Res>
    extends _$CartItemCopyWithImpl<$Res, _$CartItemImpl>
    implements _$$CartItemImplCopyWith<$Res> {
  __$$CartItemImplCopyWithImpl(
      _$CartItemImpl _value, $Res Function(_$CartItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$CartItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CartItemImpl implements _CartItem {
  const _$CartItemImpl(
      {required this.id,
      required this.userId,
      required this.productId,
      required this.quantity,
      required this.createdAt,
      required this.updatedAt});

  factory _$CartItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartItemImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String productId;
  @override
  final int quantity;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'CartItem(id: $id, userId: $userId, productId: $productId, quantity: $quantity, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, productId, quantity, createdAt, updatedAt);

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      __$$CartItemImplCopyWithImpl<_$CartItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartItemImplToJson(
      this,
    );
  }
}

abstract class _CartItem implements CartItem {
  const factory _CartItem(
      {required final String id,
      required final String userId,
      required final String productId,
      required final int quantity,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$CartItemImpl;

  factory _CartItem.fromJson(Map<String, dynamic> json) =
      _$CartItemImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get productId;
  @override
  int get quantity;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CartItemWithProduct _$CartItemWithProductFromJson(Map<String, dynamic> json) {
  return _CartItemWithProduct.fromJson(json);
}

/// @nodoc
mixin _$CartItemWithProduct {
  CartItem get cartItem => throw _privateConstructorUsedError;
  Product get product => throw _privateConstructorUsedError;

  /// Serializes this CartItemWithProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CartItemWithProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CartItemWithProductCopyWith<CartItemWithProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartItemWithProductCopyWith<$Res> {
  factory $CartItemWithProductCopyWith(
          CartItemWithProduct value, $Res Function(CartItemWithProduct) then) =
      _$CartItemWithProductCopyWithImpl<$Res, CartItemWithProduct>;
  @useResult
  $Res call({CartItem cartItem, Product product});

  $CartItemCopyWith<$Res> get cartItem;
  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class _$CartItemWithProductCopyWithImpl<$Res, $Val extends CartItemWithProduct>
    implements $CartItemWithProductCopyWith<$Res> {
  _$CartItemWithProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CartItemWithProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cartItem = null,
    Object? product = null,
  }) {
    return _then(_value.copyWith(
      cartItem: null == cartItem
          ? _value.cartItem
          : cartItem // ignore: cast_nullable_to_non_nullable
              as CartItem,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ) as $Val);
  }

  /// Create a copy of CartItemWithProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CartItemCopyWith<$Res> get cartItem {
    return $CartItemCopyWith<$Res>(_value.cartItem, (value) {
      return _then(_value.copyWith(cartItem: value) as $Val);
    });
  }

  /// Create a copy of CartItemWithProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CartItemWithProductImplCopyWith<$Res>
    implements $CartItemWithProductCopyWith<$Res> {
  factory _$$CartItemWithProductImplCopyWith(_$CartItemWithProductImpl value,
          $Res Function(_$CartItemWithProductImpl) then) =
      __$$CartItemWithProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CartItem cartItem, Product product});

  @override
  $CartItemCopyWith<$Res> get cartItem;
  @override
  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class __$$CartItemWithProductImplCopyWithImpl<$Res>
    extends _$CartItemWithProductCopyWithImpl<$Res, _$CartItemWithProductImpl>
    implements _$$CartItemWithProductImplCopyWith<$Res> {
  __$$CartItemWithProductImplCopyWithImpl(_$CartItemWithProductImpl _value,
      $Res Function(_$CartItemWithProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of CartItemWithProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cartItem = null,
    Object? product = null,
  }) {
    return _then(_$CartItemWithProductImpl(
      cartItem: null == cartItem
          ? _value.cartItem
          : cartItem // ignore: cast_nullable_to_non_nullable
              as CartItem,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CartItemWithProductImpl implements _CartItemWithProduct {
  const _$CartItemWithProductImpl(
      {required this.cartItem, required this.product});

  factory _$CartItemWithProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartItemWithProductImplFromJson(json);

  @override
  final CartItem cartItem;
  @override
  final Product product;

  @override
  String toString() {
    return 'CartItemWithProduct(cartItem: $cartItem, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartItemWithProductImpl &&
            (identical(other.cartItem, cartItem) ||
                other.cartItem == cartItem) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, cartItem, product);

  /// Create a copy of CartItemWithProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartItemWithProductImplCopyWith<_$CartItemWithProductImpl> get copyWith =>
      __$$CartItemWithProductImplCopyWithImpl<_$CartItemWithProductImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartItemWithProductImplToJson(
      this,
    );
  }
}

abstract class _CartItemWithProduct implements CartItemWithProduct {
  const factory _CartItemWithProduct(
      {required final CartItem cartItem,
      required final Product product}) = _$CartItemWithProductImpl;

  factory _CartItemWithProduct.fromJson(Map<String, dynamic> json) =
      _$CartItemWithProductImpl.fromJson;

  @override
  CartItem get cartItem;
  @override
  Product get product;

  /// Create a copy of CartItemWithProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartItemWithProductImplCopyWith<_$CartItemWithProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

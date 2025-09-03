// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SalesModel _$SalesModelFromJson(Map<String, dynamic> json) {
  return _SalesModel.fromJson(json);
}

/// @nodoc
mixin _$SalesModel {
  String get id => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  String get customerName => throw _privateConstructorUsedError;
  String get customerEmail => throw _privateConstructorUsedError;
  String get customerPhone => throw _privateConstructorUsedError;
  String get paymentMethod => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // 'pending', 'completed', 'cancelled'
  DateTime get saleDate => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this SalesModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesModelCopyWith<SalesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesModelCopyWith<$Res> {
  factory $SalesModelCopyWith(
          SalesModel value, $Res Function(SalesModel) then) =
      _$SalesModelCopyWithImpl<$Res, SalesModel>;
  @useResult
  $Res call(
      {String id,
      String productId,
      String productName,
      double price,
      int quantity,
      double totalAmount,
      String customerName,
      String customerEmail,
      String customerPhone,
      String paymentMethod,
      String status,
      DateTime saleDate,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$SalesModelCopyWithImpl<$Res, $Val extends SalesModel>
    implements $SalesModelCopyWith<$Res> {
  _$SalesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? productName = null,
    Object? price = null,
    Object? quantity = null,
    Object? totalAmount = null,
    Object? customerName = null,
    Object? customerEmail = null,
    Object? customerPhone = null,
    Object? paymentMethod = null,
    Object? status = null,
    Object? saleDate = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      customerEmail: null == customerEmail
          ? _value.customerEmail
          : customerEmail // ignore: cast_nullable_to_non_nullable
              as String,
      customerPhone: null == customerPhone
          ? _value.customerPhone
          : customerPhone // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      saleDate: null == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
abstract class _$$SalesModelImplCopyWith<$Res>
    implements $SalesModelCopyWith<$Res> {
  factory _$$SalesModelImplCopyWith(
          _$SalesModelImpl value, $Res Function(_$SalesModelImpl) then) =
      __$$SalesModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String productId,
      String productName,
      double price,
      int quantity,
      double totalAmount,
      String customerName,
      String customerEmail,
      String customerPhone,
      String paymentMethod,
      String status,
      DateTime saleDate,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$SalesModelImplCopyWithImpl<$Res>
    extends _$SalesModelCopyWithImpl<$Res, _$SalesModelImpl>
    implements _$$SalesModelImplCopyWith<$Res> {
  __$$SalesModelImplCopyWithImpl(
      _$SalesModelImpl _value, $Res Function(_$SalesModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? productName = null,
    Object? price = null,
    Object? quantity = null,
    Object? totalAmount = null,
    Object? customerName = null,
    Object? customerEmail = null,
    Object? customerPhone = null,
    Object? paymentMethod = null,
    Object? status = null,
    Object? saleDate = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$SalesModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      customerEmail: null == customerEmail
          ? _value.customerEmail
          : customerEmail // ignore: cast_nullable_to_non_nullable
              as String,
      customerPhone: null == customerPhone
          ? _value.customerPhone
          : customerPhone // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      saleDate: null == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
class _$SalesModelImpl implements _SalesModel {
  const _$SalesModelImpl(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.price,
      required this.quantity,
      required this.totalAmount,
      required this.customerName,
      required this.customerEmail,
      required this.customerPhone,
      required this.paymentMethod,
      required this.status,
      required this.saleDate,
      required this.createdAt,
      required this.updatedAt});

  factory _$SalesModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesModelImplFromJson(json);

  @override
  final String id;
  @override
  final String productId;
  @override
  final String productName;
  @override
  final double price;
  @override
  final int quantity;
  @override
  final double totalAmount;
  @override
  final String customerName;
  @override
  final String customerEmail;
  @override
  final String customerPhone;
  @override
  final String paymentMethod;
  @override
  final String status;
// 'pending', 'completed', 'cancelled'
  @override
  final DateTime saleDate;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'SalesModel(id: $id, productId: $productId, productName: $productName, price: $price, quantity: $quantity, totalAmount: $totalAmount, customerName: $customerName, customerEmail: $customerEmail, customerPhone: $customerPhone, paymentMethod: $paymentMethod, status: $status, saleDate: $saleDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerEmail, customerEmail) ||
                other.customerEmail == customerEmail) &&
            (identical(other.customerPhone, customerPhone) ||
                other.customerPhone == customerPhone) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.saleDate, saleDate) ||
                other.saleDate == saleDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      productId,
      productName,
      price,
      quantity,
      totalAmount,
      customerName,
      customerEmail,
      customerPhone,
      paymentMethod,
      status,
      saleDate,
      createdAt,
      updatedAt);

  /// Create a copy of SalesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesModelImplCopyWith<_$SalesModelImpl> get copyWith =>
      __$$SalesModelImplCopyWithImpl<_$SalesModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesModelImplToJson(
      this,
    );
  }
}

abstract class _SalesModel implements SalesModel {
  const factory _SalesModel(
      {required final String id,
      required final String productId,
      required final String productName,
      required final double price,
      required final int quantity,
      required final double totalAmount,
      required final String customerName,
      required final String customerEmail,
      required final String customerPhone,
      required final String paymentMethod,
      required final String status,
      required final DateTime saleDate,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$SalesModelImpl;

  factory _SalesModel.fromJson(Map<String, dynamic> json) =
      _$SalesModelImpl.fromJson;

  @override
  String get id;
  @override
  String get productId;
  @override
  String get productName;
  @override
  double get price;
  @override
  int get quantity;
  @override
  double get totalAmount;
  @override
  String get customerName;
  @override
  String get customerEmail;
  @override
  String get customerPhone;
  @override
  String get paymentMethod;
  @override
  String get status; // 'pending', 'completed', 'cancelled'
  @override
  DateTime get saleDate;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of SalesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesModelImplCopyWith<_$SalesModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SalesReportModel _$SalesReportModelFromJson(Map<String, dynamic> json) {
  return _SalesReportModel.fromJson(json);
}

/// @nodoc
mixin _$SalesReportModel {
  DateTime get date => throw _privateConstructorUsedError;
  double get totalSales => throw _privateConstructorUsedError;
  int get totalOrders => throw _privateConstructorUsedError;
  int get totalProducts => throw _privateConstructorUsedError;
  List<SalesModel> get sales => throw _privateConstructorUsedError;

  /// Serializes this SalesReportModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalesReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesReportModelCopyWith<SalesReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesReportModelCopyWith<$Res> {
  factory $SalesReportModelCopyWith(
          SalesReportModel value, $Res Function(SalesReportModel) then) =
      _$SalesReportModelCopyWithImpl<$Res, SalesReportModel>;
  @useResult
  $Res call(
      {DateTime date,
      double totalSales,
      int totalOrders,
      int totalProducts,
      List<SalesModel> sales});
}

/// @nodoc
class _$SalesReportModelCopyWithImpl<$Res, $Val extends SalesReportModel>
    implements $SalesReportModelCopyWith<$Res> {
  _$SalesReportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? totalSales = null,
    Object? totalOrders = null,
    Object? totalProducts = null,
    Object? sales = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalSales: null == totalSales
          ? _value.totalSales
          : totalSales // ignore: cast_nullable_to_non_nullable
              as double,
      totalOrders: null == totalOrders
          ? _value.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int,
      totalProducts: null == totalProducts
          ? _value.totalProducts
          : totalProducts // ignore: cast_nullable_to_non_nullable
              as int,
      sales: null == sales
          ? _value.sales
          : sales // ignore: cast_nullable_to_non_nullable
              as List<SalesModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalesReportModelImplCopyWith<$Res>
    implements $SalesReportModelCopyWith<$Res> {
  factory _$$SalesReportModelImplCopyWith(_$SalesReportModelImpl value,
          $Res Function(_$SalesReportModelImpl) then) =
      __$$SalesReportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      double totalSales,
      int totalOrders,
      int totalProducts,
      List<SalesModel> sales});
}

/// @nodoc
class __$$SalesReportModelImplCopyWithImpl<$Res>
    extends _$SalesReportModelCopyWithImpl<$Res, _$SalesReportModelImpl>
    implements _$$SalesReportModelImplCopyWith<$Res> {
  __$$SalesReportModelImplCopyWithImpl(_$SalesReportModelImpl _value,
      $Res Function(_$SalesReportModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? totalSales = null,
    Object? totalOrders = null,
    Object? totalProducts = null,
    Object? sales = null,
  }) {
    return _then(_$SalesReportModelImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalSales: null == totalSales
          ? _value.totalSales
          : totalSales // ignore: cast_nullable_to_non_nullable
              as double,
      totalOrders: null == totalOrders
          ? _value.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int,
      totalProducts: null == totalProducts
          ? _value.totalProducts
          : totalProducts // ignore: cast_nullable_to_non_nullable
              as int,
      sales: null == sales
          ? _value._sales
          : sales // ignore: cast_nullable_to_non_nullable
              as List<SalesModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesReportModelImpl implements _SalesReportModel {
  const _$SalesReportModelImpl(
      {required this.date,
      required this.totalSales,
      required this.totalOrders,
      required this.totalProducts,
      required final List<SalesModel> sales})
      : _sales = sales;

  factory _$SalesReportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesReportModelImplFromJson(json);

  @override
  final DateTime date;
  @override
  final double totalSales;
  @override
  final int totalOrders;
  @override
  final int totalProducts;
  final List<SalesModel> _sales;
  @override
  List<SalesModel> get sales {
    if (_sales is EqualUnmodifiableListView) return _sales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sales);
  }

  @override
  String toString() {
    return 'SalesReportModel(date: $date, totalSales: $totalSales, totalOrders: $totalOrders, totalProducts: $totalProducts, sales: $sales)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesReportModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.totalSales, totalSales) ||
                other.totalSales == totalSales) &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.totalProducts, totalProducts) ||
                other.totalProducts == totalProducts) &&
            const DeepCollectionEquality().equals(other._sales, _sales));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, totalSales, totalOrders,
      totalProducts, const DeepCollectionEquality().hash(_sales));

  /// Create a copy of SalesReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesReportModelImplCopyWith<_$SalesReportModelImpl> get copyWith =>
      __$$SalesReportModelImplCopyWithImpl<_$SalesReportModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesReportModelImplToJson(
      this,
    );
  }
}

abstract class _SalesReportModel implements SalesReportModel {
  const factory _SalesReportModel(
      {required final DateTime date,
      required final double totalSales,
      required final int totalOrders,
      required final int totalProducts,
      required final List<SalesModel> sales}) = _$SalesReportModelImpl;

  factory _SalesReportModel.fromJson(Map<String, dynamic> json) =
      _$SalesReportModelImpl.fromJson;

  @override
  DateTime get date;
  @override
  double get totalSales;
  @override
  int get totalOrders;
  @override
  int get totalProducts;
  @override
  List<SalesModel> get sales;

  /// Create a copy of SalesReportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesReportModelImplCopyWith<_$SalesReportModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SalesChartData _$SalesChartDataFromJson(Map<String, dynamic> json) {
  return _SalesChartData.fromJson(json);
}

/// @nodoc
mixin _$SalesChartData {
  String get label => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;

  /// Serializes this SalesChartData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalesChartData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesChartDataCopyWith<SalesChartData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesChartDataCopyWith<$Res> {
  factory $SalesChartDataCopyWith(
          SalesChartData value, $Res Function(SalesChartData) then) =
      _$SalesChartDataCopyWithImpl<$Res, SalesChartData>;
  @useResult
  $Res call({String label, double value, String color});
}

/// @nodoc
class _$SalesChartDataCopyWithImpl<$Res, $Val extends SalesChartData>
    implements $SalesChartDataCopyWith<$Res> {
  _$SalesChartDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesChartData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalesChartDataImplCopyWith<$Res>
    implements $SalesChartDataCopyWith<$Res> {
  factory _$$SalesChartDataImplCopyWith(_$SalesChartDataImpl value,
          $Res Function(_$SalesChartDataImpl) then) =
      __$$SalesChartDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, double value, String color});
}

/// @nodoc
class __$$SalesChartDataImplCopyWithImpl<$Res>
    extends _$SalesChartDataCopyWithImpl<$Res, _$SalesChartDataImpl>
    implements _$$SalesChartDataImplCopyWith<$Res> {
  __$$SalesChartDataImplCopyWithImpl(
      _$SalesChartDataImpl _value, $Res Function(_$SalesChartDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesChartData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
    Object? color = null,
  }) {
    return _then(_$SalesChartDataImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesChartDataImpl implements _SalesChartData {
  const _$SalesChartDataImpl(
      {required this.label, required this.value, required this.color});

  factory _$SalesChartDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesChartDataImplFromJson(json);

  @override
  final String label;
  @override
  final double value;
  @override
  final String color;

  @override
  String toString() {
    return 'SalesChartData(label: $label, value: $value, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesChartDataImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, value, color);

  /// Create a copy of SalesChartData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesChartDataImplCopyWith<_$SalesChartDataImpl> get copyWith =>
      __$$SalesChartDataImplCopyWithImpl<_$SalesChartDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesChartDataImplToJson(
      this,
    );
  }
}

abstract class _SalesChartData implements SalesChartData {
  const factory _SalesChartData(
      {required final String label,
      required final double value,
      required final String color}) = _$SalesChartDataImpl;

  factory _SalesChartData.fromJson(Map<String, dynamic> json) =
      _$SalesChartDataImpl.fromJson;

  @override
  String get label;
  @override
  double get value;
  @override
  String get color;

  /// Create a copy of SalesChartData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesChartDataImplCopyWith<_$SalesChartDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SalesSummary _$SalesSummaryFromJson(Map<String, dynamic> json) {
  return _SalesSummary.fromJson(json);
}

/// @nodoc
mixin _$SalesSummary {
  double get totalRevenue => throw _privateConstructorUsedError;
  int get totalOrders => throw _privateConstructorUsedError;
  int get totalProducts => throw _privateConstructorUsedError;
  double get averageOrderValue => throw _privateConstructorUsedError;
  double get growthRate => throw _privateConstructorUsedError;
  List<SalesChartData> get dailySales => throw _privateConstructorUsedError;
  List<SalesChartData> get categorySales => throw _privateConstructorUsedError;
  List<SalesChartData> get paymentMethodSales =>
      throw _privateConstructorUsedError;

  /// Serializes this SalesSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalesSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesSummaryCopyWith<SalesSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesSummaryCopyWith<$Res> {
  factory $SalesSummaryCopyWith(
          SalesSummary value, $Res Function(SalesSummary) then) =
      _$SalesSummaryCopyWithImpl<$Res, SalesSummary>;
  @useResult
  $Res call(
      {double totalRevenue,
      int totalOrders,
      int totalProducts,
      double averageOrderValue,
      double growthRate,
      List<SalesChartData> dailySales,
      List<SalesChartData> categorySales,
      List<SalesChartData> paymentMethodSales});
}

/// @nodoc
class _$SalesSummaryCopyWithImpl<$Res, $Val extends SalesSummary>
    implements $SalesSummaryCopyWith<$Res> {
  _$SalesSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRevenue = null,
    Object? totalOrders = null,
    Object? totalProducts = null,
    Object? averageOrderValue = null,
    Object? growthRate = null,
    Object? dailySales = null,
    Object? categorySales = null,
    Object? paymentMethodSales = null,
  }) {
    return _then(_value.copyWith(
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      totalOrders: null == totalOrders
          ? _value.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int,
      totalProducts: null == totalProducts
          ? _value.totalProducts
          : totalProducts // ignore: cast_nullable_to_non_nullable
              as int,
      averageOrderValue: null == averageOrderValue
          ? _value.averageOrderValue
          : averageOrderValue // ignore: cast_nullable_to_non_nullable
              as double,
      growthRate: null == growthRate
          ? _value.growthRate
          : growthRate // ignore: cast_nullable_to_non_nullable
              as double,
      dailySales: null == dailySales
          ? _value.dailySales
          : dailySales // ignore: cast_nullable_to_non_nullable
              as List<SalesChartData>,
      categorySales: null == categorySales
          ? _value.categorySales
          : categorySales // ignore: cast_nullable_to_non_nullable
              as List<SalesChartData>,
      paymentMethodSales: null == paymentMethodSales
          ? _value.paymentMethodSales
          : paymentMethodSales // ignore: cast_nullable_to_non_nullable
              as List<SalesChartData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalesSummaryImplCopyWith<$Res>
    implements $SalesSummaryCopyWith<$Res> {
  factory _$$SalesSummaryImplCopyWith(
          _$SalesSummaryImpl value, $Res Function(_$SalesSummaryImpl) then) =
      __$$SalesSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double totalRevenue,
      int totalOrders,
      int totalProducts,
      double averageOrderValue,
      double growthRate,
      List<SalesChartData> dailySales,
      List<SalesChartData> categorySales,
      List<SalesChartData> paymentMethodSales});
}

/// @nodoc
class __$$SalesSummaryImplCopyWithImpl<$Res>
    extends _$SalesSummaryCopyWithImpl<$Res, _$SalesSummaryImpl>
    implements _$$SalesSummaryImplCopyWith<$Res> {
  __$$SalesSummaryImplCopyWithImpl(
      _$SalesSummaryImpl _value, $Res Function(_$SalesSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRevenue = null,
    Object? totalOrders = null,
    Object? totalProducts = null,
    Object? averageOrderValue = null,
    Object? growthRate = null,
    Object? dailySales = null,
    Object? categorySales = null,
    Object? paymentMethodSales = null,
  }) {
    return _then(_$SalesSummaryImpl(
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      totalOrders: null == totalOrders
          ? _value.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int,
      totalProducts: null == totalProducts
          ? _value.totalProducts
          : totalProducts // ignore: cast_nullable_to_non_nullable
              as int,
      averageOrderValue: null == averageOrderValue
          ? _value.averageOrderValue
          : averageOrderValue // ignore: cast_nullable_to_non_nullable
              as double,
      growthRate: null == growthRate
          ? _value.growthRate
          : growthRate // ignore: cast_nullable_to_non_nullable
              as double,
      dailySales: null == dailySales
          ? _value._dailySales
          : dailySales // ignore: cast_nullable_to_non_nullable
              as List<SalesChartData>,
      categorySales: null == categorySales
          ? _value._categorySales
          : categorySales // ignore: cast_nullable_to_non_nullable
              as List<SalesChartData>,
      paymentMethodSales: null == paymentMethodSales
          ? _value._paymentMethodSales
          : paymentMethodSales // ignore: cast_nullable_to_non_nullable
              as List<SalesChartData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesSummaryImpl implements _SalesSummary {
  const _$SalesSummaryImpl(
      {required this.totalRevenue,
      required this.totalOrders,
      required this.totalProducts,
      required this.averageOrderValue,
      required this.growthRate,
      required final List<SalesChartData> dailySales,
      required final List<SalesChartData> categorySales,
      required final List<SalesChartData> paymentMethodSales})
      : _dailySales = dailySales,
        _categorySales = categorySales,
        _paymentMethodSales = paymentMethodSales;

  factory _$SalesSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesSummaryImplFromJson(json);

  @override
  final double totalRevenue;
  @override
  final int totalOrders;
  @override
  final int totalProducts;
  @override
  final double averageOrderValue;
  @override
  final double growthRate;
  final List<SalesChartData> _dailySales;
  @override
  List<SalesChartData> get dailySales {
    if (_dailySales is EqualUnmodifiableListView) return _dailySales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailySales);
  }

  final List<SalesChartData> _categorySales;
  @override
  List<SalesChartData> get categorySales {
    if (_categorySales is EqualUnmodifiableListView) return _categorySales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categorySales);
  }

  final List<SalesChartData> _paymentMethodSales;
  @override
  List<SalesChartData> get paymentMethodSales {
    if (_paymentMethodSales is EqualUnmodifiableListView)
      return _paymentMethodSales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentMethodSales);
  }

  @override
  String toString() {
    return 'SalesSummary(totalRevenue: $totalRevenue, totalOrders: $totalOrders, totalProducts: $totalProducts, averageOrderValue: $averageOrderValue, growthRate: $growthRate, dailySales: $dailySales, categorySales: $categorySales, paymentMethodSales: $paymentMethodSales)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesSummaryImpl &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.totalProducts, totalProducts) ||
                other.totalProducts == totalProducts) &&
            (identical(other.averageOrderValue, averageOrderValue) ||
                other.averageOrderValue == averageOrderValue) &&
            (identical(other.growthRate, growthRate) ||
                other.growthRate == growthRate) &&
            const DeepCollectionEquality()
                .equals(other._dailySales, _dailySales) &&
            const DeepCollectionEquality()
                .equals(other._categorySales, _categorySales) &&
            const DeepCollectionEquality()
                .equals(other._paymentMethodSales, _paymentMethodSales));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalRevenue,
      totalOrders,
      totalProducts,
      averageOrderValue,
      growthRate,
      const DeepCollectionEquality().hash(_dailySales),
      const DeepCollectionEquality().hash(_categorySales),
      const DeepCollectionEquality().hash(_paymentMethodSales));

  /// Create a copy of SalesSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesSummaryImplCopyWith<_$SalesSummaryImpl> get copyWith =>
      __$$SalesSummaryImplCopyWithImpl<_$SalesSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesSummaryImplToJson(
      this,
    );
  }
}

abstract class _SalesSummary implements SalesSummary {
  const factory _SalesSummary(
          {required final double totalRevenue,
          required final int totalOrders,
          required final int totalProducts,
          required final double averageOrderValue,
          required final double growthRate,
          required final List<SalesChartData> dailySales,
          required final List<SalesChartData> categorySales,
          required final List<SalesChartData> paymentMethodSales}) =
      _$SalesSummaryImpl;

  factory _SalesSummary.fromJson(Map<String, dynamic> json) =
      _$SalesSummaryImpl.fromJson;

  @override
  double get totalRevenue;
  @override
  int get totalOrders;
  @override
  int get totalProducts;
  @override
  double get averageOrderValue;
  @override
  double get growthRate;
  @override
  List<SalesChartData> get dailySales;
  @override
  List<SalesChartData> get categorySales;
  @override
  List<SalesChartData> get paymentMethodSales;

  /// Create a copy of SalesSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesSummaryImplCopyWith<_$SalesSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

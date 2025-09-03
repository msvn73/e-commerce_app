// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SalesModelImpl _$$SalesModelImplFromJson(Map<String, dynamic> json) =>
    _$SalesModelImpl(
      id: json['id'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      customerName: json['customerName'] as String,
      customerEmail: json['customerEmail'] as String,
      customerPhone: json['customerPhone'] as String,
      paymentMethod: json['paymentMethod'] as String,
      status: json['status'] as String,
      saleDate: DateTime.parse(json['saleDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$SalesModelImplToJson(_$SalesModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'productName': instance.productName,
      'price': instance.price,
      'quantity': instance.quantity,
      'totalAmount': instance.totalAmount,
      'customerName': instance.customerName,
      'customerEmail': instance.customerEmail,
      'customerPhone': instance.customerPhone,
      'paymentMethod': instance.paymentMethod,
      'status': instance.status,
      'saleDate': instance.saleDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$SalesReportModelImpl _$$SalesReportModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SalesReportModelImpl(
      date: DateTime.parse(json['date'] as String),
      totalSales: (json['totalSales'] as num).toDouble(),
      totalOrders: (json['totalOrders'] as num).toInt(),
      totalProducts: (json['totalProducts'] as num).toInt(),
      sales: (json['sales'] as List<dynamic>)
          .map((e) => SalesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SalesReportModelImplToJson(
        _$SalesReportModelImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'totalSales': instance.totalSales,
      'totalOrders': instance.totalOrders,
      'totalProducts': instance.totalProducts,
      'sales': instance.sales,
    };

_$SalesChartDataImpl _$$SalesChartDataImplFromJson(Map<String, dynamic> json) =>
    _$SalesChartDataImpl(
      label: json['label'] as String,
      value: (json['value'] as num).toDouble(),
      color: json['color'] as String,
    );

Map<String, dynamic> _$$SalesChartDataImplToJson(
        _$SalesChartDataImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
      'color': instance.color,
    };

_$SalesSummaryImpl _$$SalesSummaryImplFromJson(Map<String, dynamic> json) =>
    _$SalesSummaryImpl(
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      totalOrders: (json['totalOrders'] as num).toInt(),
      totalProducts: (json['totalProducts'] as num).toInt(),
      averageOrderValue: (json['averageOrderValue'] as num).toDouble(),
      growthRate: (json['growthRate'] as num).toDouble(),
      dailySales: (json['dailySales'] as List<dynamic>)
          .map((e) => SalesChartData.fromJson(e as Map<String, dynamic>))
          .toList(),
      categorySales: (json['categorySales'] as List<dynamic>)
          .map((e) => SalesChartData.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentMethodSales: (json['paymentMethodSales'] as List<dynamic>)
          .map((e) => SalesChartData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SalesSummaryImplToJson(_$SalesSummaryImpl instance) =>
    <String, dynamic>{
      'totalRevenue': instance.totalRevenue,
      'totalOrders': instance.totalOrders,
      'totalProducts': instance.totalProducts,
      'averageOrderValue': instance.averageOrderValue,
      'growthRate': instance.growthRate,
      'dailySales': instance.dailySales,
      'categorySales': instance.categorySales,
      'paymentMethodSales': instance.paymentMethodSales,
    };

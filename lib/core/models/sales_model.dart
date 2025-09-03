import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_model.freezed.dart';
part 'sales_model.g.dart';

@freezed
class SalesModel with _$SalesModel {
  const factory SalesModel({
    required String id,
    required String productId,
    required String productName,
    required double price,
    required int quantity,
    required double totalAmount,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    required String paymentMethod,
    required String status, // 'pending', 'completed', 'cancelled'
    required DateTime saleDate,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SalesModel;

  factory SalesModel.fromJson(Map<String, dynamic> json) =>
      _$SalesModelFromJson(json);
}

@freezed
class SalesReportModel with _$SalesReportModel {
  const factory SalesReportModel({
    required DateTime date,
    required double totalSales,
    required int totalOrders,
    required int totalProducts,
    required List<SalesModel> sales,
  }) = _SalesReportModel;

  factory SalesReportModel.fromJson(Map<String, dynamic> json) =>
      _$SalesReportModelFromJson(json);
}

@freezed
class SalesChartData with _$SalesChartData {
  const factory SalesChartData({
    required String label,
    required double value,
    required String color,
  }) = _SalesChartData;

  factory SalesChartData.fromJson(Map<String, dynamic> json) =>
      _$SalesChartDataFromJson(json);
}

@freezed
class SalesSummary with _$SalesSummary {
  const factory SalesSummary({
    required double totalRevenue,
    required int totalOrders,
    required int totalProducts,
    required double averageOrderValue,
    required double growthRate,
    required List<SalesChartData> dailySales,
    required List<SalesChartData> categorySales,
    required List<SalesChartData> paymentMethodSales,
  }) = _SalesSummary;

  factory SalesSummary.fromJson(Map<String, dynamic> json) =>
      _$SalesSummaryFromJson(json);
}

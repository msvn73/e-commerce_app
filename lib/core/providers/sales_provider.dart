import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math';

import '../models/sales_model.dart';
import '../services/demo_service.dart';
import '../../config/app_config.dart';

class SalesState {
  final List<SalesModel> sales;
  final SalesSummary? summary;
  final bool isLoading;
  final String? error;

  const SalesState({
    this.sales = const [],
    this.summary,
    this.isLoading = false,
    this.error,
  });

  SalesState copyWith({
    List<SalesModel>? sales,
    SalesSummary? summary,
    bool? isLoading,
    String? error,
  }) {
    return SalesState(
      sales: sales ?? this.sales,
      summary: summary ?? this.summary,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class SalesNotifier extends StateNotifier<SalesState> {
  SalesNotifier() : super(const SalesState());

  final SupabaseClient _client = Supabase.instance.client;

  // Load sales data
  Future<void> loadSales() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Check if Supabase is properly configured
      if (AppConfig.supabaseUrl.contains('your-project')) {
        // Use demo service
        final sales = await DemoService.getSales();
        final summary = _calculateSummary(sales);
        state = state.copyWith(
          sales: sales,
          summary: summary,
          isLoading: false,
        );
        return;
      }

      final response = await _client.from('sales').select('''
            *,
            products (
              id,
              name,
              price
            )
          ''').order('sale_date', ascending: false);

      final sales =
          (response as List).map((json) => SalesModel.fromJson(json)).toList();

      final summary = _calculateSummary(sales);

      state = state.copyWith(
        sales: sales,
        summary: summary,
        isLoading: false,
      );
    } catch (e) {
      // Fallback to demo service
      try {
        final sales = await DemoService.getSales();
        final summary = _calculateSummary(sales);
        state = state.copyWith(
          sales: sales,
          summary: summary,
          isLoading: false,
        );
      } catch (demoError) {
        // If demo service also fails, generate mock data
        _generateMockSalesData();
      }
    }
  }

  // Generate mock sales data for demonstration
  void _generateMockSalesData() {
    final now = DateTime.now();
    final random = Random();
    final mockSales = <SalesModel>[];

    // Generate sales for the last 30 days
    for (int i = 0; i < 30; i++) {
      final date = now.subtract(Duration(days: i));
      final salesCount = random.nextInt(5) + 1; // 1-5 sales per day

      for (int j = 0; j < salesCount; j++) {
        final productNames = [
          'iPhone 15 Pro',
          'Samsung Galaxy S24',
          'MacBook Pro',
          'Dell XPS 13',
          'iPad Air',
          'Sony WH-1000XM5',
          'Nintendo Switch',
          'PlayStation 5',
        ];

        final productName = productNames[random.nextInt(productNames.length)];
        final price = (random.nextDouble() * 5000 + 500).toDouble();
        final quantity = random.nextInt(3) + 1;
        final totalAmount = price * quantity;

        final paymentMethods = [
          'Kredi Kartı',
          'Banka Kartı',
          'Nakit',
          'Havale'
        ];
        final statuses = [
          'completed',
          'completed',
          'completed',
          'pending'
        ]; // Mostly completed

        mockSales.add(SalesModel(
          id: 'mock_${i}_$j',
          productId: 'product_${random.nextInt(100)}',
          productName: productName,
          price: price,
          quantity: quantity,
          totalAmount: totalAmount,
          customerName: 'Müşteri ${random.nextInt(1000)}',
          customerEmail: 'musteri${random.nextInt(1000)}@email.com',
          customerPhone: '+90 5${random.nextInt(100000000)}',
          paymentMethod: paymentMethods[random.nextInt(paymentMethods.length)],
          status: statuses[random.nextInt(statuses.length)],
          saleDate: date,
          createdAt: date,
          updatedAt: date,
        ));
      }
    }

    final summary = _calculateSummary(mockSales);

    state = state.copyWith(
      sales: mockSales,
      summary: summary,
      isLoading: false,
    );
  }

  // Calculate sales summary
  SalesSummary _calculateSummary(List<SalesModel> sales) {
    if (sales.isEmpty) {
      return SalesSummary(
        totalRevenue: 0,
        totalOrders: 0,
        totalProducts: 0,
        averageOrderValue: 0,
        growthRate: 0,
        dailySales: [],
        categorySales: [],
        paymentMethodSales: [],
      );
    }

    final totalRevenue = sales
        .where((sale) => sale.status == 'completed')
        .fold(0.0, (sum, sale) => sum + sale.totalAmount);

    final totalOrders =
        sales.where((sale) => sale.status == 'completed').length;
    final totalProducts = sales
        .where((sale) => sale.status == 'completed')
        .fold(0, (sum, sale) => sum + sale.quantity);

    final averageOrderValue =
        totalOrders > 0 ? totalRevenue / totalOrders : 0.0;

    // Calculate growth rate (mock calculation)
    final growthRate = Random().nextDouble() * 20 - 10; // -10% to +10%

    // Daily sales data for chart
    final dailySales = _calculateDailySales(sales);

    // Category sales data (mock)
    final categorySales = _calculateCategorySales(sales);

    // Payment method sales data
    final paymentMethodSales = _calculatePaymentMethodSales(sales);

    return SalesSummary(
      totalRevenue: totalRevenue,
      totalOrders: totalOrders,
      totalProducts: totalProducts,
      averageOrderValue: averageOrderValue,
      growthRate: growthRate,
      dailySales: dailySales,
      categorySales: categorySales,
      paymentMethodSales: paymentMethodSales,
    );
  }

  // Calculate daily sales for chart
  List<SalesChartData> _calculateDailySales(List<SalesModel> sales) {
    final Map<String, double> dailyMap = {};

    for (final sale in sales.where((s) => s.status == 'completed')) {
      final dateKey = '${sale.saleDate.day}/${sale.saleDate.month}';
      dailyMap[dateKey] = (dailyMap[dateKey] ?? 0) + sale.totalAmount;
    }

    return dailyMap.entries
        .map((entry) => SalesChartData(
              label: entry.key,
              value: entry.value,
              color: '#FF6B35',
            ))
        .toList()
      ..sort((a, b) => a.label.compareTo(b.label));
  }

  // Calculate category sales (mock data)
  List<SalesChartData> _calculateCategorySales(List<SalesModel> sales) {
    final categories = [
      'Elektronik',
      'Giyim',
      'Ev & Yaşam',
      'Spor',
      'Kitap',
    ];

    final colors = [
      '#FF6B35',
      '#4ECDC4',
      '#45B7D1',
      '#96CEB4',
      '#FFEAA7',
    ];

    return categories.asMap().entries.map((entry) {
      final index = entry.key;
      final category = entry.value;
      final random = Random();
      final value = random.nextDouble() * 10000 + 1000;

      return SalesChartData(
        label: category,
        value: value,
        color: colors[index],
      );
    }).toList();
  }

  // Calculate payment method sales
  List<SalesChartData> _calculatePaymentMethodSales(List<SalesModel> sales) {
    final Map<String, double> paymentMap = {};

    for (final sale in sales.where((s) => s.status == 'completed')) {
      paymentMap[sale.paymentMethod] =
          (paymentMap[sale.paymentMethod] ?? 0) + sale.totalAmount;
    }

    final colors = ['#FF6B35', '#4ECDC4', '#45B7D1', '#96CEB4'];
    int colorIndex = 0;

    return paymentMap.entries.map((entry) {
      return SalesChartData(
        label: entry.key,
        value: entry.value,
        color: colors[colorIndex++ % colors.length],
      );
    }).toList();
  }

  // Add new sale
  Future<void> addSale(SalesModel sale) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      if (AppConfig.supabaseUrl.contains('your-project')) {
        // Use demo service
        await DemoService.addSale(sale);
        final updatedSales = await DemoService.getSales();
        final summary = _calculateSummary(updatedSales);

        state = state.copyWith(
          sales: updatedSales,
          summary: summary,
          isLoading: false,
        );
        return;
      }

      final response = await _client
          .from('sales')
          .insert({
            'product_id': sale.productId,
            'product_name': sale.productName,
            'price': sale.price,
            'quantity': sale.quantity,
            'total_amount': sale.totalAmount,
            'customer_name': sale.customerName,
            'customer_email': sale.customerEmail,
            'customer_phone': sale.customerPhone,
            'payment_method': sale.paymentMethod,
            'status': sale.status,
            'sale_date': sale.saleDate.toIso8601String(),
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      final newSale = SalesModel.fromJson(response);
      final updatedSales = [newSale, ...state.sales];
      final summary = _calculateSummary(updatedSales);

      state = state.copyWith(
        sales: updatedSales,
        summary: summary,
        isLoading: false,
      );
    } catch (e) {
      // Fallback to demo service
      try {
        await DemoService.addSale(sale);
        final updatedSales = await DemoService.getSales();
        final summary = _calculateSummary(updatedSales);

        state = state.copyWith(
          sales: updatedSales,
          summary: summary,
          isLoading: false,
        );
      } catch (demoError) {
        state = state.copyWith(
          isLoading: false,
          error: e.toString(),
        );
        rethrow;
      }
    }
  }

  // Get sales by date range
  Future<void> loadSalesByDateRange(
      DateTime startDate, DateTime endDate) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      if (AppConfig.supabaseUrl.contains('your-project')) {
        // Filter mock data by date range
        final filteredSales = state.sales.where((sale) {
          return sale.saleDate
                  .isAfter(startDate.subtract(const Duration(days: 1))) &&
              sale.saleDate.isBefore(endDate.add(const Duration(days: 1)));
        }).toList();

        final summary = _calculateSummary(filteredSales);

        state = state.copyWith(
          sales: filteredSales,
          summary: summary,
          isLoading: false,
        );
        return;
      }

      final response = await _client
          .from('sales')
          .select('''
            *,
            products (
              id,
              name,
              price
            )
          ''')
          .gte('sale_date', startDate.toIso8601String())
          .lte('sale_date', endDate.toIso8601String())
          .order('sale_date', ascending: false);

      final sales =
          (response as List).map((json) => SalesModel.fromJson(json)).toList();

      final summary = _calculateSummary(sales);

      state = state.copyWith(
        sales: sales,
        summary: summary,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final salesProvider = StateNotifierProvider<SalesNotifier, SalesState>((ref) {
  return SalesNotifier();
});

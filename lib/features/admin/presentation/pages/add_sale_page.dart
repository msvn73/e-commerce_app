import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/sales_model.dart';
import '../../../../core/providers/sales_provider.dart';
import '../../../../core/providers/products_provider.dart';

class AddSalePage extends ConsumerStatefulWidget {
  const AddSalePage({super.key});

  @override
  ConsumerState<AddSalePage> createState() => _AddSalePageState();
}

class _AddSalePageState extends ConsumerState<AddSalePage> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _customerEmailController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  final _quantityController = TextEditingController();

  String _selectedProductId = '';
  String _selectedPaymentMethod = 'Kredi Kartı';
  bool _isLoading = false;

  final List<String> _paymentMethods = [
    'Kredi Kartı',
    'Banka Kartı',
    'Nakit',
    'Havale',
  ];

  @override
  void initState() {
    super.initState();
    // Load products when page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productsProvider.notifier).loadProducts();
    });
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerEmailController.dispose();
    _customerPhoneController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Satış Ekle'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customer Information
              _buildSectionTitle('Müşteri Bilgileri'),
              const SizedBox(height: 16),

              TextFormField(
                controller: _customerNameController,
                decoration: const InputDecoration(
                  labelText: 'Müşteri Adı *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Müşteri adı gereklidir';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _customerEmailController,
                decoration: const InputDecoration(
                  labelText: 'E-posta',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _customerPhoneController,
                decoration: const InputDecoration(
                  labelText: 'Telefon',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),

              // Product Selection
              _buildSectionTitle('Ürün Bilgileri'),
              const SizedBox(height: 16),

              Consumer(
                builder: (context, ref, child) {
                  return DropdownButtonFormField<String>(
                    value:
                        _selectedProductId.isEmpty ? null : _selectedProductId,
                    decoration: const InputDecoration(
                      labelText: 'Ürün *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.shopping_bag),
                    ),
                    items: productsState.products.map((product) {
                      return DropdownMenuItem<String>(
                        value: product.id,
                        child: Text(
                            '${product.name} - ₺${product.price.toStringAsFixed(2)}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedProductId = value ?? '';
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ürün seçimi gereklidir';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'Miktar *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Miktar gereklidir';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Geçerli bir miktar girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Payment Information
              _buildSectionTitle('Ödeme Bilgileri'),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedPaymentMethod,
                decoration: const InputDecoration(
                  labelText: 'Ödeme Yöntemi *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.payment),
                ),
                items: _paymentMethods.map((method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value ?? 'Kredi Kartı';
                  });
                },
              ),
              const SizedBox(height: 32),

              // Order Summary
              if (_selectedProductId.isNotEmpty &&
                  _quantityController.text.isNotEmpty)
                _buildOrderSummary(),
              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveSale,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Satışı Kaydet'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
    );
  }

  Widget _buildOrderSummary() {
    final productsState = ref.watch(productsProvider);
    final selectedProduct = productsState.products.firstWhere(
      (product) => product.id == _selectedProductId,
      orElse: () => throw StateError('Product not found'),
    );

    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final totalAmount = selectedProduct.price * quantity;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sipariş Özeti',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Ürün:'),
                Text(selectedProduct.name),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Birim Fiyat:'),
                Text('₺${selectedProduct.price.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Miktar:'),
                Text('$quantity adet'),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Toplam:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  '₺${totalAmount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveSale() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final productsState = ref.read(productsProvider);
      final selectedProduct = productsState.products.firstWhere(
        (product) => product.id == _selectedProductId,
      );

      final quantity = int.parse(_quantityController.text);
      final totalAmount = selectedProduct.price * quantity;

      final sale = SalesModel(
        id: '', // Will be set by provider
        productId: selectedProduct.id,
        productName: selectedProduct.name,
        price: selectedProduct.price,
        quantity: quantity,
        totalAmount: totalAmount,
        customerName: _customerNameController.text.trim(),
        customerEmail: _customerEmailController.text.trim().isEmpty
            ? ''
            : _customerEmailController.text.trim(),
        customerPhone: _customerPhoneController.text.trim().isEmpty
            ? ''
            : _customerPhoneController.text.trim(),
        paymentMethod: _selectedPaymentMethod,
        status: 'completed',
        saleDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await ref.read(salesProvider.notifier).addSale(sale);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Satış başarıyla eklendi'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hata: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

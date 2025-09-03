import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/categories_provider.dart';
import '../../../../core/providers/products_provider.dart';
import '../../../../core/providers/sales_provider.dart';
import '../../../../core/services/demo_service.dart';
import '../../../../core/models/category_model.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/models/sales_model.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesState = ref.watch(categoriesProvider);
    final productsState = ref.watch(productsProvider);
    final salesState = ref.watch(salesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Sayfası'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Cards
            _buildStatusCard(
              'Kategoriler',
              categoriesState.categories.length.toString(),
              categoriesState.isLoading,
              categoriesState.error,
              Colors.blue,
            ),
            const SizedBox(height: 16),

            _buildStatusCard(
              'Ürünler',
              productsState.products.length.toString(),
              productsState.isLoading,
              productsState.error,
              Colors.green,
            ),
            const SizedBox(height: 16),

            _buildStatusCard(
              'Satışlar',
              salesState.sales.length.toString(),
              salesState.isLoading,
              salesState.error,
              Colors.orange,
            ),
            const SizedBox(height: 24),

            // Test Buttons
            Text(
              'Test Butonları',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            // Load Data Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(categoriesProvider.notifier).loadCategories();
                    },
                    child: const Text('Kategorileri Yükle'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(productsProvider.notifier).loadProducts();
                    },
                    child: const Text('Ürünleri Yükle'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(salesProvider.notifier).loadSales();
                    },
                    child: const Text('Satışları Yükle'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await DemoService.clearAllData();
                      // Refresh all providers
                      ref.invalidate(categoriesProvider);
                      ref.invalidate(productsProvider);
                      ref.invalidate(salesProvider);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tüm demo veriler temizlendi'),
                          backgroundColor: Colors.orange,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Verileri Temizle'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Add Test Data Buttons
            Text(
              'Test Verisi Ekle',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                try {
                  await ref.read(categoriesProvider.notifier).addCategory(
                        CategoryModel(
                          id: '',
                          name:
                              'Test Kategori ${DateTime.now().millisecondsSinceEpoch}',
                          description: 'Test kategorisi',
                          icon: 'test',
                          color: 'FF6B35',
                          isActive: true,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        ),
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Test kategorisi eklendi'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Hata: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Test Kategorisi Ekle'),
            ),
            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: () async {
                try {
                  await ref.read(productsProvider.notifier).addProduct(
                        ProductFormData(
                          name:
                              'Test Ürün ${DateTime.now().millisecondsSinceEpoch}',
                          description: 'Test ürünü',
                          price: 100.0,
                          stock: 10,
                          categoryId: categoriesState.categories.isNotEmpty
                              ? categoriesState.categories.first.id
                              : '',
                          images: [
                            'https://via.placeholder.com/300x300/FF6B35/FFFFFF?text=Test'
                          ],
                          videos: [],
                          isActive: true,
                        ),
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Test ürünü eklendi'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Hata: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Test Ürünü Ekle'),
            ),
            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: () async {
                try {
                  await ref.read(salesProvider.notifier).addSale(
                        SalesModel(
                          id: '',
                          productId: productsState.products.isNotEmpty
                              ? productsState.products.first.id
                              : 'test_product',
                          productName: 'Test Ürün',
                          price: 100.0,
                          quantity: 1,
                          totalAmount: 100.0,
                          customerName: 'Test Müşteri',
                          customerEmail: 'test@email.com',
                          customerPhone: '+90 555 123 4567',
                          paymentMethod: 'Kredi Kartı',
                          status: 'completed',
                          saleDate: DateTime.now(),
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        ),
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Test satışı eklendi'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Hata: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Test Satışı Ekle'),
            ),
            const SizedBox(height: 24),

            // Data Lists
            if (categoriesState.categories.isNotEmpty) ...[
              Text(
                'Kategoriler (${categoriesState.categories.length})',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              ...categoriesState.categories.take(3).map(
                    (category) => ListTile(
                      title: Text(category.name),
                      subtitle: Text(category.description ?? ''),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.withValues(alpha: 0.1),
                        child: const Icon(Icons.category, color: Colors.blue),
                      ),
                    ),
                  ),
              const SizedBox(height: 16),
            ],

            if (productsState.products.isNotEmpty) ...[
              Text(
                'Ürünler (${productsState.products.length})',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              ...productsState.products.take(3).map(
                    (product) => ListTile(
                      title: Text(product.name),
                      subtitle: Text(
                          '₺${product.price.toStringAsFixed(2)} - Stok: ${product.stock}'),
                      leading: CircleAvatar(
                        backgroundColor: Colors.green.withValues(alpha: 0.1),
                        child:
                            const Icon(Icons.shopping_bag, color: Colors.green),
                      ),
                    ),
                  ),
              const SizedBox(height: 16),
            ],

            if (salesState.sales.isNotEmpty) ...[
              Text(
                'Satışlar (${salesState.sales.length})',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              ...salesState.sales.take(3).map(
                    (sale) => ListTile(
                      title: Text(sale.productName),
                      subtitle: Text(
                          '${sale.customerName} - ₺${sale.totalAmount.toStringAsFixed(2)}'),
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange.withValues(alpha: 0.1),
                        child: const Icon(Icons.shopping_cart,
                            color: Colors.orange),
                      ),
                    ),
                  ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(
    String title,
    String count,
    bool isLoading,
    String? error,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.1),
              child: Icon(
                isLoading
                    ? Icons.hourglass_empty
                    : error != null
                        ? Icons.error
                        : Icons.check,
                color: color,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isLoading)
                    const Text('Yükleniyor...',
                        style: TextStyle(color: Colors.grey))
                  else if (error != null)
                    Text('Hata: $error',
                        style: const TextStyle(color: Colors.red))
                  else
                    Text('$count adet', style: TextStyle(color: color)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

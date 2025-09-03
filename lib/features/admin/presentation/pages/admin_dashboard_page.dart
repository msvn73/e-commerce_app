import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/session_provider.dart';
import 'admin_products_page.dart';
import 'admin_orders_page.dart';
import 'admin_categories_page.dart';
import 'admin_sliders_page.dart';
import 'sales_reports_page.dart';
import 'add_sale_page.dart';
import 'test_page.dart';

class AdminDashboardPage extends ConsumerStatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  ConsumerState<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends ConsumerState<AdminDashboardPage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      AdminHomeTab(
        onNavigateToProducts: () {
          setState(() {
            _currentIndex = 1;
          });
        },
        onNavigateToReports: () {
          setState(() {
            _currentIndex = 5;
          });
        },
        onNavigateToAddSale: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddSalePage()),
          );
        },
        onNavigateToTest: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const TestPage()),
          );
        },
      ),
      const AdminProductsPage(),
      const AdminCategoriesPage(),
      const AdminSlidersPage(),
      const AdminOrdersPage(),
      const SalesReportsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Ana Sayfa',
            onPressed: () {
              context.go('/home');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Show confirmation dialog
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Çıkış Yap'),
                  content: const Text(
                      'Admin panelinden çıkış yapmak istediğinizden emin misiniz?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('İptal'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Çıkış Yap'),
                    ),
                  ],
                ),
              );

              if (confirmed == true) {
                // Clear session
                ref.read(sessionProvider.notifier).logout();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Admin panelinden çıkış yapıldı'),
                    backgroundColor: Colors.green,
                  ),
                );
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Ürünler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategoriler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.slideshow),
            label: 'Sliderlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Siparişler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Raporlar',
          ),
        ],
      ),
    );
  }
}

class AdminHomeTab extends StatelessWidget {
  final VoidCallback onNavigateToProducts;
  final VoidCallback onNavigateToReports;
  final VoidCallback onNavigateToAddSale;
  final VoidCallback onNavigateToTest;

  const AdminHomeTab({
    super.key,
    required this.onNavigateToProducts,
    required this.onNavigateToReports,
    required this.onNavigateToAddSale,
    required this.onNavigateToTest,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hoş Geldiniz, Admin!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Yönetim paneline hoş geldiniz. Buradan tüm sistem işlemlerini yönetebilirsiniz.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Quick Stats
          Text(
            'Hızlı İstatistikler',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: [
              _buildStatCard(
                context,
                'Toplam Ürün',
                '0',
                Icons.inventory,
                Colors.blue,
              ),
              _buildStatCard(
                context,
                'Toplam Sipariş',
                '0',
                Icons.shopping_cart,
                Colors.green,
              ),
              _buildStatCard(
                context,
                'Toplam Kullanıcı',
                '0',
                Icons.people,
                Colors.orange,
              ),
              _buildStatCard(
                context,
                'Günlük Satış',
                '₺0',
                Icons.attach_money,
                Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Quick Actions
          Text(
            'Hızlı İşlemler',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.add, color: Colors.blue),
                  title: const Text('Yeni Ürün Ekle'),
                  subtitle: const Text('Ürün kataloğuna yeni ürün ekleyin'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: onNavigateToProducts,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.edit, color: Colors.green),
                  title: const Text('Ürünleri Düzenle'),
                  subtitle: const Text('Mevcut ürünleri düzenleyin'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: onNavigateToProducts,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.analytics, color: Colors.orange),
                  title: const Text('Satış Raporları'),
                  subtitle:
                      const Text('Detaylı satış analizlerini görüntüleyin'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: onNavigateToReports,
                ),
                const Divider(height: 1),
                ListTile(
                  leading:
                      const Icon(Icons.add_shopping_cart, color: Colors.green),
                  title: const Text('Satış Ekle'),
                  subtitle: const Text('Yeni satış kaydı oluşturun'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: onNavigateToAddSale,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.bug_report, color: Colors.purple),
                  title: const Text('Test Sayfası'),
                  subtitle: const Text('Tüm butonları test edin'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: onNavigateToTest,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value,
      IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: color,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

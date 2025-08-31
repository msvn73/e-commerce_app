import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const _OverviewPage(),
    const _ProductsPage(),
    const _OrdersPage(),
    const _UsersPage(),
    const _SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Admin Paneli'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showLogoutDialog(context),
            icon: const Icon(Icons.logout),
            tooltip: 'Çıkış Yap',
          ),
        ],
      ),
      body: Row(
        children: [
          // Sol Sidebar
          Container(
            width: 250,
            color: AppColors.surface,
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildSidebarItem(
                  icon: Icons.dashboard,
                  title: 'Genel Bakış',
                  index: 0,
                ),
                _buildSidebarItem(
                  icon: Icons.inventory,
                  title: 'Ürünler',
                  index: 1,
                ),
                _buildSidebarItem(
                  icon: Icons.shopping_cart,
                  title: 'Siparişler',
                  index: 2,
                ),
                _buildSidebarItem(
                  icon: Icons.people,
                  title: 'Kullanıcılar',
                  index: 3,
                ),
                _buildSidebarItem(
                  icon: Icons.settings,
                  title: 'Ayarlar',
                  index: 4,
                ),
              ],
            ),
          ),
          // Sağ İçerik
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final isSelected = _selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.white : AppColors.textSecondary,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
        tileColor: isSelected ? AppColors.primary : Colors.transparent,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Çıkış Yap'),
          content: const Text(
              'Admin panelinden çıkmak istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Admin login'e dön
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              child: const Text('Çıkış Yap'),
            ),
          ],
        );
      },
    );
  }
}

// Genel Bakış Sayfası
class _OverviewPage extends StatelessWidget {
  const _OverviewPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Genel Bakış',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
          ),
          const SizedBox(height: 32),

          // İstatistik Kartları
          Row(
            children: [
              Expanded(
                  child: _buildStatCard('Toplam Ürün', '156', Icons.inventory,
                      AppColors.primary)),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildStatCard('Toplam Sipariş', '89',
                      Icons.shopping_cart, AppColors.success)),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildStatCard('Aktif Kullanıcı', '1,234',
                      Icons.people, AppColors.warning)),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildStatCard('Günlük Gelir', '₺2,450',
                      Icons.attach_money, AppColors.error)),
            ],
          ),

          const SizedBox(height: 32),

          // Son Aktiviteler
          Text(
            'Son Aktiviteler',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: const Icon(Icons.notifications,
                          color: AppColors.primary),
                    ),
                    title: Text('Yeni sipariş alındı #${1000 + index}'),
                    subtitle: Text(
                        '${DateTime.now().subtract(Duration(hours: index)).hour}:${DateTime.now().minute}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 16),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Ürünler Sayfası
class _ProductsPage extends StatelessWidget {
  const _ProductsPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ürün Yönetimi',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Ürün ekleme sayfasına git
                },
                icon: const Icon(Icons.add),
                label: const Text('Yeni Ürün'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: Text('${index + 1}',
                          style: const TextStyle(color: AppColors.primary)),
                    ),
                    title: Text('Ürün ${index + 1}'),
                    subtitle: Text(
                        'Kategori: Elektronik • Fiyat: ₺${(index + 1) * 100}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Düzenle
                          },
                          icon:
                              const Icon(Icons.edit, color: AppColors.primary),
                        ),
                        IconButton(
                          onPressed: () {
                            // Sil
                          },
                          icon:
                              const Icon(Icons.delete, color: AppColors.error),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Siparişler Sayfası
class _OrdersPage extends StatelessWidget {
  const _OrdersPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sipariş Yönetimi',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                final status = index % 3 == 0
                    ? 'Tamamlandı'
                    : index % 3 == 1
                        ? 'Hazırlanıyor'
                        : 'Beklemede';
                final statusColor = index % 3 == 0
                    ? AppColors.success
                    : index % 3 == 1
                        ? AppColors.warning
                        : AppColors.error;

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: statusColor.withValues(alpha: 0.1),
                      child: Text('${1000 + index}',
                          style: TextStyle(color: statusColor, fontSize: 12)),
                    ),
                    title: Text('Sipariş #${1000 + index}'),
                    subtitle: Text(
                        'Müşteri: Müşteri ${index + 1} • Tutar: ₺${(index + 1) * 50}'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Kullanıcılar Sayfası
class _UsersPage extends StatelessWidget {
  const _UsersPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kullanıcı Yönetimi',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: 25,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: Text(String.fromCharCode(65 + (index % 26)),
                          style: const TextStyle(color: AppColors.primary)),
                    ),
                    title: Text('Kullanıcı ${index + 1}'),
                    subtitle: Text(
                        'user${index + 1}@example.com • Üye: ${DateTime.now().subtract(Duration(days: index)).day} gün önce'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Düzenle
                          },
                          icon:
                              const Icon(Icons.edit, color: AppColors.primary),
                        ),
                        IconButton(
                          onPressed: () {
                            // Engelle
                          },
                          icon:
                              const Icon(Icons.block, color: AppColors.warning),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Ayarlar Sayfası
class _SettingsPage extends StatelessWidget {
  const _SettingsPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Admin Ayarları',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              children: [
                _buildSettingItem(
                  icon: Icons.security,
                  title: 'Güvenlik Ayarları',
                  subtitle: 'Şifre değiştir ve güvenlik seçenekleri',
                  onTap: () {},
                ),
                _buildSettingItem(
                  icon: Icons.backup,
                  title: 'Yedekleme',
                  subtitle: 'Veritabanı yedekleme ve geri yükleme',
                  onTap: () {},
                ),
                _buildSettingItem(
                  icon: Icons.analytics,
                  title: 'Raporlar',
                  subtitle: 'Satış ve kullanıcı raporları',
                  onTap: () {},
                ),
                _buildSettingItem(
                  icon: Icons.notifications,
                  title: 'Bildirimler',
                  subtitle: 'Admin bildirim ayarları',
                  onTap: () {},
                ),
                _buildSettingItem(
                  icon: Icons.system_update,
                  title: 'Sistem Güncellemeleri',
                  subtitle: 'Uygulama ve sistem güncellemeleri',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

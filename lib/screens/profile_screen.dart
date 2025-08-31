import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../constants/app_colors.dart';
import '../providers/auth_provider.dart';

import 'orders_screen.dart';
import 'help_support_screen.dart';
import 'settings_screen.dart';
import 'profile_settings_screen.dart';
import 'notification_settings_screen.dart';
import 'delivery_address_screen.dart';
import 'payment_methods_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  // Menu items listesi
  List<Map<String, dynamic>> get _menuItems => [
        {
          'icon': Icons.shopping_bag_outlined,
          'title': 'Siparişlerim',
          'subtitle': 'Sipariş geçmişinizi görüntüleyin',
          'onTap': (context) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrdersScreen()),
            );
          },
        },
        {
          'icon': Icons.location_on_outlined,
          'title': 'Teslimat Adresi',
          'subtitle': 'Teslimat adreslerinizi yönetin',
          'onTap': (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DeliveryAddressScreen(),
              ),
            );
          },
        },
        {
          'icon': Icons.payment_outlined,
          'title': 'Ödeme Yöntemleri',
          'subtitle': 'Ödeme seçeneklerinizi yönetin',
          'onTap': (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PaymentMethodsScreen(),
              ),
            );
          },
        },
        {
          'icon': Icons.notifications_outlined,
          'title': 'Bildirim Ayarları',
          'subtitle': 'Günlük, haftalık ve aylık bildirim tercihleri',
          'onTap': (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationSettingsScreen(),
              ),
            );
          },
        },
        {
          'icon': Icons.help_outline,
          'title': 'Yardım ve Destek',
          'subtitle': 'Yardım alın ve destekle iletişime geçin',
          'onTap': (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HelpSupportScreen()),
            );
          },
        },
        {
          'icon': Icons.settings_outlined,
          'title': 'Ayarlar',
          'subtitle': 'Uygulama tercihleri ve hesap ayarları',
          'onTap': (context) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        },
      ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    backgroundImage: const NetworkImage(
                      'https://avatars.githubusercontent.com/u/100000000?v=4',
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileSettingsScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Ahmet Yılmaz',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.edit,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ahmet.yilmaz@ornek.com',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Menu Items
            Padding(
              padding: const EdgeInsets.fromLTRB(
                0,
                0,
                0,
                0, // Remove bottom padding from menu items
              ),
              child: Column(
                children: _menuItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return Column(
                    children: [
                      _buildMenuItem(
                        context,
                        icon: item['icon'],
                        title: item['title'],
                        subtitle: item['subtitle'],
                        onTap: () => item['onTap'](context),
                      ),
                      if (index < _menuItems.length - 1)
                        const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(
                height: 24), // Increased spacing before logout button

            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.error),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppConstants.radiusMedium,
                    ),
                  ),
                ),
                child: Text(
                  'Çıkış Yap',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),

            const SizedBox(height: 24), // Reduced spacing after logout button

            // App Version
            Text(
              'Sürüm ${AppConstants.appVersion}',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textHint),
            ),

            // Bottom spacing to prevent overlap with bottom navigation bar
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Çıkış Yap'),
          content: const Text('Çıkış yapmak istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Implement logout logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Çıkış özelliği çok yakında!'),
                    backgroundColor: AppColors.warning,
                  ),
                );
              },
              child: const Text(
                'Çıkış Yap',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }
}

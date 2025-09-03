import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/widgets/loading_widget.dart';
import '../../../../core/providers/session_provider.dart';
import '../../../../core/repositories/auth_repository.dart';
import '../../../../core/services/user_data_manager.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final sessionState = ref.watch(sessionProvider);
    final isLoggedIn = sessionState.isLoggedIn;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [],
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (isLoggedIn) ...[
                // Profile Header
                _buildProfileHeader(sessionState),
                const SizedBox(height: 24),

                // Profile Options
                _buildProfileOptions(),
                const SizedBox(height: 24),

                // Account Actions
                _buildAccountActions(),
              ] else ...[
                // Login/Register Section
                _buildLoginSection(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(SessionState sessionState) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundColor: sessionState.isAdmin
                  ? Colors.red.withValues(alpha: 0.1)
                  : Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.1),
              child: Icon(
                sessionState.isAdmin
                    ? Icons.admin_panel_settings
                    : Icons.person,
                size: 50,
                color: sessionState.isAdmin
                    ? Colors.red
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),

            // User Name
            Text(
              sessionState.userName ?? 'Kullanıcı',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),

            // User Email
            Text(
              sessionState.userEmail ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                  ),
            ),
            const SizedBox(height: 8),

            // Account Type Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: sessionState.isAdmin
                    ? Colors.red.withValues(alpha: 0.1)
                    : Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: sessionState.isAdmin ? Colors.red : Colors.green,
                  width: 1,
                ),
              ),
              child: Text(
                sessionState.isAdmin ? 'Admin Hesabı' : 'Kullanıcı Hesabı',
                style: TextStyle(
                  color: sessionState.isAdmin ? Colors.red : Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Edit Profile Button
            OutlinedButton.icon(
              onPressed: () {
                // TODO: Navigate to edit profile
              },
              icon: const Icon(Icons.edit),
              label: const Text('Profili Düzenle'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOptions() {
    return Card(
      child: Column(
        children: [
          _buildOptionTile(
            icon: Icons.shopping_bag_outlined,
            title: 'Siparişlerim',
            subtitle: 'Siparişlerinizi takip edin',
            onTap: () {
              context.go('/orders');
            },
          ),
          const Divider(height: 1),
          _buildOptionTile(
            icon: Icons.favorite_outline,
            title: 'Favorilerim',
            subtitle: 'Kayıtlı ürünleriniz',
            onTap: () {
              context.go('/wishlist');
            },
          ),
          const Divider(height: 1),
          _buildOptionTile(
            icon: Icons.location_on_outlined,
            title: 'Adreslerim',
            subtitle: 'Adreslerinizi yönetin',
            onTap: () {
              context.go('/addresses');
            },
          ),
          const Divider(height: 1),
          _buildOptionTile(
            icon: Icons.payment_outlined,
            title: 'Ödeme Yöntemleri',
            subtitle: 'Ödeme seçeneklerinizi yönetin',
            onTap: () {
              context.go('/payment-methods');
            },
          ),
          const Divider(height: 1),
          _buildOptionTile(
            icon: Icons.notifications_outlined,
            title: 'Bildirimler',
            subtitle: 'Bildirim tercihlerinizi yönetin',
            onTap: () {
              context.go('/notifications');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoginSection() {
    return Column(
      children: [
        // Welcome Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 80,
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'Hoş Geldiniz!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Hesabınıza giriş yapın veya yeni bir hesap oluşturun',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.7),
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Login/Register Options
        Card(
          child: Column(
            children: [
              _buildOptionTile(
                icon: Icons.login,
                title: 'Giriş Yap',
                subtitle: 'Mevcut hesabınızla giriş yapın',
                onTap: () {
                  context.go('/login');
                },
              ),
              const Divider(height: 1),
              _buildOptionTile(
                icon: Icons.person_add,
                title: 'Hesap Oluştur',
                subtitle: 'Yeni bir hesap oluşturun',
                onTap: () {
                  context.go('/register');
                },
              ),
              const Divider(height: 1),
              _buildOptionTile(
                icon: Icons.g_mobiledata,
                title: 'Google ile Giriş',
                subtitle: 'Google hesabınızla hızlı giriş',
                onTap: () {
                  _signInWithGoogle();
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Guest Options
        Card(
          child: Column(
            children: [
              _buildOptionTile(
                icon: Icons.help_outline,
                title: 'Yardım & Destek',
                subtitle: 'Yardım alın ve destek ile iletişime geçin',
                onTap: () {
                  // TODO: Navigate to help
                },
              ),
              const Divider(height: 1),
              _buildOptionTile(
                icon: Icons.info_outline,
                title: 'Hakkında',
                subtitle: 'Uygulama sürümü ve bilgileri',
                onTap: () {
                  _showAboutDialog();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountActions() {
    final sessionState = ref.watch(sessionProvider);

    return Card(
      child: Column(
        children: [
          if (sessionState.isAdmin)
            _buildOptionTile(
              icon: Icons.admin_panel_settings,
              title: 'Admin Paneli',
              subtitle: 'Yönetim paneline erişin',
              onTap: () {
                context.go('/admin');
              },
            ),
          if (sessionState.isAdmin) const Divider(height: 1),
          _buildOptionTile(
            icon: Icons.lock_outline,
            title: 'Parola Değiştir',
            subtitle: 'Hesap parolanızı güncelleyin',
            onTap: _showChangePasswordDialog,
          ),
          const Divider(height: 1),
          _buildOptionTile(
            icon: Icons.help_outline,
            title: 'Yardım & Destek',
            subtitle: 'Yardım alın ve destek ile iletişime geçin',
            onTap: () {
              context.go('/support');
            },
          ),
          const Divider(height: 1),
          _buildOptionTile(
            icon: Icons.info_outline,
            title: 'Hakkında',
            subtitle: 'Uygulama sürümü ve bilgileri',
            onTap: () {
              context.go('/about');
            },
          ),
          const Divider(height: 1),
          _buildOptionTile(
            icon: Icons.storage,
            title: 'Veri Yönetimi',
            subtitle: 'Verilerinizi yedekleyin veya temizleyin',
            onTap: _showDataManagementOptions,
          ),
          const Divider(height: 1),
          _buildOptionTile(
            icon: Icons.logout,
            title: 'Çıkış Yap',
            subtitle: 'Hesabınızdan çıkış yapın',
            onTap: _signOut,
            textColor: Theme.of(context).colorScheme.error,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: textColor ?? Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'E-Commerce App',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(
        Icons.shopping_cart,
        size: 48,
      ),
      children: [
        const Text('A modern e-commerce application built with Flutter.'),
      ],
    );
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final authRepository = ref.read(authRepositoryProvider);
      final response = await authRepository.signInWithGoogle();

      if (mounted && response?.user != null) {
        // Set user session with Google account
        ref.read(sessionProvider.notifier).loginAsUser(
              response!.user!.email ?? 'user@gmail.com',
              response.user!.userMetadata?['full_name'] ??
                  response.user!.userMetadata?['name'] ??
                  'Google User',
            );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Google ile başarıyla giriş yapıldı'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google girişi başarısız: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
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

  Future<void> _signOut() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çıkış Yap'),
        content: const Text(
            'Hesabınızdan çıkış yapmak istediğinizden emin misiniz?'),
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
      setState(() {
        _isLoading = true;
      });

      try {
        // Clear session and sign out from Google if needed
        ref.read(sessionProvider.notifier).logout();

        // Navigate to home page after logout
        if (mounted) {
          context.go('/home');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Başarıyla çıkış yapıldı'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Çıkış yapılamadı: ${e.toString()}'),
              backgroundColor: Theme.of(context).colorScheme.error,
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

  void _showDataManagementOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Veri Yönetimi'),
        content: const Text('Verilerinizi nasıl yönetmek istiyorsunuz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _exportUserData();
            },
            child: const Text('Verileri Yedekle'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _clearAllUserData();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Tüm Verileri Temizle'),
          ),
        ],
      ),
    );
  }

  Future<void> _exportUserData() async {
    try {
      await UserDataManager.exportUserData();

      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Veri Yedekleme'),
            content: const Text(
                'Verileriniz başarıyla yedeklendi. Bu verileri daha sonra geri yükleyebilirsiniz.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Tamam'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Veri yedekleme hatası: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _clearAllUserData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tüm Verileri Temizle'),
        content: const Text(
            'Bu işlem geri alınamaz! Tüm verileriniz (sepet, favoriler, adresler, ödeme yöntemleri, siparişler) silinecektir. Emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Temizle'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await UserDataManager.clearAllUserData();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tüm veriler temizlendi'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Veri temizleme hatası: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  void _showChangePasswordDialog() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool obscureCurrentPassword = true;
    bool obscureNewPassword = true;
    bool obscureConfirmPassword = true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Parola Değiştir'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: currentPasswordController,
                  obscureText: obscureCurrentPassword,
                  decoration: InputDecoration(
                    labelText: 'Mevcut Parola *',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureCurrentPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureCurrentPassword = !obscureCurrentPassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: newPasswordController,
                  obscureText: obscureNewPassword,
                  decoration: InputDecoration(
                    labelText: 'Yeni Parola *',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureNewPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureNewPassword = !obscureNewPassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Yeni Parola Tekrar *',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureConfirmPassword = !obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Parola Gereksinimleri:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '• En az 6 karakter',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      Text(
                        '• En fazla 128 karakter',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Validation
                if (currentPasswordController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Mevcut parola gereklidir'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (newPasswordController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Yeni parola gereklidir'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (newPasswordController.text.trim().length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Yeni parola en az 6 karakter olmalıdır'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (newPasswordController.text.trim().length > 128) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Yeni parola en fazla 128 karakter olmalıdır'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (newPasswordController.text.trim() !=
                    confirmPasswordController.text.trim()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Yeni parolalar eşleşmiyor'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (currentPasswordController.text.trim() ==
                    newPasswordController.text.trim()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Yeni parola mevcut paroladan farklı olmalıdır'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // Show loading
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const AlertDialog(
                    content: Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 16),
                        Text('Parola değiştiriliyor...'),
                      ],
                    ),
                  ),
                );

                try {
                  // Simulate password change API call
                  await Future.delayed(const Duration(seconds: 2));

                  // Close loading dialog
                  Navigator.of(context).pop();

                  // Close password change dialog
                  Navigator.of(context).pop();

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Parola başarıyla değiştirildi'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  // Close loading dialog
                  Navigator.of(context).pop();

                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Parola değiştirme hatası: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Değiştir'),
            ),
          ],
        ),
      ),
    );
  }
}

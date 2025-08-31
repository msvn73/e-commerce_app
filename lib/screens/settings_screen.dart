import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  String _selectedLanguage = 'Türkçe';
  String _selectedCurrency = '₺ TL';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Ayarlar'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(AppConstants.paddingLarge),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppConstants.radiusMedium),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.settings,
                      color: AppColors.primary,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Uygulama Ayarları',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Uygulama tercihlerinizi buradan yönetebilirsiniz',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppConstants.paddingLarge),

              // Bildirim Ayarları
              _buildSectionHeader('Bildirimler'),
              _buildSwitchTile(
                icon: Icons.notifications,
                title: 'Bildirimler',
                subtitle: 'Uygulama bildirimlerini al',
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
              _buildSwitchTile(
                icon: Icons.volume_up,
                title: 'Ses',
                subtitle: 'Bildirim sesi çal',
                value: _soundEnabled,
                onChanged: (value) {
                  setState(() {
                    _soundEnabled = value;
                  });
                },
              ),
              _buildSwitchTile(
                icon: Icons.vibration,
                title: 'Titreşim',
                subtitle: 'Bildirim titreşimi',
                value: _vibrationEnabled,
                onChanged: (value) {
                  setState(() {
                    _vibrationEnabled = value;
                  });
                },
              ),

              const SizedBox(height: AppConstants.paddingMedium),

              // Dil ve Para Birimi
              _buildSectionHeader('Dil ve Para Birimi'),
              _buildListTile(
                icon: Icons.language,
                title: 'Dil',
                subtitle: _selectedLanguage,
                onTap: () => _showLanguageDialog(context),
              ),
              _buildListTile(
                icon: Icons.attach_money,
                title: 'Para Birimi',
                subtitle: _selectedCurrency,
                onTap: () => _showCurrencyDialog(context),
              ),

              const SizedBox(height: AppConstants.paddingMedium),

              // Hesap Ayarları
              _buildSectionHeader('Hesap'),
              _buildListTile(
                icon: Icons.person,
                title: 'Profil Bilgileri',
                subtitle: 'Ad, e-posta ve telefon',
                onTap: () {
                  Navigator.of(context).pushNamed('/profile-settings');
                },
              ),
              _buildListTile(
                icon: Icons.lock,
                title: 'Şifre Değiştir',
                subtitle: 'Hesap şifrenizi güncelleyin',
                onTap: () {
                  Navigator.of(context).pushNamed('/profile-settings');
                },
              ),

              const SizedBox(height: AppConstants.paddingMedium),

              // Uygulama Bilgileri
              _buildSectionHeader('Uygulama'),
              _buildListTile(
                icon: Icons.info,
                title: 'Hakkında',
                subtitle: 'Sürüm ${AppConstants.appVersion}',
                onTap: () {
                  _showAboutDialog(context);
                },
              ),
              _buildListTile(
                icon: Icons.privacy_tip,
                title: 'Gizlilik Politikası',
                subtitle: 'Veri kullanımı ve gizlilik',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Gizlilik politikası çok yakında!'),
                      backgroundColor: AppColors.warning,
                    ),
                  );
                },
              ),
              _buildListTile(
                icon: Icons.description,
                title: 'Kullanım Şartları',
                subtitle: 'Uygulama kullanım koşulları',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Kullanım şartları çok yakında!'),
                      backgroundColor: AppColors.warning,
                    ),
                  );
                },
              ),

              const SizedBox(height: AppConstants.paddingLarge),

              // Kaydet Butonu
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    _saveSettings();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMedium),
                    ),
                  ),
                  child: const Text(
                    'Ayarları Kaydet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppConstants.paddingLarge),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingMedium),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
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
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingSmall,
        ),
        secondary: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primary,
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
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
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingSmall,
        ),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textHint),
        onTap: onTap,
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final languages = ['Türkçe', 'English', 'Deutsch', 'Français', 'Español'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dil Seçin'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: languages.length,
              itemBuilder: (context, index) {
                final language = languages[index];
                return ListTile(
                  title: Text(language),
                  trailing: _selectedLanguage == language
                      ? const Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedLanguage = language;
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showCurrencyDialog(BuildContext context) {
    final currencies = ['₺ TL', '€ EUR', r'$ USD', '£ GBP', '¥ JPY'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Para Birimi Seçin'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: currencies.length,
              itemBuilder: (context, index) {
                final currency = currencies[index];
                return ListTile(
                  title: Text(currency),
                  trailing: _selectedCurrency == currency
                      ? const Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedCurrency = currency;
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Uygulama Hakkında'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sürüm: ${AppConstants.appVersion}'),
              SizedBox(height: 8),
              Text('E-Ticaret Uygulaması'),
              SizedBox(height: 8),
              Text('© 2024 Tüm hakları saklıdır.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  void _saveSettings() {
    // TODO: Implement settings save logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ayarlar başarıyla kaydedildi!'),
        backgroundColor: AppColors.success,
      ),
    );
  }
}

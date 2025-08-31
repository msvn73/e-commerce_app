import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Yardım ve Destek'),
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
                      Icons.help_outline,
                      color: AppColors.primary,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Yardıma mı ihtiyacınız var?',
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
                            'Size yardımcı olmaya hazırız',
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

              // İletişim Bilgileri
              _buildSectionHeader('İletişim Bilgileri'),
              _buildContactCard(
                context,
                icon: Icons.phone,
                title: 'Telefon',
                subtitle: '+90 (212) 555 0123',
                actionText: 'Ara',
                onTap: () {
                  // TODO: Implement phone call
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Telefon araması başlatılıyor...'),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
              ),
              _buildContactCard(
                context,
                icon: Icons.email,
                title: 'E-posta',
                subtitle: 'destek@eticaret.com',
                actionText: 'E-posta Gönder',
                onTap: () {
                  // TODO: Implement email
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('E-posta uygulaması açılıyor...'),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
              ),
              _buildContactCard(
                context,
                icon: Icons.chat,
                title: 'Canlı Destek',
                subtitle: '7/24 online destek',
                actionText: 'Başlat',
                onTap: () {
                  // TODO: Implement live chat
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Canlı destek başlatılıyor...'),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
              ),

              const SizedBox(height: AppConstants.paddingMedium),

              // Çalışma Saatleri
              _buildSectionHeader('Çalışma Saatleri'),
              Container(
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius:
                      BorderRadius.circular(AppConstants.radiusMedium),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildWorkingHourRow('Pazartesi - Cuma', '09:00 - 18:00'),
                    const Divider(),
                    _buildWorkingHourRow('Cumartesi', '10:00 - 16:00'),
                    const Divider(),
                    _buildWorkingHourRow('Pazar', 'Kapalı'),
                  ],
                ),
              ),

              const SizedBox(height: AppConstants.paddingMedium),

              // Sık Sorulan Sorular
              _buildSectionHeader('Sık Sorulan Sorular'),
              _buildFAQItem(
                context,
                question: 'Siparişimi nasıl takip edebilirim?',
                answer:
                    'Profil sayfasındaki "Siparişlerim" bölümünden tüm siparişlerinizi takip edebilirsiniz.',
              ),
              _buildFAQItem(
                context,
                question: 'İade işlemi nasıl yapılır?',
                answer:
                    'Sipariş tesliminden sonra 14 gün içinde iade talebinde bulunabilirsiniz.',
              ),
              _buildFAQItem(
                context,
                question: 'Kargo ücreti ne kadar?',
                answer: '150 TL üzeri alışverişlerde kargo ücretsizdir.',
              ),
              _buildFAQItem(
                context,
                question: 'Hangi ödeme yöntemleri kabul ediliyor?',
                answer:
                    'Kredi kartı, banka kartı, havale/EFT ve kapıda ödeme seçenekleri mevcuttur.',
              ),

              const SizedBox(height: AppConstants.paddingMedium),

              // Sosyal Medya
              _buildSectionHeader('Sosyal Medya'),
              Row(
                children: [
                  Expanded(
                    child: _buildSocialMediaCard(
                      context,
                      icon: Icons.facebook,
                      title: 'Facebook',
                      color: Colors.blue,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Facebook sayfası açılıyor...'),
                            backgroundColor: Colors.blue,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: AppConstants.paddingMedium),
                  Expanded(
                    child: _buildSocialMediaCard(
                      context,
                      icon: Icons.camera_alt,
                      title: 'Instagram',
                      color: Colors.purple,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Instagram sayfası açılıyor...'),
                            backgroundColor: Colors.purple,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: AppConstants.paddingMedium),
                  Expanded(
                    child: _buildSocialMediaCard(
                      context,
                      icon: Icons.flutter_dash,
                      title: 'Twitter',
                      color: Colors.lightBlue,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Twitter sayfası açılıyor...'),
                            backgroundColor: Colors.lightBlue,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppConstants.paddingLarge),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Builder(
      builder: (context) => Padding(
        padding:
            const EdgeInsets.symmetric(vertical: AppConstants.paddingMedium),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionText,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
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
        contentPadding: const EdgeInsets.all(AppConstants.paddingMedium),
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
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        trailing: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
            ),
          ),
          child: Text(actionText),
        ),
      ),
    );
  }

  Widget _buildWorkingHourRow(String day, String hours) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            hours,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(
    BuildContext context, {
    required String question,
    required String answer,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
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
      child: ExpansionTile(
        title: Text(
          question,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Text(
              answer,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

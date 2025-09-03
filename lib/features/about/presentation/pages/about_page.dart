import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AboutPage extends ConsumerStatefulWidget {
  const AboutPage({super.key});

  @override
  ConsumerState<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends ConsumerState<AboutPage> {
  final String _companyInfo = '''
E-Commerce App, 2024 yılında kurulmuş modern bir e-ticaret platformudur. 

Misyonumuz:
Müşterilerimize en kaliteli ürünleri, en uygun fiyatlarla ve en hızlı şekilde ulaştırmaktır.

Vizyonumuz:
Türkiye'nin önde gelen e-ticaret platformlarından biri olmak ve müşteri memnuniyetini her zaman ön planda tutmaktır.

Değerlerimiz:
• Müşteri odaklılık
• Kalite ve güvenilirlik
• İnovasyon
• Şeffaflık
• Sürdürülebilirlik

İletişim Bilgileri:
Adres: Atatürk Mahallesi, Teknoloji Caddesi No: 123, İstanbul
Telefon: +90 212 555 0123
E-posta: info@ecommerce.com
Web: www.ecommerce.com

Çalışma Saatleri:
Pazartesi - Cuma: 09:00 - 18:00
Cumartesi: 10:00 - 16:00
Pazar: Kapalı

Sosyal Medya:
Instagram: @ecommerce_app
Twitter: @ecommerce_app
Facebook: E-Commerce App
LinkedIn: E-Commerce App
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Hakkında'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/profile'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editCompanyInfo,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // App Info Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.shopping_cart,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'E-Commerce App',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Versiyon 1.0.0',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Modern e-ticaret deneyimi için tasarlanmış mobil uygulama',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Company Info Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.business, color: Colors.red),
                      const SizedBox(width: 8),
                      const Text(
                        'Şirket Hakkında',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _companyInfo,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Features Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.red),
                      const SizedBox(width: 8),
                      const Text(
                        'Uygulama Özellikleri',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    icon: Icons.shopping_bag,
                    title: 'Geniş Ürün Yelpazesi',
                    description: 'Binlerce kaliteli ürün seçeneği',
                  ),
                  _buildFeatureItem(
                    icon: Icons.security,
                    title: 'Güvenli Ödeme',
                    description: 'SSL şifreleme ile güvenli alışveriş',
                  ),
                  _buildFeatureItem(
                    icon: Icons.local_shipping,
                    title: 'Hızlı Kargo',
                    description: 'Aynı gün kargo imkanı',
                  ),
                  _buildFeatureItem(
                    icon: Icons.support_agent,
                    title: '7/24 Destek',
                    description: 'Kesintisiz müşteri hizmetleri',
                  ),
                  _buildFeatureItem(
                    icon: Icons.phone_android,
                    title: 'Mobil Uyumlu',
                    description: 'Tüm cihazlarda mükemmel deneyim',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Legal Info Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.gavel, color: Colors.red),
                      const SizedBox(width: 8),
                      const Text(
                        'Yasal Bilgiler',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildLegalItem(
                    title: 'Kullanım Şartları',
                    onTap: () => _showLegalDocument('Kullanım Şartları'),
                  ),
                  _buildLegalItem(
                    title: 'Gizlilik Politikası',
                    onTap: () => _showLegalDocument('Gizlilik Politikası'),
                  ),
                  _buildLegalItem(
                    title: 'Çerez Politikası',
                    onTap: () => _showLegalDocument('Çerez Politikası'),
                  ),
                  _buildLegalItem(
                    title: 'İade ve Değişim',
                    onTap: () => _showLegalDocument('İade ve Değişim'),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Developer Info Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.code, color: Colors.red),
                      const SizedBox(width: 8),
                      const Text(
                        'Geliştirici Bilgileri',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Bu uygulama Flutter framework kullanılarak geliştirilmiştir.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Teknolojiler: Flutter, Dart, Supabase, Riverpod',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.red, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalItem({
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.description, color: Colors.grey),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  void _editCompanyInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Şirket Bilgilerini Düzenle'),
        content: const Text(
            'Bu özellik sadece admin kullanıcıları tarafından kullanılabilir.'),
        actions: [
          TextButton(
            onPressed: () => context.go('/profile'),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  void _showLegalDocument(String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: const Text(
          'Bu dokümanın tam içeriği yakında eklenecektir. '
          'Şu anda geliştirme aşamasındadır.',
        ),
        actions: [
          TextButton(
            onPressed: () => context.go('/profile'),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }
}

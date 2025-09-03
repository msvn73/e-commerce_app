import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SupportPage extends ConsumerStatefulWidget {
  const SupportPage({super.key});

  @override
  ConsumerState<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends ConsumerState<SupportPage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  String _selectedCategory = 'Genel';

  final List<String> _categories = [
    'Genel',
    'Sipariş Sorunu',
    'Ödeme Sorunu',
    'Kargo Sorunu',
    'Ürün Sorunu',
    'Hesap Sorunu',
    'Teknik Destek',
  ];

  final List<Map<String, dynamic>> _faqs = [
    {
      'question': 'Siparişimi nasıl takip edebilirim?',
      'answer':
          'Siparişinizi "Siparişlerim" bölümünden takip edebilirsiniz. Kargo takip numarası ile detaylı bilgi alabilirsiniz.',
    },
    {
      'question': 'İade işlemi nasıl yapılır?',
      'answer':
          'Ürünü teslim aldığınız tarihten itibaren 14 gün içinde iade edebilirsiniz. İade formunu doldurarak başvuru yapabilirsiniz.',
    },
    {
      'question': 'Hangi ödeme yöntemlerini kabul ediyorsunuz?',
      'answer':
          'Kredi kartı, banka kartı, Stripe, Iyzico ve PayPal ile ödeme yapabilirsiniz.',
    },
    {
      'question': 'Kargo ücreti ne kadar?',
      'answer':
          '150 TL ve üzeri alışverişlerde kargo ücretsizdir. Altındaki siparişlerde 15 TL kargo ücreti alınır.',
    },
    {
      'question': 'Ürün stokta yok, ne zaman gelir?',
      'answer':
          'Stok durumu hakkında bilgi almak için ürün sayfasındaki "Stok Bildirimi" özelliğini kullanabilirsiniz.',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Yardım & Destek'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Contact Options
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'İletişim Seçenekleri',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildContactOption(
                    icon: Icons.phone,
                    title: 'Telefon Desteği',
                    subtitle: '7/24 müşteri hizmetleri',
                    action: '+90 212 555 0123',
                    onTap: () => _makePhoneCall(),
                  ),
                  _buildContactOption(
                    icon: Icons.email,
                    title: 'E-posta Desteği',
                    subtitle: '24 saat içinde yanıt',
                    action: 'destek@ecommerce.com',
                    onTap: () => _sendEmail(),
                  ),
                  _buildContactOption(
                    icon: Icons.chat,
                    title: 'Canlı Destek',
                    subtitle: 'Anında yardım alın',
                    action: 'Şimdi Başlat',
                    onTap: () => _startLiveChat(),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // FAQ Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sık Sorulan Sorular',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._faqs.map((faq) => _buildFAQItem(faq)).toList(),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Contact Form
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bize Mesaj Gönderin',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Kategori',
                      border: OutlineInputBorder(),
                    ),
                    items: _categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _subjectController,
                    decoration: const InputDecoration(
                      labelText: 'Konu',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'E-posta Adresiniz',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      labelText: 'Mesajınız',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _sendMessage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Mesaj Gönder'),
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

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required String action,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.red),
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
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                action,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(Map<String, dynamic> faq) {
    return ExpansionTile(
      title: Text(
        faq['question'],
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            faq['answer'],
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  void _makePhoneCall() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Telefon Desteği'),
        content: const Text(
            '+90 212 555 0123 numaralı telefonu aramak istiyor musunuz?'),
        actions: [
          TextButton(
            onPressed: () => context.go('/profile'),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Telefon uygulaması açılıyor...'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Ara'),
          ),
        ],
      ),
    );
  }

  void _sendEmail() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('E-posta Desteği'),
        content: const Text(
            'destek@ecommerce.com adresine e-posta göndermek istiyor musunuz?'),
        actions: [
          TextButton(
            onPressed: () => context.go('/profile'),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('E-posta uygulaması açılıyor...'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('E-posta Gönder'),
          ),
        ],
      ),
    );
  }

  void _startLiveChat() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Canlı Destek'),
        content: const Text(
            'Canlı destek başlatılıyor. Bir temsilcimiz sizinle yakında iletişime geçecek.'),
        actions: [
          TextButton(
            onPressed: () => context.go('/profile'),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Canlı destek başlatıldı'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Başlat'),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_subjectController.text.isEmpty || _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen konu ve mesaj alanlarını doldurun'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mesaj Gönderildi'),
        content: const Text(
            'Mesajınız başarıyla gönderildi. En kısa sürede size dönüş yapacağız.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _subjectController.clear();
              _messageController.clear();
              _emailController.clear();
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import 'add_payment_card_screen.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  // Demo kayıtlı kartlar (gerçek uygulamada Supabase'den gelecek)
  final List<Map<String, dynamic>> _savedCards = [
    {
      'id': '1',
      'cardNumber': '**** **** **** 1234',
      'cardHolder': 'Mert Sevinç',
      'expiryMonth': '12',
      'expiryYear': '25',
      'expiryDate': '12/25',
      'cardType': 'Visa',
      'isDefault': true,
      'cvv': '123',
    },
    {
      'id': '2',
      'cardNumber': '**** **** **** 5678',
      'cardHolder': 'Mert Sevinç',
      'expiryMonth': '08',
      'expiryYear': '26',
      'expiryDate': '08/26',
      'cardType': 'Mastercard',
      'isDefault': false,
      'cvv': '456',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Ödeme Yöntemleri'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.payment,
                  color: AppColors.primary,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Güvenli Ödeme',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Kredi kartı ve banka kartı bilgilerinizi güvenle saklayın',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          Expanded(
            child: _savedCards.isEmpty
                ? _buildEmptyState()
                : _buildSavedCardsList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPaymentCardScreen(),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Kart Ekle'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.credit_card_off,
            size: 80,
            color: AppColors.textHint,
          ),
          const SizedBox(height: 24),
          Text(
            'Henüz kayıtlı kartınız yok',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'İlk kartınızı ekleyerek hızlı ödeme yapabilirsiniz',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textHint,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPaymentCardScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('İlk Kartınızı Ekleyin'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedCardsList() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 120),
      child: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        itemCount: _savedCards.length,
        itemBuilder: (context, index) {
          final card = _savedCards[index];
          return _buildCardItem(card, index);
        },
      ),
    );
  }

  Widget _buildCardItem(Map<String, dynamic> card, int index) {
    final isDefault = card['isDefault'] as bool;
    final cardType = card['cardType'] as String;

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
      child: Column(
        children: [
          // Kart Bilgileri
          Container(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppConstants.radiusMedium),
                topRight: Radius.circular(AppConstants.radiusMedium),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  _getCardTypeIcon(cardType),
                  color: Colors.white,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        card['cardNumber'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            card['cardHolder'],
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Son Kullanma: ${card['expiryDate']}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isDefault)
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Varsayılan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Aksiyon Butonları
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Row(
              children: [
                if (!isDefault)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _setAsDefault(card['id']),
                      icon: const Icon(Icons.star_outline),
                      label: const Text('Varsayılan Yap'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        foregroundColor: AppColors.primary,
                      ),
                    ),
                  ),
                if (!isDefault) const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _editCard(card),
                    icon: const Icon(Icons.edit),
                    label: const Text('Düzenle'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.textSecondary),
                      foregroundColor: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _deleteCard(card['id']),
                    icon: const Icon(Icons.delete),
                    label: const Text('Sil'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.error),
                      foregroundColor: AppColors.error,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCardTypeIcon(String cardType) {
    switch (cardType.toLowerCase()) {
      case 'visa':
        return Icons.credit_card;
      case 'mastercard':
        return Icons.credit_card;
      case 'amex':
        return Icons.credit_card;
      default:
        return Icons.credit_card;
    }
  }

  void _setAsDefault(String cardId) {
    setState(() {
      for (var card in _savedCards) {
        card['isDefault'] = card['id'] == cardId;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Varsayılan kart güncellendi'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _editCard(Map<String, dynamic> card) {
    // Navigate to add payment card screen with pre-filled data for editing
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPaymentCardScreen(
          isEditing: true,
          cardData: card,
        ),
      ),
    ).then((editedCard) {
      // If a card was edited and returned, update the local list
      if (editedCard != null && editedCard is Map<String, dynamic>) {
        setState(() {
          final index =
              _savedCards.indexWhere((c) => c['id'] == editedCard['id']);
          if (index != -1) {
            _savedCards[index] = editedCard;
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kart başarıyla güncellendi!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    });
  }

  void _deleteCard(String cardId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kartı Sil'),
          content: const Text(
            'Bu kartı silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _savedCards.removeWhere((card) => card['id'] == cardId);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Kart başarıyla silindi'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              child: const Text('Sil'),
            ),
          ],
        );
      },
    );
  }
}

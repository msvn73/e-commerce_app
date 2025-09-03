import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/user_data_manager.dart';

class PaymentMethodsPage extends ConsumerStatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  ConsumerState<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends ConsumerState<PaymentMethodsPage> {
  List<Map<String, dynamic>> _paymentMethods = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPaymentMethods();
  }

  Future<void> _loadPaymentMethods() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final methods = await UserDataManager.getPaymentMethods();
      setState(() {
        _paymentMethods = methods;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ödeme yöntemleri yüklenirken hata: $e')),
        );
      }
    }
  }

  Future<void> _addPaymentMethod(Map<String, dynamic> method) async {
    await UserDataManager.addPaymentMethod(method);
    await _loadPaymentMethods();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ödeme yöntemi eklendi')),
      );
    }
  }

  Future<void> _updatePaymentMethod(
      String methodId, Map<String, dynamic> method) async {
    await UserDataManager.updatePaymentMethod(methodId, method);
    await _loadPaymentMethods();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ödeme yöntemi güncellendi')),
      );
    }
  }

  Future<void> _deletePaymentMethod(String methodId) async {
    await UserDataManager.deletePaymentMethod(methodId);
    await _loadPaymentMethods();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ödeme yöntemi silindi')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Ödeme Yöntemleri'),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/profile'),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Ödeme Yöntemleri'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddPaymentMethodDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Payment Options
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ödeme Seçenekleri',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                _buildPaymentOption(
                  title: 'Stripe',
                  subtitle: 'Güvenli kredi kartı ödemeleri',
                  icon: Icons.credit_card,
                  color: Colors.blue,
                  onTap: () => _showPaymentInfo('Stripe'),
                ),
                const SizedBox(height: 12),
                _buildPaymentOption(
                  title: 'Iyzico',
                  subtitle: 'Türkiye\'nin önde gelen ödeme çözümü',
                  icon: Icons.payment,
                  color: Colors.orange,
                  onTap: () => _showPaymentInfo('Iyzico'),
                ),
                const SizedBox(height: 12),
                _buildPaymentOption(
                  title: 'PayPal',
                  subtitle: 'Dünya çapında güvenli ödeme',
                  icon: Icons.account_balance_wallet,
                  color: Colors.indigo,
                  onTap: () => _showPaymentInfo('PayPal'),
                ),
              ],
            ),
          ),

          const Divider(),

          // Saved Payment Methods
          Expanded(
            child: _paymentMethods.isEmpty
                ? _buildEmptyPaymentMethods()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Kayıtlı Ödeme Yöntemleri',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount: _paymentMethods.length,
                          itemBuilder: (context, index) {
                            final method = _paymentMethods[index];
                            return _buildPaymentMethodCard(method, index);
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPaymentMethodDialog,
        backgroundColor: Colors.red,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildEmptyPaymentMethods() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.credit_card_off,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Kayıtlı ödeme yöntemi yok',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Hızlı ödeme için kart bilgilerinizi kaydedin',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade500,
                ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showAddPaymentMethodDialog,
            icon: const Icon(Icons.add_card),
            label: const Text('Kart Ekle'),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(Map<String, dynamic> method, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.credit_card,
                      color: method['provider'] == 'Visa'
                          ? Colors.blue
                          : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${method['provider']} •••• ${method['lastFour']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (method['isDefault']) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green),
                        ),
                        child: const Text(
                          'Varsayılan',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        _editPaymentMethod(method, index);
                        break;
                      case 'delete':
                        _showDeleteDialog(method['id']);
                        break;
                      case 'setDefault':
                        _setAsDefault(index);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 20),
                          SizedBox(width: 8),
                          Text('Düzenle'),
                        ],
                      ),
                    ),
                    if (!method['isDefault'])
                      const PopupMenuItem(
                        value: 'setDefault',
                        child: Row(
                          children: [
                            Icon(Icons.star, size: 20),
                            SizedBox(width: 8),
                            Text('Varsayılan Yap'),
                          ],
                        ),
                      ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 20, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Sil', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              method['cardholderName'],
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Son kullanma: ${method['expiryMonth']}/${method['expiryYear']}',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentInfo(String provider) {
    String description = '';
    switch (provider) {
      case 'Stripe':
        description =
            'Stripe, dünya çapında milyonlarca işletme tarafından kullanılan güvenli ödeme altyapısıdır. Kredi kartı bilgileriniz şifrelenerek korunur.';
        break;
      case 'Iyzico':
        description =
            'Iyzico, Türkiye\'nin önde gelen ödeme çözüm sağlayıcısıdır. Tüm yerli ve yabancı kredi kartlarını kabul eder.';
        break;
      case 'PayPal':
        description =
            'PayPal, dünya çapında güvenilir ödeme platformudur. PayPal hesabınızla hızlı ve güvenli ödeme yapabilirsiniz.';
        break;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(provider),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () => context.go('/profile'),
            child: const Text('Kapat'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showAddPaymentMethodDialog();
            },
            child: const Text('Kart Ekle'),
          ),
        ],
      ),
    );
  }

  void _showAddPaymentMethodDialog() {
    _showPaymentMethodDialog();
  }

  void _editPaymentMethod(Map<String, dynamic> method, int index) {
    _showPaymentMethodDialog(method: method, index: index);
  }

  void _showDeleteDialog(String methodId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ödeme Yöntemini Sil'),
        content: const Text(
            'Bu ödeme yöntemini silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => context.go('/profile'),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deletePaymentMethod(methodId);
            },
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }

  void _setAsDefault(int index) {
    setState(() {
      for (int i = 0; i < _paymentMethods.length; i++) {
        _paymentMethods[i]['isDefault'] = i == index;
      }
    });
    // Save updated payment methods
    UserDataManager.savePaymentMethods(_paymentMethods);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Varsayılan ödeme yöntemi güncellendi'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showPaymentMethodDialog({Map<String, dynamic>? method, int? index}) {
    final cardNumberController =
        TextEditingController(text: method?['lastFour'] ?? '');
    final expiryMonthController =
        TextEditingController(text: method?['expiryMonth'] ?? '');
    final expiryYearController =
        TextEditingController(text: method?['expiryYear'] ?? '');
    final cardholderNameController =
        TextEditingController(text: method?['cardholderName'] ?? '');
    final cvvController = TextEditingController();
    String selectedProvider = method?['provider'] ?? 'Visa';
    bool isDefault = method?['isDefault'] ?? false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(method == null ? 'Yeni Kart Ekle' : 'Kartı Düzenle'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedProvider,
                  decoration: const InputDecoration(
                    labelText: 'Kart Türü',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Visa', 'Mastercard', 'American Express']
                      .map((provider) {
                    return DropdownMenuItem(
                      value: provider,
                      child: Text(provider),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setDialogState(() {
                      selectedProvider = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: cardNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Kart Numarası',
                    border: OutlineInputBorder(),
                    hintText: '1234 5678 9012 3456',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: cardholderNameController,
                  decoration: const InputDecoration(
                    labelText: 'Kart Sahibi Adı',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.characters,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: expiryMonthController,
                        decoration: const InputDecoration(
                          labelText: 'Ay',
                          border: OutlineInputBorder(),
                          hintText: 'MM',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: expiryYearController,
                        decoration: const InputDecoration(
                          labelText: 'Yıl',
                          border: OutlineInputBorder(),
                          hintText: 'YY',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: cvvController,
                        decoration: const InputDecoration(
                          labelText: 'CVV',
                          border: OutlineInputBorder(),
                          hintText: '123',
                        ),
                        keyboardType: TextInputType.number,
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (method == null || !method['isDefault'])
                  CheckboxListTile(
                    title: const Text('Varsayılan ödeme yöntemi yap'),
                    value: isDefault,
                    onChanged: (value) {
                      setDialogState(() {
                        isDefault = value ?? false;
                      });
                    },
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.go('/profile'),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (cardNumberController.text.isNotEmpty &&
                    cardholderNameController.text.isNotEmpty &&
                    expiryMonthController.text.isNotEmpty &&
                    expiryYearController.text.isNotEmpty) {
                  final newMethod = {
                    'id': method?['id'] ??
                        DateTime.now().millisecondsSinceEpoch.toString(),
                    'type': 'credit_card',
                    'provider': selectedProvider,
                    'lastFour': cardNumberController.text.length >= 4
                        ? cardNumberController.text
                            .substring(cardNumberController.text.length - 4)
                        : cardNumberController.text,
                    'expiryMonth': expiryMonthController.text,
                    'expiryYear': expiryYearController.text,
                    'cardholderName': cardholderNameController.text,
                    'isDefault': isDefault,
                  };

                  Navigator.of(context).pop();

                  if (index != null) {
                    _updatePaymentMethod(method!['id'], newMethod);
                  } else {
                    _addPaymentMethod(newMethod);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lütfen gerekli alanları doldurun'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text(method == null ? 'Ekle' : 'Güncelle'),
            ),
          ],
        ),
      ),
    );
  }
}

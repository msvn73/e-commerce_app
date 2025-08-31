import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/cart_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../services/stripe_service.dart';
import '../services/address_service.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  bool _isProcessingPayment = false;
  Map<String, dynamic>? _savedAddress;
  final String _selectedPaymentMethod = 'Kredi Kartı';

  @override
  void initState() {
    super.initState();
    _loadSavedAddress();
  }

  Future<void> _loadSavedAddress() async {
    try {
      final address = await AddressService.loadDeliveryAddress();
      setState(() {
        _savedAddress = address;
      });
    } catch (e) {
      print('Adres yüklenirken hata: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final cartTotal = ref.watch(cartProvider.notifier).totalPrice;
    final itemCount = ref.watch(cartProvider.notifier).itemCount;

    if (cartItems.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Sepetim'),
          backgroundColor: AppColors.surface,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_cart_outlined,
                size: 80,
                color: AppColors.textHint,
              ),
              const SizedBox(height: 16),
              Text(
                'Sepetiniz boş',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textHint,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Alışverişe başlamak için ürünleri keşfedin',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: const Text('Alışverişe Başla'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Sepetim'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          if (itemCount > 0)
            IconButton(
              onPressed: () => _showClearCartDialog(context),
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Sepeti Temizle',
            ),
        ],
      ),
      body: Column(
        children: [
          // Sepet Ürünleri
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return _buildCartItemCard(cartItem);
              },
            ),
          ),

          // Sipariş Özeti ve Ödeme
          _buildOrderSummary(cartTotal, itemCount),
        ],
      ),
    );
  }

  Widget _buildCartItemCard(CartItem cartItem) {
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
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Row(
          children: [
            // Ürün Resmi
            ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
              child: Image.network(
                cartItem.product.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: AppColors.surfaceVariant,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: AppColors.textHint,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: AppConstants.paddingMedium),

            // Ürün Bilgileri
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Miktar: ${cartItem.quantity}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${cartItem.product.price.toStringAsFixed(2)} ₺',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),

            // Miktar Kontrolleri
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    if (cartItem.quantity > 1) {
                      ref.read(cartProvider.notifier).updateQuantity(
                            cartItem.product.id,
                            cartItem.quantity - 1,
                          );
                    }
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                  color: AppColors.primary,
                ),
                Text(
                  '${cartItem.quantity}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                IconButton(
                  onPressed: () {
                    ref.read(cartProvider.notifier).updateQuantity(
                          cartItem.product.id,
                          cartItem.quantity + 1,
                        );
                  },
                  icon: const Icon(Icons.add_circle_outline),
                  color: AppColors.primary,
                ),
              ],
            ),

            // Silme Butonu
            IconButton(
              onPressed: () {
                ref
                    .read(cartProvider.notifier)
                    .removeFromCart(cartItem.product.id);
              },
              icon: const Icon(Icons.delete_outline),
              color: AppColors.error,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(double cartTotal, int itemCount) {
    final tax = cartTotal * 0.18; // %18 KDV

    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusLarge),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sipariş Özeti Başlığı
          Row(
            children: [
              const Icon(Icons.receipt_long, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Sipariş Özeti',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingMedium),

          // Ürün Toplamı
          _buildSummaryRow('Ürün Toplamı ($itemCount ürün)', cartTotal),

          // Kargo Ücreti
          _buildSummaryRow('Kargo Ücreti', 0.0, isFree: true),

          // Vergi
          _buildSummaryRow('KDV (%18)', tax),

          const Divider(height: 24),

          // Genel Toplam
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Genel Toplam',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                '${(cartTotal + tax).toStringAsFixed(2)} ₺',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
              ),
            ],
          ),

          const SizedBox(height: AppConstants.paddingLarge),

          // Teslimat Adresi
          _buildDeliveryAddressSection(),

          const SizedBox(height: AppConstants.paddingMedium),

          // Ödeme Yöntemi
          _buildPaymentMethodSection(),

          const SizedBox(height: AppConstants.paddingLarge),

          // Ödeme Butonu
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isProcessingPayment ? null : _processPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppConstants.radiusMedium),
                ),
              ),
              child: _isProcessingPayment
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      '${(cartTotal + tax).toStringAsFixed(2)} ₺ Öde',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),

          // Bottom padding to prevent overlap with bottom navigation bar
          const SizedBox(height: 120),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isFree = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          Text(
            isFree ? 'Ücretsiz' : '${amount.toStringAsFixed(2)} ₺',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isFree ? AppColors.success : AppColors.textPrimary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              'Teslimat Adresi',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => context.push('/delivery-address'),
              child: const Text('Düzenle'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (_savedAddress != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _savedAddress!['fullName'] ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_savedAddress!['street'] ?? ''}, ${_savedAddress!['building'] ?? ''}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                Text(
                  '${_savedAddress!['neighborhood'] ?? ''}, ${_savedAddress!['district'] ?? ''}, ${_savedAddress!['city'] ?? ''}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          )
        else
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
              border:
                  Border.all(color: AppColors.border, style: BorderStyle.solid),
            ),
            child: Row(
              children: [
                const Icon(Icons.add_location, color: AppColors.textHint),
                const SizedBox(width: 8),
                Text(
                  'Teslimat adresi eklenmemiş',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textHint,
                      ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => context.push('/delivery-address'),
                  child: const Text('Ekle'),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.payment, color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              'Ödeme Yöntemi',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => context.push('/payment-methods'),
              child: const Text('Düzenle'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const Icon(Icons.credit_card, color: AppColors.primary),
              const SizedBox(width: 12),
              Text(
                _selectedPaymentMethod,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios,
                  color: AppColors.textHint, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _processPayment() async {
    if (_savedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen önce teslimat adresi ekleyin'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isProcessingPayment = true;
    });

    try {
      final cartTotal = ref.read(cartProvider.notifier).totalPrice;
      final tax = cartTotal * 0.18;
      final totalAmount = cartTotal + tax;

      final success = await StripeService.processPayment(
        amount: totalAmount,
        currency: 'TRY',
        description: 'Drawnprint siparişi',
      );

      if (mounted) {
        setState(() {
          _isProcessingPayment = false;
        });

        if (success) {
          // Başarılı ödeme sonrası sepeti temizle
          ref.read(cartProvider.notifier).clearCart();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ödeme başarılı! Siparişiniz alındı.'),
              backgroundColor: AppColors.success,
            ),
          );

          // Sipariş sayfasına yönlendir
          context.go('/orders');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Ödeme işlemi başarısız oldu. Lütfen tekrar deneyin.'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessingPayment = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ödeme hatası: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sepeti Temizle'),
          content: const Text(
              'Sepetteki tüm ürünleri silmek istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                ref.read(cartProvider.notifier).clearCart();
                Navigator.of(context).pop();
              },
              child: const Text('Temizle'),
            ),
          ],
        );
      },
    );
  }
}

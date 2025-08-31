import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

class AddPaymentCardScreen extends StatefulWidget {
  final bool isEditing;
  final Map<String, dynamic>? cardData;

  const AddPaymentCardScreen({
    super.key,
    this.isEditing = false,
    this.cardData,
  });

  @override
  State<AddPaymentCardScreen> createState() => _AddPaymentCardScreenState();
}

class _AddPaymentCardScreenState extends State<AddPaymentCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryMonthController = TextEditingController();
  final _expiryYearController = TextEditingController();
  final _cvvController = TextEditingController();

  String _selectedCardType = 'Visa';
  bool _isDefault = false;
  bool _isLoading = false;

  final List<String> _cardTypes = ['Visa', 'Mastercard', 'American Express'];
  final List<String> _months = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];
  final List<String> _years = ['24', '25', '26', '27', '28', '29', '30'];

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.cardData != null) {
      _selectedCardType = widget.cardData!['cardType'] ?? 'Visa';
      _cardNumberController.text = widget.cardData!['cardNumber'] ?? '';
      _cardHolderController.text = widget.cardData!['cardHolder'] ?? '';
      _expiryMonthController.text = widget.cardData!['expiryMonth'] ?? '';
      _expiryYearController.text = widget.cardData!['expiryYear'] ?? '';
      _cvvController.text = widget.cardData!['cvv'] ?? '';
      _isDefault = widget.cardData!['isDefault'] ?? false;
    }
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryMonthController.dispose();
    _expiryYearController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Kartı Düzenle' : 'Yeni Kart Ekle'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kart Önizleme
              _buildCardPreview(),

              const SizedBox(height: AppConstants.paddingLarge),

              // Kart Tipi Seçimi
              _buildSectionHeader('Kart Tipi'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius:
                      BorderRadius.circular(AppConstants.radiusMedium),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCardType,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    items: _cardTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCardType = newValue!;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: AppConstants.paddingMedium),

              // Kart Numarası
              _buildSectionHeader('Kart Numarası'),
              TextFormField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  _CardNumberFormatter(),
                ],
                decoration: InputDecoration(
                  hintText: '0000 0000 0000 0000',
                  prefixIcon: const Icon(Icons.credit_card),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppConstants.radiusMedium),
                  ),
                  filled: true,
                  fillColor: AppColors.surface,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kart numarası gerekli';
                  }
                  if (value.replaceAll(' ', '').length < 13) {
                    return 'Geçerli bir kart numarası girin';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),

              const SizedBox(height: AppConstants.paddingMedium),

              // Kart Sahibi
              _buildSectionHeader('Kart Sahibi'),
              TextFormField(
                controller: _cardHolderController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: 'Ad Soyad',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppConstants.radiusMedium),
                  ),
                  filled: true,
                  fillColor: AppColors.surface,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kart sahibi adı gerekli';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),

              const SizedBox(height: AppConstants.paddingMedium),

              // Son Kullanma Tarihi ve CVV
              Row(
                children: [
                  // Ay
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Ay'),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(
                                AppConstants.radiusMedium),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _expiryMonthController.text.isEmpty
                                  ? null
                                  : _expiryMonthController.text,
                              isExpanded: true,
                              hint: const Text('Ay'),
                              icon: const Icon(Icons.arrow_drop_down),
                              items: _months.map((String month) {
                                return DropdownMenuItem<String>(
                                  value: month,
                                  child: Text(month),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _expiryMonthController.text = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: AppConstants.paddingMedium),

                  // Yıl
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Yıl'),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(
                                AppConstants.radiusMedium),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _expiryYearController.text.isEmpty
                                  ? null
                                  : _expiryYearController.text,
                              isExpanded: true,
                              hint: const Text('Yıl'),
                              icon: const Icon(Icons.arrow_drop_down),
                              items: _years.map((String year) {
                                return DropdownMenuItem<String>(
                                  value: year,
                                  child: Text('20$year'),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _expiryYearController.text = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: AppConstants.paddingMedium),

                  // CVV
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('CVV'),
                        TextFormField(
                          controller: _cvvController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          decoration: InputDecoration(
                            hintText: '123',
                            prefixIcon: const Icon(Icons.security),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  AppConstants.radiusMedium),
                            ),
                            filled: true,
                            fillColor: AppColors.surface,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'CVV gerekli';
                            }
                            if (value.length < 3) {
                              return 'Geçerli CVV girin';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppConstants.paddingMedium),

              // Varsayılan Kart
              Row(
                children: [
                  Checkbox(
                    value: _isDefault,
                    onChanged: (bool? value) {
                      setState(() {
                        _isDefault = value ?? false;
                      });
                    },
                    activeColor: AppColors.primary,
                  ),
                  const Text('Bu kartı varsayılan kart olarak ayarla'),
                ],
              ),

              const SizedBox(height: AppConstants.paddingLarge),

              // Kaydet Butonu
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveCard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMedium),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          widget.isEditing ? 'Kartı Güncelle' : 'Kartı Kaydet',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              // Bottom padding to prevent overlap with bottom navigation bar
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
      ),
    );
  }

  Widget _buildCardPreview() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  _getCardTypeIcon(_selectedCardType),
                  color: Colors.white,
                  size: 32,
                ),
                if (_isDefault)
                  Container(
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
              ],
            ),
            const Spacer(),
            Text(
              _cardNumberController.text.isEmpty
                  ? '**** **** **** ****'
                  : _cardNumberController.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kart Sahibi',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      _cardHolderController.text.isEmpty
                          ? 'Ad Soyad'
                          : _cardHolderController.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Son Kullanma',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      _expiryMonthController.text.isEmpty ||
                              _expiryYearController.text.isEmpty
                          ? 'MM/YY'
                          : '${_expiryMonthController.text}/${_expiryYearController.text}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCardTypeIcon(String cardType) {
    switch (cardType.toLowerCase()) {
      case 'visa':
        return Icons.credit_card;
      case 'mastercard':
        return Icons.credit_card;
      case 'american express':
        return Icons.credit_card;
      default:
        return Icons.credit_card;
    }
  }

  void _saveCard() async {
    if (!_formKey.currentState!.validate()) return;

    // Son kullanma tarihi validasyonu
    if (_expiryMonthController.text.isEmpty ||
        _expiryYearController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen son kullanma tarihini seçin'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simüle edilmiş kaydetme gecikmesi
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      // Create card data to return
      final cardData = {
        'id': widget.isEditing
            ? widget.cardData!['id']
            : DateTime.now().millisecondsSinceEpoch.toString(),
        'cardType': _selectedCardType,
        'cardNumber': _cardNumberController.text,
        'cardHolder': _cardHolderController.text,
        'expiryMonth': _expiryMonthController.text,
        'expiryYear': _expiryYearController.text,
        'cvv': _cvvController.text,
        'isDefault': _isDefault,
      };

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.isEditing
              ? 'Kart başarıyla güncellendi!'
              : 'Kart başarıyla kaydedildi!'),
          backgroundColor: AppColors.success,
        ),
      );

      Navigator.of(context).pop(cardData);
    }
  }
}

// Kart numarası formatlayıcı
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final text = newValue.text.replaceAll(' ', '');
    final formatted = _formatCardNumber(text);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _formatCardNumber(String text) {
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }
    return buffer.toString();
  }
}

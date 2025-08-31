import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../services/address_service.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({super.key});

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController(text: 'Mert Sevinç');
  final _phoneController = TextEditingController(text: '+90 555 123 4567');
  final _cityController = TextEditingController(text: 'İstanbul');
  final _districtController = TextEditingController(text: 'Kadıköy');
  final _neighborhoodController = TextEditingController(text: 'Fenerbahçe');
  final _streetController = TextEditingController(text: 'Atatürk Caddesi');
  final _buildingController = TextEditingController(text: 'No: 123');
  final _apartmentController = TextEditingController(text: 'Daire: 5');
  final _postalCodeController = TextEditingController(text: '34726');
  final _addressNoteController = TextEditingController();

  bool _isDefault = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSavedAddress();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _neighborhoodController.dispose();
    _streetController.dispose();
    _buildingController.dispose();
    _apartmentController.dispose();
    _postalCodeController.dispose();
    _addressNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Teslimat Adresi'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        actions: [
          IconButton(
            onPressed: _isLoading ? null : _saveAddress,
            icon: const Icon(Icons.save),
            tooltip: 'Kaydet',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppConstants.paddingLarge),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppConstants.radiusMedium),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.primary,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Teslimat Adresiniz',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Siparişlerinizin teslim edileceği adresi belirtin',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppConstants.paddingLarge),

              // Kişisel Bilgiler
              _buildSectionHeader('Kişisel Bilgiler'),
              _buildTextField(
                controller: _fullNameController,
                label: 'Ad Soyad',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ad soyad gerekli';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _phoneController,
                label: 'Telefon Numarası',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Telefon numarası gerekli';
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppConstants.paddingMedium),

              // Adres Bilgileri
              _buildSectionHeader('Adres Bilgileri'),
              _buildTextField(
                controller: _cityController,
                label: 'İl',
                icon: Icons.location_city,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'İl gerekli';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _districtController,
                label: 'İlçe',
                icon: Icons.location_on,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'İlçe gerekli';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _neighborhoodController,
                label: 'Mahalle',
                icon: Icons.home,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mahalle gerekli';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _streetController,
                label: 'Cadde/Sokak',
                icon: Icons.streetview,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Cadde/Sokak gerekli';
                  }
                  return null;
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _buildingController,
                      label: 'Bina No',
                      icon: Icons.business,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bina no gerekli';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: AppConstants.paddingMedium),
                  Expanded(
                    child: _buildTextField(
                      controller: _apartmentController,
                      label: 'Daire No',
                      icon: Icons.home_work,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Daire no gerekli';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              _buildTextField(
                controller: _postalCodeController,
                label: 'Posta Kodu',
                icon: Icons.markunread_mailbox,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Posta kodu gerekli';
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppConstants.paddingMedium),

              // Adres Notu
              _buildSectionHeader('Adres Notu (Opsiyonel)'),
              _buildTextField(
                controller: _addressNoteController,
                label: 'Teslimat için özel notlar',
                icon: Icons.note,
                maxLines: 3,
                hintText: 'Örn: Kapıcıya bırakabilir, 3. katta...',
              ),

              const SizedBox(height: AppConstants.paddingMedium),

              // Varsayılan Adres
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
                  Expanded(
                    child: Text(
                      'Bu adresi varsayılan teslimat adresi olarak ayarla',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppConstants.paddingLarge),

              // Kaydet Butonu
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveAddress,
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
                      : const Text(
                          'Adresi Kaydet',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              // Bottom padding to prevent overlap with bottom navigation bar
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? hintText,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: Icon(icon, color: AppColors.primary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          filled: true,
          fillColor: AppColors.surface,
        ),
      ),
    );
  }

  // Kaydedilmiş adresi yükle
  Future<void> _loadSavedAddress() async {
    try {
      final savedAddress = await AddressService.loadDeliveryAddress();
      if (savedAddress != null) {
        setState(() {
          _fullNameController.text = savedAddress['fullName'] ?? '';
          _phoneController.text = savedAddress['phone'] ?? '';
          _cityController.text = savedAddress['city'] ?? '';
          _districtController.text = savedAddress['district'] ?? '';
          _neighborhoodController.text = savedAddress['neighborhood'] ?? '';
          _streetController.text = savedAddress['street'] ?? '';
          _buildingController.text = savedAddress['building'] ?? '';
          _apartmentController.text = savedAddress['apartment'] ?? '';
          _postalCodeController.text = savedAddress['postalCode'] ?? '';
          _addressNoteController.text = savedAddress['addressNote'] ?? '';
          _isDefault = savedAddress['isDefault'] ?? true;
        });
      }
    } catch (e) {
      print('Kaydedilmiş adres yüklenirken hata: $e');
    }
  }

  void _saveAddress() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Adresi gerçekten kaydet
      await AddressService.saveDeliveryAddress(
        fullName: _fullNameController.text.trim(),
        phone: _phoneController.text.trim(),
        city: _cityController.text.trim(),
        district: _districtController.text.trim(),
        neighborhood: _neighborhoodController.text.trim(),
        street: _streetController.text.trim(),
        building: _buildingController.text.trim(),
        apartment: _apartmentController.text.trim(),
        postalCode: _postalCodeController.text.trim(),
        addressNote: _addressNoteController.text.trim(),
        isDefault: _isDefault,
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Teslimat adresi başarıyla kaydedildi!'),
            backgroundColor: AppColors.success,
          ),
        );

        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Adres kaydedilirken hata oluştu: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}

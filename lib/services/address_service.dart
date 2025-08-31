import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AddressService {
  static const String _storageKey = 'delivery_address';
  
  // Adres verisi modeli
  static Future<void> saveDeliveryAddress({
    required String fullName,
    required String phone,
    required String city,
    required String district,
    required String neighborhood,
    required String street,
    required String building,
    required String apartment,
    required String postalCode,
    String? addressNote,
    required bool isDefault,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final addressData = {
        'fullName': fullName,
        'phone': phone,
        'city': city,
        'district': district,
        'neighborhood': neighborhood,
        'street': street,
        'building': building,
        'apartment': apartment,
        'postalCode': postalCode,
        'addressNote': addressNote ?? '',
        'isDefault': isDefault,
        'savedAt': DateTime.now().toIso8601String(),
      };
      
      await prefs.setString(_storageKey, jsonEncode(addressData));
    } catch (e) {
      print('Adres kaydedilirken hata: $e');
      rethrow;
    }
  }
  
  // Kaydedilmiş adresi yükle
  static Future<Map<String, dynamic>?> loadDeliveryAddress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final addressJson = prefs.getString(_storageKey);
      
      if (addressJson != null) {
        return jsonDecode(addressJson) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      print('Adres yüklenirken hata: $e');
      return null;
    }
  }
  
  // Varsayılan adres var mı kontrol et
  static Future<bool> hasDefaultAddress() async {
    final address = await loadDeliveryAddress();
    return address != null && address['isDefault'] == true;
  }
  
  // Adresi sil
  static Future<void> deleteDeliveryAddress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_storageKey);
    } catch (e) {
      print('Adres silinirken hata: $e');
      rethrow;
    }
  }
}

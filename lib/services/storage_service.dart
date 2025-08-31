import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../config/supabase_config.dart';

class StorageService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final ImagePicker _imagePicker = ImagePicker();

  // Ürün resmi yükle
  Future<String> uploadProductImage({
    required File imageFile,
    required String productId,
    String? customFileName,
  }) async {
    try {
      final fileExt = imageFile.path.split('.').last;
      final fileName =
          customFileName ?? '${DateTime.now().millisecondsSinceEpoch}.$fileExt';
      final filePath = 'products/$productId/$fileName';

      await _supabase.storage
          .from(SupabaseConfig.productImagesBucket)
          .upload(filePath, imageFile);

      final imageUrl = _supabase.storage
          .from(SupabaseConfig.productImagesBucket)
          .getPublicUrl(filePath);

      return imageUrl;
    } catch (e) {
      throw Exception('Failed to upload product image: $e');
    }
  }

  // Birden fazla ürün resmi yükle
  Future<List<String>> uploadProductImages({
    required List<File> imageFiles,
    required String productId,
  }) async {
    try {
      final List<String> imageUrls = [];

      for (int i = 0; i < imageFiles.length; i++) {
        final imageUrl = await uploadProductImage(
          imageFile: imageFiles[i],
          productId: productId,
          customFileName: 'image_$i.jpg',
        );
        imageUrls.add(imageUrl);
      }

      return imageUrls;
    } catch (e) {
      throw Exception('Failed to upload product images: $e');
    }
  }

  // Kullanıcı avatar resmi yükle
  Future<String> uploadUserAvatar({
    required File imageFile,
    required String userId,
  }) async {
    try {
      final fileExt = imageFile.path.split('.').last;
      final fileName =
          'avatar_${DateTime.now().millisecondsSinceEpoch}.$fileExt';
      final filePath = 'avatars/$userId/$fileName';

      await _supabase.storage
          .from(SupabaseConfig.userAvatarsBucket)
          .upload(filePath, imageFile);

      final imageUrl = _supabase.storage
          .from(SupabaseConfig.userAvatarsBucket)
          .getPublicUrl(filePath);

      return imageUrl;
    } catch (e) {
      throw Exception('Failed to upload user avatar: $e');
    }
  }

  // Kategori resmi yükle
  Future<String> uploadCategoryImage({
    required File imageFile,
    required String categoryId,
  }) async {
    try {
      final fileExt = imageFile.path.split('.').last;
      final fileName =
          'category_${DateTime.now().millisecondsSinceEpoch}.$fileExt';
      final filePath = 'categories/$categoryId/$fileName';

      await _supabase.storage
          .from(SupabaseConfig.productImagesBucket)
          .upload(filePath, imageFile);

      final imageUrl = _supabase.storage
          .from(SupabaseConfig.productImagesBucket)
          .getPublicUrl(filePath);

      return imageUrl;
    } catch (e) {
      throw Exception('Failed to upload category image: $e');
    }
  }

  // Resim sil
  Future<void> deleteImage({
    required String bucketName,
    required String filePath,
  }) async {
    try {
      await _supabase.storage.from(bucketName).remove([filePath]);
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }

  // Ürün resimlerini sil
  Future<void> deleteProductImages({
    required String productId,
  }) async {
    try {
      final List<FileObject> files = await _supabase.storage
          .from(SupabaseConfig.productImagesBucket)
          .list(path: 'products/$productId/');

      if (files.isNotEmpty) {
        final filePaths = files.map((file) => file.name).toList();
        await _supabase.storage
            .from(SupabaseConfig.productImagesBucket)
            .remove(filePaths);
      }
    } catch (e) {
      throw Exception('Failed to delete product images: $e');
    }
  }

  // Kullanıcı avatar resmini sil
  Future<void> deleteUserAvatar({
    required String userId,
  }) async {
    try {
      final List<FileObject> files = await _supabase.storage
          .from(SupabaseConfig.userAvatarsBucket)
          .list(path: 'avatars/$userId/');

      if (files.isNotEmpty) {
        final filePaths = files.map((file) => file.name).toList();
        await _supabase.storage
            .from(SupabaseConfig.userAvatarsBucket)
            .remove(filePaths);
      }
    } catch (e) {
      throw Exception('Failed to delete user avatar: $e');
    }
  }

  // Galeriden resim seç
  Future<File?> pickImageFromGallery({
    int imageQuality = 80,
    double maxWidth = 1024,
    double maxHeight = 1024,
  }) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to pick image from gallery: $e');
    }
  }

  // Kameradan resim çek
  Future<File?> takePhotoWithCamera({
    int imageQuality = 80,
    double maxWidth = 1024,
    double maxHeight = 1024,
  }) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: imageQuality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to take photo with camera: $e');
    }
  }

  // Birden fazla resim seç
  Future<List<File>> pickMultipleImages({
    int imageQuality = 80,
    double maxWidth = 1024,
    double maxHeight = 1024,
    int maxImages = 10,
  }) async {
    try {
      final List<XFile> pickedFiles = await _imagePicker.pickMultiImage(
        imageQuality: imageQuality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      );

      if (pickedFiles.length > maxImages) {
        pickedFiles.removeRange(maxImages, pickedFiles.length);
      }

      return pickedFiles.map((xFile) => File(xFile.path)).toList();
    } catch (e) {
      throw Exception('Failed to pick multiple images: $e');
    }
  }

  // Resim boyutunu optimize et
  Future<File> optimizeImage({
    required File imageFile,
    int quality = 80,
    double maxWidth = 1024,
    double maxHeight = 1024,
  }) async {
    try {
      // Bu kısımda resim optimizasyonu yapılabilir
      // Örneğin: resim boyutunu küçültme, sıkıştırma vb.
      // Şimdilik orijinal dosyayı döndürüyoruz
      return imageFile;
    } catch (e) {
      throw Exception('Failed to optimize image: $e');
    }
  }

  // Resim URL'ini geçerli mi kontrol et
  Future<bool> isImageUrlValid(String imageUrl) async {
    try {
      final response = _supabase.storage
          .from(SupabaseConfig.productImagesBucket)
          .getPublicUrl(imageUrl);

      // URL'i test et
      final httpResponse = await http.get(Uri.parse(response));
      return httpResponse.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Storage bucket'ları oluştur
  Future<void> createStorageBuckets() async {
    try {
      // Bu işlem admin yetkisi gerektirir
      // Supabase dashboard'dan manuel olarak yapılmalı
      print(
          'Storage buckets should be created manually from Supabase dashboard');
    } catch (e) {
      throw Exception('Failed to create storage buckets: $e');
    }
  }

  // Storage policy'leri ayarla
  Future<void> setupStoragePolicies() async {
    try {
      // Bu işlem admin yetkisi gerektirir
      // Supabase dashboard'dan manuel olarak yapılmalı
      print(
          'Storage policies should be set up manually from Supabase dashboard');
    } catch (e) {
      throw Exception('Failed to setup storage policies: $e');
    }
  }
}

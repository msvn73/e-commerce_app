import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaService {
  static final ImagePicker _imagePicker = ImagePicker();

  // Request permissions
  static Future<bool> requestPermissions() async {
    final cameraStatus = await Permission.camera.request();
    final storageStatus = await Permission.storage.request();
    final photosStatus = await Permission.photos.request();
    final videosStatus = await Permission.videos.request();

    return cameraStatus.isGranted && 
           (storageStatus.isGranted || photosStatus.isGranted || videosStatus.isGranted);
  }

  // Pick images from gallery
  static Future<List<XFile>?> pickImagesFromGallery() async {
    try {
      final hasPermission = await requestPermissions();
      if (!hasPermission) {
        throw Exception('Medya erişim izni gerekli');
      }

      final List<XFile> images = await _imagePicker.pickMultiImage();
      return images.isNotEmpty ? images : null;
    } catch (e) {
      throw Exception('Fotoğraf seçilirken hata oluştu: $e');
    }
  }

  // Take photo with camera
  static Future<XFile?> takePhotoWithCamera() async {
    try {
      final hasPermission = await requestPermissions();
      if (!hasPermission) {
        throw Exception('Kamera erişim izni gerekli');
      }

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      return image;
    } catch (e) {
      throw Exception('Fotoğraf çekilirken hata oluştu: $e');
    }
  }

  // Pick videos from gallery
  static Future<List<PlatformFile>?> pickVideosFromGallery() async {
    try {
      final hasPermission = await requestPermissions();
      if (!hasPermission) {
        throw Exception('Medya erişim izni gerekli');
      }

      final result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files;
      }
      return null;
    } catch (e) {
      throw Exception('Video seçilirken hata oluştu: $e');
    }
  }

  // Show image source selection dialog
  static Future<List<XFile>?> showImageSourceDialog(BuildContext context) async {
    return showDialog<List<XFile>?>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Fotoğraf Ekle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeriden Seç'),
              onTap: () async {
                Navigator.of(context).pop();
                final images = await pickImagesFromGallery();
                if (images != null && context.mounted) {
                  Navigator.of(context).pop(images);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Kamera ile Çek'),
              onTap: () async {
                Navigator.of(context).pop();
                final image = await takePhotoWithCamera();
                if (image != null && context.mounted) {
                  Navigator.of(context).pop([image]);
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
        ],
      ),
    );
  }

  // Show video source selection dialog
  static Future<List<PlatformFile>?> showVideoSourceDialog(BuildContext context) async {
    return showDialog<List<PlatformFile>?>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Video Ekle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.video_library),
              title: const Text('Galeriden Seç'),
              onTap: () async {
                Navigator.of(context).pop();
                final videos = await pickVideosFromGallery();
                if (videos != null && context.mounted) {
                  Navigator.of(context).pop(videos);
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
        ],
      ),
    );
  }

  // Convert XFile to File
  static File? xFileToFile(XFile xFile) {
    try {
      return File(xFile.path);
    } catch (e) {
      return null;
    }
  }

  // Get file size in MB
  static double getFileSizeInMB(File file) {
    try {
      final bytes = file.lengthSync();
      return bytes / (1024 * 1024);
    } catch (e) {
      return 0.0;
    }
  }

  // Validate image file
  static bool isValidImageFile(File file) {
    final extension = file.path.toLowerCase().split('.').last;
    return ['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(extension);
  }

  // Validate video file
  static bool isValidVideoFile(File file) {
    final extension = file.path.toLowerCase().split('.').last;
    return ['mp4', 'avi', 'mov', 'wmv', 'flv', 'webm'].contains(extension);
  }
}

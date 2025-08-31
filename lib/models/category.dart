import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final String imageUrl;
  final int productCount;
  final bool isSelected;

  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.imageUrl,
    this.productCount = 0,
    this.isSelected = false,
  });

  Category copyWith({
    String? id,
    String? name,
    String? description,
    IconData? icon,
    Color? color,
    String? imageUrl,
    int? productCount,
    bool? isSelected,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      imageUrl: imageUrl ?? this.imageUrl,
      productCount: productCount ?? this.productCount,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

// Predefined categories with modern design
class CategoryData {
  static final List<Category> categories = [
    const Category(
      id: '0',
      name: 'Tümü',
      description: 'Tüm ürünleri keşfedin',
      icon: Icons.all_inclusive,
      color: Color(0xFF9C27B0),
      imageUrl:
          'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400',
      productCount: 1015,
      isSelected: true,
    ),
    const Category(
      id: '1',
      name: 'Elektronik',
      description: 'Telefon, bilgisayar ve teknoloji ürünleri',
      icon: Icons.devices,
      color: Color(0xFF2196F3),
      imageUrl:
          'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=400',
      productCount: 156,
    ),
    const Category(
      id: '2',
      name: 'Giyim',
      description: 'Kadın, erkek ve çocuk giyim',
      icon: Icons.checkroom,
      color: Color(0xFFE91E63),
      imageUrl:
          'https://images.unsplash.com/photo-1445205170230-053b83016050?w=400',
      productCount: 324,
    ),
    const Category(
      id: '3',
      name: 'Ev & Yaşam',
      description: 'Ev dekorasyonu ve yaşam ürünleri',
      icon: Icons.home,
      color: Color(0xFF4CAF50),
      imageUrl:
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400',
      productCount: 89,
    ),
    const Category(
      id: '4',
      name: 'Spor',
      description: 'Spor giyim ve ekipmanları',
      icon: Icons.fitness_center,
      color: Color(0xFFFF9800),
      imageUrl:
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
      productCount: 67,
    ),
    const Category(
      id: '5',
      name: 'Kitaplar',
      description: 'Kitap, dergi ve eğitim materyalleri',
      icon: Icons.menu_book,
      color: Color(0xFF9C27B0),
      imageUrl:
          'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400',
      productCount: 234,
    ),
    const Category(
      id: '6',
      name: 'Kozmetik',
      description: 'Güzellik ve kişisel bakım ürünleri',
      icon: Icons.face_retouching_natural,
      color: Color(0xFFF44336),
      imageUrl:
          'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=400',
      productCount: 145,
    ),
  ];
}

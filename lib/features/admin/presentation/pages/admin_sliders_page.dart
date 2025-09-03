import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import '../../../../core/models/slider_model.dart';
import '../../../../core/providers/sliders_provider.dart';
import '../../../../core/providers/categories_provider.dart';
import '../../../../core/providers/products_provider.dart';
import '../../../../core/services/media_service.dart';

class AdminSlidersPage extends ConsumerStatefulWidget {
  const AdminSlidersPage({super.key});

  @override
  ConsumerState<AdminSlidersPage> createState() => _AdminSlidersPageState();
}

class _AdminSlidersPageState extends ConsumerState<AdminSlidersPage> {
  @override
  void initState() {
    super.initState();
    // Load sliders, categories and products when page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(slidersProvider.notifier).loadSliders();
      ref.read(categoriesProvider.notifier).loadCategories();
      ref.read(productsProvider.notifier).loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final slidersState = ref.watch(slidersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider Yönetimi'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddSliderDialog();
            },
          ),
        ],
      ),
      body: slidersState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : slidersState.sliders.isEmpty
              ? _buildEmptySliders()
              : _buildSlidersList(slidersState.sliders),
    );
  }

  Widget _buildEmptySliders() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.slideshow_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz slider eklenmemiş',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ana sayfa slider\'larını yönetmek için yeni slider ekleyin',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade500,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              _showAddSliderDialog();
            },
            icon: const Icon(Icons.add),
            label: const Text('İlk Slider\'ı Ekle'),
          ),
        ],
      ),
    );
  }

  Widget _buildSlidersList(List<SliderModel> sliders) {
    return ReorderableListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sliders.length,
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final reorderedSliders = List<SliderModel>.from(sliders);
        final item = reorderedSliders.removeAt(oldIndex);
        reorderedSliders.insert(newIndex, item);
        ref.read(slidersProvider.notifier).reorderSliders(reorderedSliders);
      },
      itemBuilder: (context, index) {
        final slider = sliders[index];
        return _buildSliderCard(slider, index);
      },
    );
  }

  Widget _buildSliderCard(SliderModel slider, int index) {
    return Card(
      key: ValueKey(slider.id),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey.shade200,
          backgroundImage:
              slider.imageUrl.isNotEmpty ? NetworkImage(slider.imageUrl) : null,
          child: slider.imageUrl.isEmpty
              ? const Icon(Icons.image, size: 30)
              : null,
        ),
        title: Text(
          slider.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (slider.description?.isNotEmpty == true)
              Text(
                slider.description!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  _getTargetTypeIcon(slider.targetType),
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  _getTargetTypeText(slider.targetType),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: slider.isActive ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    slider.isActive ? 'Aktif' : 'Pasif',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange),
              onPressed: () {
                _showEditSliderDialog(slider);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _showDeleteSliderDialog(slider);
              },
            ),
            const Icon(Icons.drag_handle, color: Colors.grey),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  IconData _getTargetTypeIcon(String targetType) {
    switch (targetType) {
      case 'category':
        return Icons.category;
      case 'product':
        return Icons.inventory;
      case 'page':
        return Icons.pageview;
      default:
        return Icons.link;
    }
  }

  String _getTargetTypeText(String targetType) {
    switch (targetType) {
      case 'category':
        return 'Kategori';
      case 'product':
        return 'Ürün';
      case 'page':
        return 'Sayfa';
      default:
        return 'URL';
    }
  }

  void _showAddSliderDialog() {
    _showSliderDialog();
  }

  void _showEditSliderDialog(SliderModel slider) {
    _showSliderDialog(slider: slider);
  }

  void _showSliderDialog({SliderModel? slider}) {
    final titleController = TextEditingController(text: slider?.title ?? '');
    final descriptionController =
        TextEditingController(text: slider?.description ?? '');
    final targetUrlController =
        TextEditingController(text: slider?.targetUrl ?? '');

    String selectedTargetType = slider?.targetType ?? 'page';
    String? selectedTargetId = slider?.targetId;
    String? selectedImagePath = slider?.imageUrl;
    bool isActive = slider?.isActive ?? true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(slider == null ? 'Yeni Slider Ekle' : 'Slider Düzenle'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image Selection
                GestureDetector(
                  onTap: () async {
                    try {
                      final images =
                          await MediaService.showImageSourceDialog(context);
                      if (images != null && images.isNotEmpty) {
                        final file = MediaService.xFileToFile(images.first);
                        if (file != null) {
                          setState(() {
                            selectedImagePath = file.path;
                          });
                        }
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Resim seçme hatası: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: selectedImagePath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: selectedImagePath!.startsWith('http')
                                ? Image.network(
                                    selectedImagePath!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(Icons.error, size: 50),
                                      );
                                    },
                                  )
                                : Image.file(
                                    File(selectedImagePath!),
                                    fit: BoxFit.cover,
                                  ),
                          )
                        : const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate, size: 40),
                                SizedBox(height: 8),
                                Text('Resim Seç'),
                              ],
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                // Title
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Başlık *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                ),
                const SizedBox(height: 16),

                // Description
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Açıklama',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),

                // Target Type
                DropdownButtonFormField<String>(
                  value: selectedTargetType,
                  decoration: const InputDecoration(
                    labelText: 'Hedef Türü *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.link),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'page', child: Text('Sayfa')),
                    DropdownMenuItem(
                        value: 'category', child: Text('Kategori')),
                    DropdownMenuItem(value: 'product', child: Text('Ürün')),
                    DropdownMenuItem(value: 'url', child: Text('Dış URL')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedTargetType = value!;
                      selectedTargetId = null;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Target URL (for external URLs)
                if (selectedTargetType == 'url')
                  TextField(
                    controller: targetUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Hedef URL *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.link),
                      hintText: 'https://example.com',
                    ),
                  ),

                // Category Selection (for category targets)
                if (selectedTargetType == 'category')
                  Consumer(
                    builder: (context, ref, child) {
                      final categoriesState = ref.watch(categoriesProvider);
                      return DropdownButtonFormField<String>(
                        value: selectedTargetId,
                        decoration: const InputDecoration(
                          labelText: 'Hedef Kategori *',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.category),
                        ),
                        items: categoriesState.categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category.id,
                            child: Text(category.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedTargetId = value;
                          });
                        },
                      );
                    },
                  ),

                // Product Selection (for product targets)
                if (selectedTargetType == 'product')
                  Consumer(
                    builder: (context, ref, child) {
                      final productsState = ref.watch(productsProvider);
                      return DropdownButtonFormField<String>(
                        value: selectedTargetId,
                        decoration: const InputDecoration(
                          labelText: 'Hedef Ürün *',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.shopping_bag),
                        ),
                        items: productsState.products.map((product) {
                          return DropdownMenuItem<String>(
                            value: product.id,
                            child: Text(product.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedTargetId = value;
                          });
                        },
                      );
                    },
                  ),

                const SizedBox(height: 16),

                // Active Status
                SwitchListTile(
                  title: const Text('Aktif'),
                  subtitle: const Text('Slider görünür olacak'),
                  value: isActive,
                  onChanged: (value) {
                    setState(() {
                      isActive = value;
                    });
                  },
                  activeColor: Colors.green,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Başlık gereklidir'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (selectedImagePath == null || selectedImagePath!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Resim gereklidir'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (selectedTargetType == 'url' &&
                    targetUrlController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Hedef URL gereklidir'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (selectedTargetType == 'category' &&
                    selectedTargetId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Hedef kategori seçilmelidir'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (selectedTargetType == 'product' &&
                    selectedTargetId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Hedef ürün seçilmelidir'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                Navigator.of(context).pop();

                final newSlider = SliderModel(
                  id: slider?.id ?? '',
                  title: titleController.text.trim(),
                  description: descriptionController.text.trim().isEmpty
                      ? null
                      : descriptionController.text.trim(),
                  imageUrl: selectedImagePath!,
                  targetType: selectedTargetType,
                  targetId: selectedTargetId,
                  targetUrl: selectedTargetType == 'url'
                      ? targetUrlController.text.trim()
                      : null,
                  isActive: isActive,
                  order: slider?.order ?? 0,
                  createdAt: slider?.createdAt ?? DateTime.now(),
                  updatedAt: DateTime.now(),
                );

                try {
                  if (slider == null) {
                    await ref
                        .read(slidersProvider.notifier)
                        .addSlider(newSlider);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Slider başarıyla eklendi'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  } else {
                    await ref
                        .read(slidersProvider.notifier)
                        .updateSlider(slider.id, newSlider);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Slider başarıyla güncellendi'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Hata: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: Text(slider == null ? 'Ekle' : 'Güncelle'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteSliderDialog(SliderModel slider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Slider\'ı Sil'),
        content: Text(
            '${slider.title} slider\'ını silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();

              try {
                await ref
                    .read(slidersProvider.notifier)
                    .deleteSlider(slider.id);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Slider başarıyla silindi'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Hata: ${e.toString()}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }
}
